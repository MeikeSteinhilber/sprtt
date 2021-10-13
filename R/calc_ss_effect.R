calc_ss_effect <- function(seq_anova_arguments, group_means) {
  n_groups_all <- seq_anova_arguments@data %>% group_by(factor_A) %>% summarise(n = n())
  n_goup <- (n_groups_all$n[1])
  levels_factor_A <- as.numeric(levels(as.factor(seq_anova_arguments@data$factor_A)))
  n_levels_factor_A <- length(levels_factor_A)
  grand_mean_factor_A <- mean(group_means$means)
  # grand_mean_factor_A <- mean(seq_anova_arguments@data$y)

  # Check n_groups_all
  # duplicates <- duplicated(n_groups_all$n)
  # if (duplicates != c("FALSE", rep("TRUE", n_levels_factor_A - 1))) {
  #   "The group size is not equal."
  # }



  sum(n_goup * (group_means$means - grand_mean_factor_A)^2)


  # ss_effect <- sum(n_k * (group_means - mean(group_means))^2)
}
