# t-test -----------------------------------------------------------------------

calc_non_centrality_parameter_ttest <- function(seq_ttest_arguments) {
  data <- seq_ttest_arguments@data
  d <- seq_ttest_arguments@d

  if (seq_ttest_arguments@one_sample == TRUE
  ) {
    n <- sum(data$y)
    d * sqrt(n)
  } else if (seq_ttest_arguments@paired == TRUE) {
    n <- sum(data$x == 1)
    d * sqrt(n)
  } else {
    n1 <- sum(data$x == 1)
    n2 <- sum(data$x == 2)
    d / sqrt(1 / n1 + 1 / n2)
  }
}

# calc_non_centrality_parameter_ttest <- function(seq_ttest_arguments) {
#   x <- seq_ttest_arguments@data$x
#   y <- seq_ttest_arguments@y
#   d <- seq_ttest_arguments@d
#
#   if (seq_ttest_arguments@one_sample == TRUE ||
#       seq_ttest_arguments@paired == TRUE
#   ) {
#     d * sqrt(length(x))
#   } else{
#     d / sqrt(1 / length(x) + 1 / length(y))
#   }
# }

# ANOVA ------------------------------------------------------------------------

calc_non_centrality_parameter_anova <- function(seq_anova_arguments) {
  # seq_anova_arguments@f^2 * seq_anova_arguments@n
  seq_anova_arguments@f^2 * seq_anova_arguments@total_sample_size
}

