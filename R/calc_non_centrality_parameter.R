# t-test -----------------------------------------------------------------------
calc_non_centrality_parameter_ttest <- function(seq_ttest_arguments) {
  x <- seq_ttest_arguments@x
  y <- seq_ttest_arguments@y
  d <- seq_ttest_arguments@d

  if (seq_ttest_arguments@one_sample == TRUE ||
      seq_ttest_arguments@paired == TRUE
  ) {
    d * sqrt(length(x))
  } else{
    d / sqrt(1 / length(x) + 1 / length(y))
  }
}

# ANOVA ------------------------------------------------------------------------

calc_non_centrality_parameter_anova <- function(seq_anova_arguments) {
  # seq_anova_arguments@f^2 * seq_anova_arguments@n
  seq_anova_arguments@f^2 * seq_anova_arguments@total_sample_size
}

