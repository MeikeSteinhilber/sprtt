build_seq_ttest_results <- function(seq_ttest_arguments,
                                    t_statistic,
                                    df,
                                    non_centrality_parameter,
                                    likelihoods,
                                    boundaries,
                                    decision){
  # no mean in y if one sample
  if(length(t_statistic$estimate) > 1){
    mean_y <- t_statistic$estimate[[2]]
  } else{
    mean_y <- NULL
  }
  seq_ttest_results <- new("seq_ttest_results",
                           likelihood_ratio = likelihoods$ratio,
                           decision = decision,
                           A_boundary = boundaries$A,
                           B_boundary = boundaries$B,
                           d = seq_ttest_arguments@d,
                           mu = seq_ttest_arguments@mu,
                           likelihood_1 = likelihoods$likelihood_1,
                           likelihood_2 = likelihoods$likelihood_2,
                           non_centrality_parameter = non_centrality_parameter,
                           t_value = as.vector(t_statistic$statistic),
                           p_value = t_statistic$p.value,
                           df = df,
                           mean_x = t_statistic$estimate[[1]],
                           mean_y = mean_y,
                           alternative = seq_ttest_arguments@alternative,
                           one_sample = seq_ttest_arguments@one_sample,
                           ttest_method = t_statistic$method,
                           data_name = seq_ttest_arguments@data_name
  )
  seq_ttest_results
}
