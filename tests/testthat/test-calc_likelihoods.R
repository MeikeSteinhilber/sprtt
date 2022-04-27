#* @testing calc_likelihoods_ttest

# t-test -----------------------------------------------------------------------
context("calc_likelihoods_ttest")

test_that("calc_likelihoods_ttest: check log", {
  seq_ttest_arguments <-
    build_prototype_seq_ttest_arguments()
  t_statistic <-
    calc_t_statistic(seq_ttest_arguments)
  non_centrality_parameter <-
    calc_non_centrality_parameter_ttest(seq_ttest_arguments)
  df <- 18
  likelihoods <-
    calc_likelihoods_ttest(
      seq_ttest_arguments,
      t_statistic,
      df,
      non_centrality_parameter,
      wanted = NULL
  )
  expect_true(log(likelihoods$ratio) - likelihoods$ratio_log < 1e-5)

})

test_that("calc_likelihoods_ttest: Check warnings & messages", {
  x <- rnorm(2000000)
  d <- 5
  expect_warning(seq_ttest(x, d = d),
                 "At least one likelihood is equal to 0")

  seq_ttest_arguments <-
    build_prototype_seq_ttest_arguments()

  seq_ttest_arguments@x <- rnorm(40, mean = 0)
  seq_ttest_arguments@y <- rnorm(40, mean = 5)
  seq_ttest_arguments@alternative <- "less"

  t_statistic <-
    calc_t_statistic(seq_ttest_arguments)
  non_centrality_parameter <-
    calc_non_centrality_parameter_ttest(seq_ttest_arguments)
  df <- 78

  expect_warning(
    calc_likelihoods_ttest(
      seq_ttest_arguments,
      t_statistic,
      df,
      non_centrality_parameter,
      wanted = NULL
    )
  )
})

# ANOVA ------------------------------------------------------------------------

