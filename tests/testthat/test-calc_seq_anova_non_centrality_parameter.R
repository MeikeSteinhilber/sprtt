test_that("calc_non_centrality_parameter", {
  # 3.ed edition necessary for expect_snapshot
  testthat::local_edition(3)
  set.seed(4657)
  seq_ttest_arguments <- build_prototype_seq_ttest_arguments()
  seq_anova_arguments <- build_prototype_seq_anova_arguments()

  expect_snapshot(
    show(
      calc_non_centrality_parameter_ttest(seq_ttest_arguments)
    )
  )
  expect_snapshot(
    show(
      calc_non_centrality_parameter_anova(seq_anova_arguments)
    )
  )
})
