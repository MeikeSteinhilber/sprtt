calc_seq_anova_likelihoods <- function(
  seq_anova_arguments,
  non_centrality_parameter,
  F_statistic
) {

  likelihood_1 <- df(F_statistic$F_value, F_statistic$df_1, F_statistic$df_2, non_centrality_parameter)
  likelihood_2 <- df(F_statistic$F_value, F_statistic$df_1, F_statistic$df_2)
  likelihood_1_log <- df(F_statistic$F_value, F_statistic$df_1, F_statistic$df_2, non_centrality_parameter, log = TRUE)
  likelihood_2_log <- df(F_statistic$F_value, F_statistic$df_1, F_statistic$df_2, log = TRUE)
  likelihood_ratio <- likelihood_1 / likelihood_2
  likelihood_ratio_log <- likelihood_1_log - likelihood_2_log

  #Check likelihooods: duplicated code calc_seq_ttest_likelihoods

  return(list(
    likelihood_1 = likelihood_1,
    likelihood_0 = likelihood_2,
    ratio = likelihood_ratio,
    likelihood_1_log = likelihood_1_log,
    likelihood_0_log = likelihood_2_log,
    ratio_log = likelihood_ratio_log))
}
