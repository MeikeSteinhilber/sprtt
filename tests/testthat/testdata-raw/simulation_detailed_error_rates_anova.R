# initialize BOT ---------------------------------------------------------------
# install.packages("telegram.bot")
library(telegram.bot)

#
user_name = "mst_r_bot"
token = bot_token("RTelegramBot")

# Initialize bot
bot <- Bot(token = token)
chat_id = 1084175541


start <- Sys.time()
library(dplyr)
path_expected <- tempfile(fileext = ".txt")
sink(path_expected)
# set simulation parameter -----------------------------------------------------
set.seed(333)

f_exp <- rep(seq(0.1, 0.25, 0.01), 2)
n_cases_f <- length(unique(f_exp))
f_sim <- c(rep(0, n_cases_f), rep(0.1, n_cases_f))  # 0.1, 0.25, 0.4

k_groups <- 4
max_n <- 20000
n_rep <- 1000
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
  bot$sendMessage(chat_id = chat_id, text = paste(j, "from", length(f_sim), "cases"))
  j <- j + 1
}
# check the simulation ---------------------------------------------------------
if(any(sample_size == 0)) {
  stop("error in anova simulation: increase max_n")
}


# save results in data frame ---------------------------------------------------
results <- data.frame(
  f_simulated,
  f_expected,
  likelihood_ratio,
  decision,
  sample_size_seq = sample_size
)

## recode decision
results[decision == "accept H1", "decision"] <- 1
results[decision == "accept H0", "decision"] <- 0
results[decision == "continue sampling", "decision"] <- NA
results$decision <- as.numeric(
  results$decision
)

# # analyse power ----------------------------------------------------------------
# sample_size_fixed <- double(length(unique(f_exp)))
# counter <- 1
# for(f in unique(f_exp)) {
#   power_analysis_n <- pwr::pwr.anova.test(k = k_groups, f = f, power = 1 - beta)$n
#   sample_size_fixed[counter] <- round(power_analysis_n * k_groups)
#   counter <- counter + 1
# }
# sample_size_fixed <- c(rep(NA, n_cases_f * n_rep), rep(sort(rep(sample_size_fixed, n_rep), TRUE), n_cases_f))
#
#
# results <-
#   results %>%
#     dplyr::mutate(
#       sample_size_fixed = sample_size_fixed,
#       sample_smaller = .data$sample_size_seq < .data$sample_size_fixed
#     )

# detect errors ----------------------------------------------------------------
alpha_error <-
  results %>%
  dplyr::filter(f_simulated == 0) %>%
  dplyr::mutate(error = decision == 1) %>%
  dplyr::pull(.data$error)
beta_error <-
  results %>%
  dplyr::filter(f_simulated != 0) %>%
  dplyr::mutate(error = decision == 0) %>%
  dplyr::pull(.data$error)

results <-
  results %>%
  dplyr::mutate(error = c(alpha_error, beta_error))

# calculate XXXX ---------------------------------------------------------------
error_f_alpha <- results %>%
  dplyr::filter(f_simulated == 0) %>%
  dplyr::group_by(f_expected) %>%
  dplyr::mutate(error_f_ = mean(error)) %>%
  dplyr::ungroup() %>%
  dplyr::pull(error_f_)

error_f_beta <- results %>%
  dplyr::filter(f_simulated != 0) %>%
  dplyr::group_by(f_simulated, f_expected) %>%
  dplyr::mutate(error_f_ = mean(error)) %>%
  dplyr::ungroup() %>%
  dplyr::pull(error_f_)

results <- results %>%
  dplyr::mutate(error_f = c(error_f_alpha, error_f_beta))

results <- results %>%
  dplyr::group_by(f_expected, f_simulated) %>%
  dplyr::mutate(mean_sample_seq_f = round(mean(.data$sample_size_seq), 0)) %>%
  dplyr::ungroup()


anova_performance <- results %>%
  select(f_simulated, f_expected, mean_sample_seq_f,  error_f) %>%
  group_by(f_simulated, f_expected, mean_sample_seq_f,  error_f) %>%
  summarise()

# save simulation results ------------------------------------------------------
detailed_error_rated_anova <- results
testthis::use_testdata(detailed_error_rated_anova, overwrite = TRUE)
testthis::use_testdata(anova_performance_detailed, overwrite = TRUE)


##---- UNDO SET.SEED -----------------------------------------------------------

set.seed(NULL)


end <- Sys.time()
duration <- end - start
duration

# analyse performance ----------------------------------------------------------
# profvis::profvis(source("tests/testthat/testdata-raw/simulation_error_rates_anova.R"))


# sent results to Telegram Bot -------------------------------------------------
sink(file = NULL) # STOP sink

console <- toString(read.csv(path_expected, sep = ";", header = FALSE))
# write.table(console, path_expected,sep="\t",row.names=TRUE)
# console <- read.delim(path_expected)


bot$sendMessage(chat_id = chat_id, text = "finished: simulation_error_rates_anova")
bot$sendMessage(chat_id = chat_id, text = paste("Consol Output>>>>>>>>>>", console))
# bot$sendMessage(chat_id = chat_id, text = duration)

# graphs -----------------------------------------------------------------------

df <- results

# df %>%
#   filter(f_simulated == 0) %>%
#   pull(sample_size_seq) %>%
#   hist(., breaks = 1000)
# df %>%
#   filter(f_simulated != 0) %>%
#   pull(sample_size_seq) %>%
#   hist(., breaks = 1000)

# define groups/factors
df$f_simulated <- as.factor(df$f_simulated)
df$f_expected <- as.factor(df$f_expected)


library(ggplot2)
# Basic violin plot
df %>%
  ggplot(., aes(x = f_simulated, y = sample_size_seq, fill = f_expected)) +
  geom_violin() +
  # coord_flip() +
  # scale_fill_brewer(palette = "Dark2") +
  theme_classic() +
  ggsave("violin_sample_size_seq_detailed_V1.png", path = "tests/testthat/testdata", device = "png")

bot$sendPhoto(chat_id, "tests/testthat/testdata/violin_sample_size_seq_detailed_V1.png")

