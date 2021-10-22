start <- Sys.time()
library(dplyr)

# set simulation parameter -----------------------------------------------------
set.seed(333)

f_sim <- c(0, 0, 0, 0.1, .25, 0.4)  # 0.1, 0.25, 0.4
f_exp <- rep(c(0.1, .25, 0.4), 2)
k_groups <- 4
max_n <- 20000
n_rep <- 100
alpha <- beta <- .05
A <- (1 - beta) / alpha
B <- beta / (1 - alpha)
seq_steps <- seq((2 * k_groups), (max_n * k_groups), k_groups)


sample_size <- numeric(n_rep * length(f_sim))
likelihood_ratio <- numeric(n_rep * length(f_sim))
decision <- numeric(n_rep * length(f_sim))
f_simulated <- numeric(n_rep * length(f_sim))
f_expected <- numeric(n_rep * length(f_sim))
sample_size_fixed <- numeric(n_rep * length(f_sim))
counter <- 1
j <- 1

# simulation -------------------------------------------------------------------
for (f in f_sim) {
  f_expec <- f_exp[j]

  for (i in 1:n_rep){
    # print(i)
    raw_means <- rnorm(k_groups)
    means = (raw_means - mean(raw_means)) / sd(raw_means) * sqrt(k_groups / (k_groups - 1)) * f
    y <- rnorm(max_n * k_groups, means)
    x <- factor(rep(1:k_groups, max_n))
    data <- data.frame(y, x)
    for (n in seq_steps) {
      anova_results <- sprtt::seq_anova(y ~ x, f = f_expec, data = data[1:n,])

      if (anova_results@decision != "continue sampling") {
        sample_size[counter] <- n
        likelihood_ratio[counter] <- anova_results@likelihood_ratio
        decision[counter] <- anova_results@decision
        f_simulated[counter] <- f
        f_expected[counter] <- f_expec
        if(f != 0) {
          power_analysis_n <- pwr::pwr.anova.test(k = k_groups, f = f, power = 1 - beta)$n
          sample_size_fixed[counter] <- round(power_analysis_n * k_groups)
        } else{
          sample_size_fixed[counter] <- NA
        }

        counter <<- counter + 1
        break
      }
    }
  }
  j <- j + 1
}
# check the simulation ---------------------------------------------------------
if(any(sample_size == 0)) {
  stop("error in anova simulation: increase max_n")
}


# save results in data frame ---------------------------------------------------
error_rates_anova_simulation <- data.frame(
  f_simulated,
  f_expected,
  likelihood_ratio,
  decision,
  sample_size_seq = sample_size,
  sample_size_fixed
)

## recode decision
error_rates_anova_simulation[decision == "accept H1", "decision"] <- 1
error_rates_anova_simulation[decision == "accept H0", "decision"] <- 0
error_rates_anova_simulation[decision == "continue sampling", "decision"] <- NA
error_rates_anova_simulation$decision <- as.numeric(
  error_rates_anova_simulation$decision
)

# analyse power ----------------------------------------------------------------
error_rates_anova_simulation <-
  error_rates_anova_simulation %>%
    dplyr::mutate(
      sample_smaller = .data$sample_size_seq < .data$sample_size_fixed
    )


# save simulation results ------------------------------------------------------
testthis::use_testdata(error_rates_anova_simulation, overwrite = TRUE)


##---- UNDO SET.SEED -----------------------------------------------------------

set.seed(NULL)


end <- Sys.time()
print(end - start)
