calc_ss_effect <- function(seq_anova_arguments) {
  n_goup <- dplyr::count(seq_anova_arguments@data, .data$factor_A)$n[1]
  group_means <- unique(seq_anova_arguments@data$group_mean)
  grand_mean_factor_A <- mean(group_means)

  sum(n_goup * (group_means - grand_mean_factor_A)^2)
}
