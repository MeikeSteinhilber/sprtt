calc_seq_ttest_t_statistic <- function(seq_ttest_arguments) {

  if (seq_ttest_arguments["one_sample"] == TRUE) {
    t_statistic <- t.test(
      x = seq_ttest_arguments["x"],
      mu = seq_ttest_arguments["mu"]
    )

  } else if (
    seq_ttest_arguments["one_sample"] == FALSE &&
    seq_ttest_arguments@paired == FALSE
    ) {
    t_statistic <- t.test(
      x = seq_ttest_arguments["x"],
      y = seq_ttest_arguments["y"],
      var.equal = TRUE
    )

  } else if (
    seq_ttest_arguments["one_sample"] == FALSE &&
    seq_ttest_arguments@paired == TRUE
    ) {
    t_statistic <- t.test(
      x = seq_ttest_arguments["x"],
      y = seq_ttest_arguments["y"],
      paired = TRUE
    )
  }

  if (seq_ttest_arguments["alternative"] == "less") {
    t_statistic$statistic <- t_statistic$statistic * -1
  }

  t_statistic
}

