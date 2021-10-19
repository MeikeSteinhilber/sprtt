calc_ss_residual <- function(seq_anova_arguments) {
  # levels_factor_A <- unique(seq_anova_arguments@data$factor_A)
  # n_groups_all <- dplyr::count(seq_anova_arguments@data, .data$factor_A)

  sum((seq_anova_arguments@data$y - seq_anova_arguments@data$group_mean)^2)

}
