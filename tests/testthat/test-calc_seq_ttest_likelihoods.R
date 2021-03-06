#* @testing calc_seq_ttest_likelihoods
context("calc_seq_ttest_likelihoods")

test_that("calc_seq_ttest_likelihoods: CPP comparison", {
  seq_ttest_arguments <- build_prototype_seq_ttest_arguments()
  t_statistic <- calc_seq_ttest_t_statistic(seq_ttest_arguments)
  non_centrality_parameter <- calc_non_centrality_parameter(seq_ttest_arguments)
  df <- 18
  likelihoods <- calc_seq_ttest_likelihoods(seq_ttest_arguments, t_statistic, df, non_centrality_parameter, wanted = NULL)
  expect_equal(log(likelihoods$ratio), likelihoods$ratio_log)

})

test_that("calc_seq_ttest_likelihoods: Check warnings & messages", {
  x <- rnorm(2000000)
  d <- 5
  expect_warning(seq_ttest(x, d = d),
                 "At least one likelihood is equal to 0")

  seq_ttest_arguments <- build_prototype_seq_ttest_arguments()
  seq_ttest_arguments["x"] <- rnorm(40, mean = 0)
  seq_ttest_arguments["y"] <- rnorm(40, mean = 5)
  seq_ttest_arguments["alternative"] <- "less"
  # calc_seq_ttest(seq_ttest_arguments)
  t_statistic <- calc_seq_ttest_t_statistic(seq_ttest_arguments)
  non_centrality_parameter <- calc_non_centrality_parameter(seq_ttest_arguments)
  df <- 78
  expect_warning(calc_seq_ttest_likelihoods(seq_ttest_arguments, t_statistic, df, non_centrality_parameter, wanted = NULL))


})



# test_that("", {
#
#
# })
