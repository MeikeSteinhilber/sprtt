calc_non_centrality_parameter <- function(ttest_arguments) {
  x <- ttest_arguments@x
  y <- ttest_arguments@y
  d <- ttest_arguments@d
  if (ttest_arguments@one_sample == FALSE) {
    d / sqrt(1 / length(x) + 1 / length(y))
  } else{
    d * sqrt(length(x))
  }
}


# ifelse(type == "two.sample",
#        d/sqrt(1/length(x) + 1/length(y)),
#        d * sqrt(length(x)))
