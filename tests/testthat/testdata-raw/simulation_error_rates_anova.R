start <- Sys.time()
library(dplyr)
path_expected <- tempfile(fileext = ".txt")
sink(path_expected)
# set simulation parameter -----------------------------------------------------
set.seed(333)

f_sim <- c(0, 0, 0, 0.1, .25, 0.4)  # 0.1, 0.25, 0.4
f_exp <- rep(c(0.1, .25, 0.4), 2)
k_groups <- 4
max_n <- 20000
n_rep <- 10
alpha <- beta <- .05
A <- (1 - beta) / alpha
B <- beta / (1 - alpha)
seq_steps <- seq((2 * k_groups), (max_n * k_groups), k_groups)

simulated_cases <- n_rep * length(f_sim)

sample_size <- numeric(simulated_cases)
likelihood_ratio <- numeric(simulated_cases)
decision <- numeric(simulated_cases)
f_simulated <- numeric(simulated_cases)
f_expected <- numeric(simulated_cases)
counter <- 1
j <- 1

# initialize matrix with parameters --------------------------------------------

# matrix <- matrix(nrow = n_rep * length(f_sim), ncol = 5)
# colnames(matrix) <- c("f_simulated", "f_expected", "LR", "decision", "Sample_size_seq")
#
# matrix[, 1] <- sort(rep(f_sim, n_rep))
# matrix[, 2] <- rep(sort(rep(f_exp, n_rep/2)), 2)


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
        # if(f != 0) {
        #   power_analysis_n <- pwr::pwr.anova.test(k = k_groups, f = f, power = 1 - beta)$n
        #   sample_size_fixed[counter] <- round(power_analysis_n * k_groups)
        # } else{
        #   sample_size_fixed[counter] <- NA
        # }

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
  sample_size_seq = sample_size
)

## recode decision
error_rates_anova_simulation[decision == "accept H1", "decision"] <- 1
error_rates_anova_simulation[decision == "accept H0", "decision"] <- 0
error_rates_anova_simulation[decision == "continue sampling", "decision"] <- NA
error_rates_anova_simulation$decision <- as.numeric(
  error_rates_anova_simulation$decision
)

# analyse power ----------------------------------------------------------------
sample_size_fixed <- double(length(unique(f_exp)))
counter <- 1
for(f in unique(f_exp)) {
  power_analysis_n <- pwr::pwr.anova.test(k = k_groups, f = f, power = 1 - beta)$n
  sample_size_fixed[counter] <- round(power_analysis_n * k_groups)
  counter <- counter + 1
}
sample_size_fixed <- c(rep(NA, simulated_cases/2), sort(rep(sample_size_fixed, n_rep), TRUE))

error_rates_anova_simulation <-
  error_rates_anova_simulation %>%
    dplyr::mutate(
      sample_size_fixed = sample_size_fixed,
      sample_smaller = .data$sample_size_seq < .data$sample_size_fixed
    )

# detect errors ----------------------------------------------------------------
alpha_error <-
  error_rates_anova_simulation %>%
  dplyr::filter(f_simulated == 0) %>%
  dplyr::mutate(error = decision == 1) %>%
  dplyr::pull(.data$error)
beta_error <-
  error_rates_anova_simulation %>%
  dplyr::filter(f_simulated != 0) %>%
  dplyr::mutate(error = decision == 0) %>%
  dplyr::pull(.data$error)

error_rates_anova_simulation <-
  error_rates_anova_simulation %>%
  dplyr::mutate(error = c(alpha_error, beta_error))

# calculate XXXX ---------------------------------------------------------------
error_f_alpha <- error_rates_anova_simulation %>%
  dplyr::filter(f_simulated == 0) %>%
  dplyr::group_by(f_expected) %>%
  dplyr::mutate(error_f_ = mean(error)) %>%
  dplyr::ungroup() %>%
  dplyr::pull(error_f_)

error_f_beta <- error_rates_anova_simulation %>%
  dplyr::filter(f_simulated != 0) %>%
dplyr::group_by(f_expected) %>%
  dplyr::mutate(error_f_ = mean(error)) %>%
  dplyr::ungroup() %>%
  dplyr::pull(error_f_)

error_rates_anova_simulation <- error_rates_anova_simulation %>%
  dplyr::mutate(error_f = c(error_f_alpha, error_f_beta))

error_rates_anova_simulation <- error_rates_anova_simulation %>%
  dplyr::group_by(f_expected, f_simulated) %>%
  dplyr::mutate(mean_sample_seq_f = round(mean(.data$sample_size_seq), 0)) %>%
  dplyr::ungroup()


anova_performance <- error_rates_anova_simulation %>%
  select(f_simulated, f_expected, mean_sample_seq_f, sample_size_fixed, error_f) %>%
  group_by(f_simulated, f_expected, mean_sample_seq_f, sample_size_fixed, error_f) %>%
  summarise()

# save simulation results ------------------------------------------------------
testthis::use_testdata(error_rates_anova_simulation, overwrite = TRUE)
testthis::use_testdata(anova_performance, overwrite = TRUE)


##---- UNDO SET.SEED -----------------------------------------------------------

set.seed(NULL)


end <- Sys.time()
duration <- end - start
duration

# analyse performance ----------------------------------------------------------
# profvis::profvis(source("tests/testthat/testdata-raw/simulation_error_rates_anova.R"))


# sent results to Telegram Bot -------------------------------------------------
sink(file = NULL) # STOP sink

# install.packages("telegram.bot")
library(telegram.bot)

#
user_name = "mst_r_bot"
token = bot_token("RTelegramBot")

# Initialize bot
bot <- Bot(token = token)
chat_id = 1084175541

console <- toString(read.csv(path_expected, sep = ";", header = FALSE))
# write.table(console, path_expected,sep="\t",row.names=TRUE)
# console <- read.delim(path_expected)


bot$sendMessage(chat_id = chat_id, text = "finished: simulation_error_rates_anova")
bot$sendMessage(chat_id = chat_id, text = paste("Consol Output>>>>>>>>>>", console))
# bot$sendMessage(chat_id = chat_id, text = duration)


