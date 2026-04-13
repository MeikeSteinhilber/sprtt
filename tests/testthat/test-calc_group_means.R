# ANOVA ------------------------------------------------------------------------
test_that("calc_group_means", {
  # 3.ed edition necessary for expect_snapshot
  testthat::local_edition(3)
  set.seed(4657)

  seq_anova_arguments <- build_prototype_seq_anova_arguments(33, 100)

  expect_snapshot(
    show(calc_group_means(seq_anova_arguments))
  )
})
