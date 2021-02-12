calc_seq_ttest_likelihoods <- function(ttest_arguments, t_statistic, df, non_centrality_parameter, wanted = NULL){
  t_val <- t_statistic$statistic[[1]]
  ncp <- non_centrality_parameter

  if(ttest_arguments@alternative == "two.sided"){
    likelihood_1 <- df(t_val^2, df1 = 1, df2 = df, ncp = ncp^2)
    likelihood_2 <- df(t_val^2, df1 = 1, df2 = df)

  } else{
    likelihood_1 <- dt(t_val, df, ncp = ncp)
    likelihood_2 <- dt(t_val, df)
  }

  ratio <- likelihood_1/likelihood_2

  return(list(likelihood_1 = likelihood_1,
              likelihood_2 = likelihood_2,
              ratio = ratio))
}
