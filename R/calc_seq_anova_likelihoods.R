calc_seq_anova_likelihoods <- function(
  seq_anova_arguments,
  non_centrality_parameter,
  ss_effect,
  ss_residual,
  F_statistic
) {

  likelihood_1 <- df(F_statistic$F_value, F_statistic$df_1, F_statistic$df_2, non_centrality_parameter)
  likelihood_2 <- df(F_statistic$F_value, F_statistic$df_1, F_statistic$df_2)
  likelihood_1_log <- df(F_statistic$F_value, F_statistic$df_1, F_statistic$df_2, non_centrality_parameter, log = TRUE)
  likelihood_2_log <- df(F_statistic$F_value, F_statistic$df_1, F_statistic$df_2, log = TRUE)
  likelihood_ratio <- likelihood_1 / likelihood_2
  likelihood_ratio_log <- likelihood_1_log / likelihood_2_log

  #Check likelihooods: duplicated code calc_seq_ttest_likelihoods


  return(list(
    likelihood_1 = likelihood_1,
    likelihood_0 = likelihood_2,
    ratio = likelihood_ratio,
    likelihood_1_log = likelihood_1_log,
    likelihood_0_log = likelihood_2_log,
    ratio_log = likelihood_ratio_log))

  # f_value <- (ss_effect / (k_groups - 1)) / (ss_residual / (n - k_groups))
  # noncentrality_parameter <- f_expected^2 * n
  # df_1 <- k_groups - 1
  # df_2 <- n - k_groups
  # likelihood_ratio <- df(f_value, df_1, df_2, noncentrality_parameter) /
  #   df(f_value, df_1, df_2)
}
