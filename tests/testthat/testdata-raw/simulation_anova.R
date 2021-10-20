start <- Sys.time()

# set simulation parameter -----------------------------------------------------
set.seed(333)

f <- .25 # 0.1, 0.25, 0.4
f_expected <- .25
k_groups <- 4
max_n <- 2000
n_rep <- 1000
alpha <- beta <- .05
A <- (1 - beta) / alpha
B <- beta / (1 - alpha)
seq_steps <- seq((2 * k_groups), (max_n * k_groups), k_groups)
decision <- numeric(n_rep)
sample_size <- numeric(n_rep)
likelihood_ratio <- numeric(n_rep)
likelihood_ratio_anova <- numeric(n_rep)
decision_anova <- numeric(n_rep)

# simulation -------------------------------------------------------------------
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
      decision[i] <- 1
      sample_size[i] <- n
      likelihood_ratio[i] <- LR
      likelihood_ratio_anova[i] <- LR_anova_results@likelihood_ratio
      decision_anova[i] <- LR_anova_results@decision
      break
    } else if (LR < B) {
      decision[i] <- 0
      sample_size[i] <- n
      likelihood_ratio[i] <- LR
      likelihood_ratio_anova[i] <- LR_anova_results@likelihood_ratio
      decision_anova[i] <- LR_anova_results@decision
      break
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
  sample_size_seq = sample_size
)

## recode decision
results_anova_simulation[decision_anova == "accept H1", "decision_anova"] <- 1
results_anova_simulation[decision_anova == "accept H0", "decision_anova"] <- 0
results_anova_simulation$decision_anova <- as.numeric(
  results_anova_simulation$decision_anova
)

# analyse power ----------------------------------------------------------------
power_analysis <- pwr::pwr.anova.test(k = k_groups, f = f, power = 1 - beta)
n_all_power_analysis <- round(power_analysis$n * k_groups)

results_anova_simulation <-
  results_anova_simulation %>%
    dplyr::mutate(sample_size_fixed = n_all_power_analysis,
                  sample_smaller = .data$sample_size_seq < .data$sample_size_fixed
    )


# save simulation results ------------------------------------------------------
testthis::use_testdata(results_anova_simulation, overwrite = TRUE)


##---- UNDO SET.SEED -----------------------------------------------------------

set.seed(NULL)


end <- Sys.time()
print(end - start)
