calc_ss_residual <- function(seq_anova_arguments, group_means_A) {
  levels_factor_A <- as.numeric(levels(as.factor(seq_anova_arguments@data$factor_A)))
  ss_residual = double(length(levels_factor_A))
  i = 1

  for (level in levels_factor_A) {
    data <- seq_anova_arguments@data %>%
      filter(seq_anova_arguments@data$factor_A == level)

    level_mean <- group_means_A %>% filter(factor_A == level) %>% select(means) %>% as.double()
    y <- data %>% select(y) %>% as.vector()
    ss_residuals[i] <- sum((y - level_mean)^2)
    i <- i + 1
  }
  sum(ss_residuals)

  # sum((seq_anova_arguments@y - group_means)^2)
}
