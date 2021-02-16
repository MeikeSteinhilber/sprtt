calc_seq_ttest <- function(ttest_arguments){

  t_statistic <- calc_t_statistic(ttest_arguments)

  df <- as.vector(t_statistic$parameter)

  non_centrality_parameter <- calc_non_centrality_parameter(ttest_arguments)

  likelihoods <- calc_seq_ttest_likelihoods(ttest_arguments, t_statistic, df, non_centrality_parameter)

  boundaries <- calc_seq_ttest_boundaries(power = ttest_arguments@power,
                                          alpha = ttest_arguments@alpha)

  decision <- get_seq_ttest_decision(likelihood_ratio = likelihoods$ratio,
                                     boundaries = boundaries)

  seq_ttest_results <- build_seq_ttest_results(t_statistic,
                                               ttest_arguments,
                                               df,
                                               non_centrality_parameter,
                                               likelihoods,
                                               boundaries,
                                               decision)
  seq_ttest_results
}
