calc_seq_ttest_likelihoods <- function(
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
    likelihood_2 <- df(t_val^2, df1 = 1, df2 = df)
    likelihood_1_log <- df(t_val^2, df1 = 1, df2 = df, ncp = ncp^2, log = TRUE)
    likelihood_2_log <- df(t_val^2, df1 = 1, df2 = df, log = TRUE)

  } else{
    likelihood_1 <- dt(t_val, df, ncp = ncp)
    likelihood_2 <- dt(t_val, df)
    likelihood_1_log <- dt(t_val, df, ncp = ncp, log = TRUE)
    likelihood_2_log <- dt(t_val, df, log = TRUE)
  }

  ratio <- likelihood_1/likelihood_2
  ratio_log <- likelihood_1_log - likelihood_2_log

  if (likelihood_1 == 0 ||
      likelihood_2 == 0
  ) {
    warning("At least one likelihood is equal to 0.
            The test works with the logarithm of the likelihoods.")
  }

  if (likelihood_1_log == -Inf ||
      likelihood_2_log == -Inf ||
      likelihood_1_log ==  Inf ||
      likelihood_2_log ==  Inf
  ) {
    warning("At least one log-likelihood reached infinity.")
  }

  return(list(
    likelihood_1 = likelihood_1,
    likelihood_2 = likelihood_2,
    ratio = ratio,
    likelihood_1_log = likelihood_1_log,
    likelihood_2_log = likelihood_2_log,
    ratio_log = ratio_log))

}

