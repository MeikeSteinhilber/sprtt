# SET SIMULATION SETTINGS ------------------------------------------------------
library(doParallel)
library(foreach)

start <- Sys.time()

## set seed --------------------------------------------------------------------
set.seed(333)


## start sink ------------------------------------------------------------------
name_file_output <- "output.txt"
name_file_message <- "message.txt"
file_output <- file(name_file_output, open = "wt")
file_message <- file(name_file_message, open = "wt")
sink(file_output, type = "output", append = TRUE)
sink(file_message, type = "message", append = TRUE)


## set up parallel backend -----------------------------------------------------
n_cores <- detectCores()
cluster = parallel::makeCluster(n_cores - 1)
registerDoParallel(cluster)

# SIMULATION -------------------------------------------------------------------

## sample data -----------------------------------------------------------------

sample_data <- function(n, d) {
  y <- rnorm(n * 2, mean = c(d, 0))
  x <- rep(c(0, 1), n)
  matrix( c(y, x), nrow = n*2, dimnames = list(NULL, c("y", "x")))
}

## simulation parameter --------------------------------------------------------
n_rep <- 10
alpha <- beta <- 0.05
d_exp_vec <- rep(c(0.2, 0.5, 0.8))
f_exp_vec <- rep(c(0.1, 0.25, 0.4))
n_cases_d <- length(unique(d_exp_vec))
d_sim_vec <- c(0, rep(unique(d_exp_vec), 1))

n_combinations <- n_cases_d * length(unique(d_sim_vec))

max_n <- 10000

results <- matrix(0, nrow = length(unique(d_exp_vec)), ncol = 9,
                  dimnames = list(NULL, c(
                    "d_sim",
                    "d_exp",
                    "decision_ttest",
                    "lr_ttest",
                    "n_ttest",
                    "f_exp",
                    "decision_anova",
                    "lr_anova",
                    "n_anova"
                  )))
comb_results <- matrix(0, nrow = nrow(results) * n_rep, ncol = 9,
                  dimnames = list(NULL, c(
                    "d_sim",
                    "d_exp",
                    "decision_ttest",
                    "lr_ttest",
                    "n_ttest",
                    "f_exp",
                    "decision_anova",
                    "lr_anova",
                    "n_anova"
                  )))

rep_results <- matrix(0, nrow = n_combinations * n_rep, ncol = 9,
                      dimnames = list(NULL, c(
                        "d_sim",
                        "d_exp",
                        "decision_ttest",
                        "lr_ttest",
                        "n_ttest",
                        "f_exp",
                        "decision_anova",
                        "lr_anova",
                        "n_anova"
                      )))

i <- 1

k <- 1
i_comb <- 1

simulation <-
  foreach(d_sim = d_sim_vec, .combine = "rbind") %dopar% {
  # for(d_sim in d_sim_vec) {
    for (rep in 1:n_rep) {

    # simulate data
    data <- sample_data(max_n, d_sim)

    i <- 1
    j <- 1

    for(d_exp in d_exp_vec) {
      f_exp <- f_exp_vec[j]
      ttest_stop <- TRUE
      anova_stop <- TRUE

        for(row in 3:nrow(data)) {
          seq_data <- as.data.frame(data[1:row, ])
          seq_data$x <- as.factor(seq_data$x)

          if (ttest_stop) {
            ttest_results <- sprtt::seq_ttest(y ~ x, data = seq_data, d = d_exp)
          }
          if (anova_stop) {
            # anova_results <- sprtt::seq_anova(y ~ x, data = seq_data, f = f_exp)
            anova_results <- sprtt::seq_ttest(y ~ x, data = seq_data, d = d_exp)
          }

          if (ttest_results@decision != "continue sampling" && ttest_stop) {
            decision <- ifelse(ttest_results@decision == "accept H1", 1, 0)
            final_ttest_results <- c(
              d_sim,
              d_exp,
              decision,
              ttest_results@likelihood_ratio_log,
              row
            )
            ttest_stop <- FALSE
          }
          if (anova_results@decision != "continue sampling" && anova_stop) {
            decision <- ifelse(anova_results@decision == "accept H1", 1, 0)
            final_anova_results <- c(
              f_exp,
              decision,
              anova_results@likelihood_ratio_log,
              row
            )
            anova_stop <- FALSE
          }
          if (ttest_results@decision != "continue sampling" &&
              anova_results@decision != "continue sampling") {
            # stop sequential process
            break
          }
        }#row
      results[i, ] <- c(final_ttest_results, final_anova_results)
      j <- j + 1
      i <- i + 1

    }#d_exp
    comb_results[i_comb:(i_comb + nrow(results) - 1), ] <- results
    i_comb <- i_comb + nrow(results)

    }#rep
    # rep_results[k:(k + nrow(comb_results) - 1), ] <- comb_results
    k <- k + nrow(comb_results)
    return(comb_results)
  }#foreach
sim <- simulation %>%
  as.data.frame() %>%
  arrange(d_sim, d_exp)

## save results ----------------------------------------------------------------


# END SIMULATION ---------------------------------------------------------------
end <- Sys.time()
duration <- difftime(end, start, units='auto')
duration

# close sink -------------------------------------------------------------------
## reset message sink and close the file connection
sink(type = "output")
sink(type = "message")
close(file_output)
close(file_message)
# file.show(name_file_output)
# file.show(name_file_message)

# file_output <- read.csv(name_file_output, sep = ";", header = FALSE)
# string_output <- toString(read.csv(name_file_output, sep = ";", header = FALSE))
# file <- read.csv(name_file_message, sep = ";", header = FALSE)
# string_message <- toString(read.csv(name_file_message, sep = ";", header = FALSE))


## shut down workers -----------------------------------------------------------
parallel::stopCluster(cluster)

## unset seed ------------------------------------------------------------------

set.seed(NULL)
