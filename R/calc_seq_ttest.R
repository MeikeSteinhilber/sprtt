calc_seq_ttest <- function(seq_ttest_arguments, verbose = TRUE){

  t_statistic <-
    calc_seq_ttest_t_statistic(
      seq_ttest_arguments
    )
  df <-
    as.vector(
      t_statistic$parameter
    )
  non_centrality_parameter <-
    calc_seq_ttest_non_centrality_parameter(
      seq_ttest_arguments
    )
  likelihoods <-
    calc_seq_ttest_likelihoods(
      seq_ttest_arguments,
      t_statistic,
      df,
      non_centrality_parameter
    )
  boundaries <-
    calc_seq_boundaries(
      power = seq_ttest_arguments@power,
      alpha = seq_ttest_arguments@alpha,
      log = TRUE
    )
  decision <-
    get_seq_decision(
      likelihood_ratio = likelihoods$ratio_log,
      boundaries = boundaries
    )
  seq_ttest_results <-
    build_seq_ttest_results(
      seq_ttest_arguments,
      t_statistic,
      df,
      non_centrality_parameter,
      likelihoods,
      boundaries,
      decision,
      verbose
    )

  seq_ttest_results
}
