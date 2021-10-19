calc_seq_anova <- function(seq_anova_arguments) {
  non_centrality_parameter <-
    calc_seq_anova_non_centrality_parameter(
      seq_anova_arguments
    )
  seq_anova_arguments@data <-
    calc_group_means(
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
  F_statistic <-
    calc_F_statistic_seq_anova(
      seq_anova_arguments,
      ss_effect,
      ss_residual
    )
  likelihoods <-
    calc_seq_anova_likelihoods(
      seq_anova_arguments,
      non_centrality_parameter,
      ss_effect,
      ss_residual,
      F_statistic
    )
  boundaries <-
    calc_seq_ttest_boundaries(
      power = seq_anova_arguments@power,
      alpha = seq_anova_arguments@alpha,
      log = FALSE
    )
  decision <-
    get_seq_ttest_decision(
      likelihood_ratio = likelihoods$ratio,
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
      ss_residual,
      F_statistic
    )

  seq_anova_results
}
