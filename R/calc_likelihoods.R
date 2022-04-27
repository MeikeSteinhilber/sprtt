# t-test -----------------------------------------------------------------------
calc_likelihoods_ttest <- function(
  seq_ttest_arguments,
  t_statistic,
  df,
  non_centrality_parameter,
  wanted = NULL
){
  t_val <- t_statistic["statistic"][[1]][[1]]
  ncp <- non_centrality_parameter

  if (seq_ttest_arguments@alternative == "two.sided") {
    likelihood_1 <- df(t_val^2, df1 = 1, df2 = df, ncp = ncp^2)
    likelihood_0 <- df(t_val^2, df1 = 1, df2 = df)
    likelihood_1_log <- df(t_val^2, df1 = 1, df2 = df, ncp = ncp^2, log = TRUE)
    likelihood_0_log <- df(t_val^2, df1 = 1, df2 = df, log = TRUE)

  } else{
    likelihood_1 <- dt(t_val, df, ncp = ncp)
    likelihood_0 <- dt(t_val, df)
    likelihood_1_log <- dt(t_val, df, ncp = ncp, log = TRUE)
    likelihood_0_log <- dt(t_val, df, log = TRUE)
  }

  ratio <- likelihood_1/likelihood_0
  ratio_log <- likelihood_1_log - likelihood_0_log

  if (likelihood_1 == 0 ||
      likelihood_0 == 0
  ) {
    warning("At least one likelihood is equal to 0.
            The test works with the logarithm of the likelihoods.")
  }

  if (likelihood_1_log == -Inf ||
      likelihood_0_log == -Inf ||
      likelihood_1_log ==  Inf ||
      likelihood_0_log ==  Inf
  ) {
    warning("At least one log-likelihood reached infinity.")
  }

  return(list(
    likelihood_1 = likelihood_1,
    likelihood_0 = likelihood_0,
    ratio = ratio,
    likelihood_1_log = likelihood_1_log,
    likelihood_0_log = likelihood_0_log,
    ratio_log = ratio_log))

}

# ANOVA ------------------------------------------------------------------------

calc_likelihoods_anova <- function(
  seq_anova_arguments,
  non_centrality_parameter,
  F_statistic
) {

  likelihood_1 <- df(F_statistic$F_value, F_statistic$df_1, F_statistic$df_2, non_centrality_parameter)
  likelihood_0 <- df(F_statistic$F_value, F_statistic$df_1, F_statistic$df_2)
  likelihood_1_log <- df(F_statistic$F_value, F_statistic$df_1, F_statistic$df_2, non_centrality_parameter, log = TRUE)
  likelihood_0_log <- df(F_statistic$F_value, F_statistic$df_1, F_statistic$df_2, log = TRUE)
  likelihood_ratio <- likelihood_1 / likelihood_0
  likelihood_ratio_log <- likelihood_1_log - likelihood_0_log

  if (likelihood_1 == 0 ||
      likelihood_0 == 0
  ) {
    warning("At least one likelihood is equal to 0.
            The test works with the logarithm of the likelihoods.")
  }

  if (likelihood_1_log == -Inf ||
      likelihood_0_log == -Inf ||
      likelihood_1_log ==  Inf ||
      likelihood_0_log ==  Inf
  ) {
    warning("At least one log-likelihood reached infinity.")
  }

  return(list(
    likelihood_1 = likelihood_1,
    likelihood_0 = likelihood_0,
    ratio = likelihood_ratio,
    likelihood_1_log = likelihood_1_log,
    likelihood_0_log = likelihood_0_log,
    ratio_log = likelihood_ratio_log))
}
