calc_ss_residual <- function(seq_anova_arguments, group_means) {

  sum((seq_anova_arguments@y - group_means)^2)
}
