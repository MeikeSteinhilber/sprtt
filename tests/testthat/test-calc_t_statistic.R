#* @testing
set.seed(26753)

context("calc_seq_ttest_t_statistic: Check output")
test_that("calc_seq_ttest_t_statistic", {
  arguments <- new("seq_ttest_arguments",
                   x = rnorm(15),
                   y = NULL,
                   mu = 0,
                   d = 0.8,
                   alpha = 0.05,
                   power = 0.95,
                   alternative = "two.sided",
                   paired = FALSE,
                   one_sample = TRUE,
                   data_name = "data name",
                   na.rm = FALSE
                   )
  results_package <- calc_seq_ttest_t_statistic(arguments)
  results_ttest <- t.test(x = arguments@x)
  expect_equal(results_package$statistic[[1]] , results_ttest$statistic[[1]])

  arguments@y <- rnorm(15)
  arguments@one_sample <- FALSE
  arguments@paired <- TRUE
  results_package <- calc_seq_ttest_t_statistic(arguments)
  results_ttest <- t.test(x = arguments@x, y = arguments@y, paired = TRUE)
  expect_equal(results_package$statistic[[1]] , results_ttest$statistic[[1]])

  arguments@alternative <- "greater"
  results_package <- calc_seq_ttest_t_statistic(arguments)
  results_ttest <- t.test(x = arguments@x,
                          y = arguments@y,
                          alternative = arguments@alternative,
                          paired = TRUE)
  expect_equal(results_package$statistic[[1]] , results_ttest$statistic[[1]])

  arguments@alternative <- "less"
  results_package <- calc_seq_ttest_t_statistic(arguments)
  results_ttest <- t.test(x = arguments@x,
                          y = arguments@y,
                          alternative = arguments@alternative,
                          paired = TRUE)
  expect_equal(results_package$statistic[[1]] , -1*results_ttest$statistic[[1]])
})




# test_that("", {
#
#
# })
