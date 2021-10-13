calc_seq_anova_likelihoods <- function(
  calc_seq_anova_likelihoods,
  non_centrality_parameter,
  ss_effect,
  ss_residual
) {

  # f_value <- (ss_effect / (k_groups - 1)) / (ss_residual / (n - k_groups))
  # noncentrality_parameter <- f_expected^2 * n
  # df_1 <- k_groups - 1
  # df_2 <- n - k_groups
  # likelihood_ratio <- df(f_value, df_1, df_2, noncentrality_parameter) /
  #   df(f_value, df_1, df_2)
}
