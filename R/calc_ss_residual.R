calc_ss_residual <- function(seq_anova_arguments) {
  sum((seq_anova_arguments@data$y - seq_anova_arguments@data$group_mean_A)^2)
}
