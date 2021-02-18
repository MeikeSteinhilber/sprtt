calc_non_centrality_parameter <- function(seq_ttest_arguments) {
  x <- seq_ttest_arguments@x
  y <- seq_ttest_arguments@y
  d <- seq_ttest_arguments@d
  if (seq_ttest_arguments@one_sample == FALSE) {
    d / sqrt(1 / length(x) + 1 / length(y))
  } else{
    d * sqrt(length(x))
  }
}
