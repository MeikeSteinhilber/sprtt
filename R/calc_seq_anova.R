calc_seq_anova <- function(seq_anova_arguments) {
  non_centrality_parameter <-
    calc_non_centrality_parameter_anova(
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
  ss_total <-
    calc_ss_total(
      seq_anova_arguments
    )
  F_statistic <-
    calc_F_statistic_(
      seq_anova_arguments,
      ss_effect,
      ss_residual
    )
  likelihoods <-
    calc_likelihoods_anova(
      seq_anova_arguments,
      non_centrality_parameter,
      F_statistic
    )
  boundaries <-
    calc_boundaries(
      power = seq_anova_arguments@power,
      alpha = seq_anova_arguments@alpha,
      log = TRUE
    )
  decision <-
    get_seq_decision(
      likelihood_ratio = likelihoods$ratio_log,
      boundaries = boundaries
    )
  eta_squared <- calc_eta_squared(ss_effect, ss_total)
  f_empiric <- sqrt(eta_squared/(1-eta_squared))

  seq_anova_results <-
    build_seq_anova_results(
      seq_anova_arguments,
      likelihoods,
      boundaries,
      decision,
      non_centrality_parameter,
      ss_effect,
      ss_residual,
      ss_total,
      F_statistic,
      f_empiric,
      eta_squared
    )

  seq_anova_results
}
