calc_seq_anova <- function(seq_anova_arguments) {
  non_centrality_parameter <-
    calc_seq_anova_non_centrality_parameter(
      seq_anova_arguments
    )
  ss_effect <-
    calc_ss_effect(
      seq_anova_arguments
    )
  ss_residual <-
    calc_ss_residual(
      seq_anova_arguments
    )
  likelihoods <-
    calc_seq_anova_likelihoods(
      seq_anova_arguments,
      non_centrality_parameter,
      ss_effect,
      ss_residual,
    )
  boundaries <-
    calc_seq_anova_boundaries(
      seq_anova_arguments,
      likelihoods
    )
  decision <-
    get_seq_anova_decision(
      likelihood_ratio = likelihoods$ratio_log,
      boundaries = boundaries
    )
  seq_anova_results <-
    build_seq_anova_results(
      seq_anova_arguments,
      likelihoods,
      boundaries,
      decision,
      non_centrality_parameter,
      ss_effect,
      ss_residual
    )

  seq_ttest_results
}
