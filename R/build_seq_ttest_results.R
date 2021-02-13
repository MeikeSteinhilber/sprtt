build_seq_ttest_results <- function(t_statistic,
                                    df,
                                    non_centrality_parameter,
                                    likelihoods,
                                    boundaries,
                                    decision){

  if(length(t_statistic$estimate) > 1){
    mean_y <- t_statistic$estimate[[2]]
  } else{
    mean_y <- NULL
  }

  seq_ttest_results <- new("seq_ttest_results",
                           t_value = as.vector(t_statistic$statistic),
                           df = df,
                           p_value = t_statistic$p.value,
                           mean_x = t_statistic$estimate[[1]],
                           mean_y = mean_y,
                           alternative = t_statistic$alternative,
                           ttest_method = t_statistic$method,
                           data_name = t_statistic$data.name,
                           non_centrality_parameter = non_centrality_parameter,
                           likelihood_1 = likelihoods$likelihood_1,
                           likelihood_2 = likelihoods$likelihood_2,
                           likelihood_ratio = likelihoods$ratio,
                           A_boundary = boundaries$A,
                           B_boundary = boundaries$B,
                           decision = decision
  )
  seq_ttest_results
}
