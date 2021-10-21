start <- Sys.time()
library(dplyr)

# set simulation parameter -----------------------------------------------------
set.seed(333)

f_sim <- c(0.1, .25, 0.4)  # 0.1, 0.25, 0.4
# f <- 0.1
# f_expected <- f
k_groups <- 4
max_n <- 20000
n_rep <- 10
alpha <- beta <- .05
A <- (1 - beta) / alpha
B <- beta / (1 - alpha)
seq_steps <- seq((2 * k_groups), (max_n * k_groups), k_groups)
decision <- numeric(n_rep * length(f_sim))
sample_size <- numeric(n_rep * length(f_sim))
likelihood_ratio <- numeric(n_rep * length(f_sim))
likelihood_ratio_anova <- numeric(n_rep * length(f_sim))
decision_anova <- numeric(n_rep * length(f_sim))
f_simulated <- numeric(n_rep * length(f_sim))
sample_size_fixed <- numeric(n_rep * length(f_sim))
counter <- 1

# simulation -------------------------------------------------------------------
for (f in f_sim) {
  f_expected <- f

  for (i in 1:n_rep){
    # print(i)
    raw_means <- rnorm(k_groups)
    means = (raw_means - mean(raw_means)) / sd(raw_means) * sqrt(k_groups / (k_groups - 1)) * f
    y <- rnorm(max_n * k_groups, means)
    x <- factor(rep(1:k_groups, max_n))
    data <- data.frame(y, x)
    for (n in seq_steps) {
      n_k <- n / k_groups
      group_means <- as.numeric(tapply(y[1:n], x[1:n], mean))
      ss_effect <- sum(n_k * (group_means - mean(group_means))^2)
      ss_residual <- sum((y[1:n] - group_means)^2)
      f_value <- (ss_effect / (k_groups - 1)) / (ss_residual / (n - k_groups))
      noncentrality_parameter <- f_expected^2 * n
      df_1 <- k_groups - 1
      df_2 <- n - k_groups
      LR <- df(f_value, df_1, df_2, noncentrality_parameter) /
        df(f_value, df_1, df_2)
      LR_anova_results <- sprtt::seq_anova(y ~ x, f = f_expected, data = data[1:n,])
      if (LR > A) {
        decision[counter] <- 1
        sample_size[counter] <- n
        likelihood_ratio[counter] <- LR
        likelihood_ratio_anova[counter] <- LR_anova_results@likelihood_ratio
        decision_anova[counter] <- LR_anova_results@decision
        f_simulated[counter] <- f
        power_analysis_n <- pwr::pwr.anova.test(k = k_groups, f = f, power = 1 - beta)$n
        sample_size_fixed[counter] <- round(power_analysis_n * k_groups)
        counter <<- counter + 1
        break
      } else if (LR < B) {
        decision[counter] <- 0
        sample_size[counter] <- n
        likelihood_ratio[counter] <- LR
        likelihood_ratio_anova[counter] <- LR_anova_results@likelihood_ratio
        decision_anova[counter] <- LR_anova_results@decision
        f_simulated[counter] <- f
        power_analysis_n <- pwr::pwr.anova.test(k = k_groups, f = f, power = 1 - beta)$n
        sample_size_fixed[counter] <- round(power_analysis_n * k_groups)
        counter <<- counter + 1
        break
      }
    }
  }
}
# check the simulation ---------------------------------------------------------
if(any(sample_size == 0)) {
  stop("error in anova simulation: increase max_n")
}


# save results in data frame ---------------------------------------------------
results_anova_simulation <- data.frame(
  likelihood_ratio,
  likelihood_ratio_anova,
  decision,
  decision_anova,
  sample_size_seq = sample_size,
  sample_size_fixed,
  f_simulated
)

## recode decision
results_anova_simulation[decision_anova == "accept H1", "decision_anova"] <- 1
results_anova_simulation[decision_anova == "accept H0", "decision_anova"] <- 0
results_anova_simulation[decision_anova == "continue sampling", "decision_anova"] <- NA
results_anova_simulation$decision_anova <- as.numeric(
  results_anova_simulation$decision_anova
)

# analyse power ----------------------------------------------------------------
results_anova_simulation <-
  results_anova_simulation %>%
    dplyr::mutate(
      sample_smaller = .data$sample_size_seq < .data$sample_size_fixed
    )


# save simulation results ------------------------------------------------------
testthis::use_testdata(results_anova_simulation, overwrite = TRUE)


##---- UNDO SET.SEED -----------------------------------------------------------

set.seed(NULL)


end <- Sys.time()
print(end - start)
