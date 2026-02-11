calc_t_statistic <- function(seq_ttest_arguments) {

  if (seq_ttest_arguments["one_sample"] == TRUE) {
    t_statistic <- t.test(
      y ~ 1,
      data = seq_ttest_arguments@data,
      mu = seq_ttest_arguments@mu
    )

  } else if (
    seq_ttest_arguments["one_sample"] == FALSE &&
    seq_ttest_arguments@paired == FALSE
  ) {
    t_statistic <- t.test(
      y ~ x,
      data = seq_ttest_arguments@data,
      mu = seq_ttest_arguments@mu,
      var.equal = TRUE
    )
      # x = seq_ttest_arguments["x"],
      # y = seq_ttest_arguments["y"],
      # mu = seq_ttest_arguments["mu"],
      # var.equal = TRUE

  } else if (
    seq_ttest_arguments["one_sample"] == FALSE &&
    seq_ttest_arguments@paired == TRUE
  ) {

    t_statistic <- t.test(
      x = seq_ttest_arguments@data$y[seq_ttest_arguments@data$x == 1],
      y = seq_ttest_arguments@data$y[seq_ttest_arguments@data$x == 2],
      mu = seq_ttest_arguments@mu,
      paired = TRUE
    )
    # t_statistic <- t.test(
    #   x = seq_ttest_arguments["x"],
    #   y = seq_ttest_arguments["y"],
    #   mu = seq_ttest_arguments["mu"],
    #   paired = TRUE
    # )
  }

  if (is.na(t_statistic$statistic)) {
    stop("It was not possible to calculate the t-value.")
  }

  if (seq_ttest_arguments["alternative"] == "less") {
    t_statistic$statistic <- t_statistic$statistic * -1
  }

  t_statistic
}

# seq_ttest_arguments <-  build_prototype_seq_ttest_arguments()
