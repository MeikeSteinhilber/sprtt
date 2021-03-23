build_seq_ttest_results <- function(
  seq_ttest_arguments,
  t_statistic,
  df,
  non_centrality_parameter,
  likelihoods,
  boundaries,
  decision,
  verbose
){
  # # no mean in y if one sample
  # if (length(t_statistic$estimate) > 1) {
  #   mean_y <- t_statistic$estimate[[2]]
  # } else{
  #   mean_y <- NULL
  # }

  seq_ttest_results <-
    new(
      "seq_ttest_results",
      likelihood_ratio = likelihoods["ratio"][[1]],
      likelihood_ratio_log = likelihoods["ratio_log"][[1]],
      decision = decision,
      A_boundary_log = boundaries["A"][[1]],
      B_boundary_log = boundaries["B"][[1]],
      d = seq_ttest_arguments["d"],
      mu = seq_ttest_arguments["mu"],
      alpha = seq_ttest_arguments["alpha"],
      power = seq_ttest_arguments["power"],
      likelihood_1 = likelihoods["likelihood_1"][[1]],
      likelihood_2 = likelihoods["likelihood_2"][[1]],
      likelihood_1_log = likelihoods["likelihood_1_log"][[1]],
      likelihood_2_log = likelihoods["likelihood_2_log"][[1]],
      non_centrality_parameter = non_centrality_parameter,
      t_value = as.vector(t_statistic["statistic"][[1]]),
      p_value = t_statistic["p.value"][[1]],
      df = df,
      mean_estimate = t_statistic["estimate"],
      alternative = seq_ttest_arguments["alternative"],
      one_sample = seq_ttest_arguments["one_sample"],
      ttest_method = t_statistic["method"][[1]],
      data_name = seq_ttest_arguments["data_name"],
      verbose = verbose
    )
  seq_ttest_results
}
