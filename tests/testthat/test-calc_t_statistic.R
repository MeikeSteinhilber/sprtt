#* @testing
# set.seed(26753)

test_that("calc_t_statistic", {
  arguments <- build_prototype_seq_ttest_arguments()

  results_package <- calc_t_statistic(arguments)
  results_ttest <- t.test(y~x, data = arguments@data, var.equal = TRUE)
  expect_equal(results_package$statistic[[1]] , results_ttest$statistic[[1]])

  arguments@data$y <- 1 # error
  arguments@one_sample <- FALSE
  arguments@paired <- TRUE
  expect_error(calc_t_statistic(arguments),
               "not possible to calculate the t-value")

  n1 = rnorm(20, mean = 2)
  n2 = rnorm(20)
  arguments <- build_seq_ttest_arguments(
    input1 = n1, y = n2,
    mu = 0, d = 0.2, alpha = 0.05, power = 0.95,
    alternative = "two.sided", paired = TRUE, data_name = "test", na.rm = FALSE)
  results_package <- calc_t_statistic(arguments)
  results_ttest <- t.test(x = n1,
                          y = n2, paired = TRUE)
  expect_equal(results_package$statistic[[1]], results_ttest$statistic[[1]])

  n1 = rnorm(20, mean = 2)
  n2 = rnorm(20)
  arguments <- build_seq_ttest_arguments(
    input1 = n1, y = n2,
    mu = 0, d = 0.2, alpha = 0.05, power = 0.95,
    alternative = "two.sided", paired = TRUE, data_name = "test", na.rm = FALSE)
  results_package <- calc_t_statistic(arguments)
  results_ttest <- t.test(x = n1,
                          y = n2,
                          alternative = arguments@alternative,
                          paired = TRUE)
  expect_equal(results_package$statistic[[1]] , results_ttest$statistic[[1]])

  arguments@alternative <- "less"
  results_package <- calc_t_statistic(arguments)
  results_ttest <- t.test(x = n1,
                          y = n2,
                          alternative = arguments@alternative,
                          paired = TRUE)
  expect_equal(results_package$statistic[[1]] , -1*results_ttest$statistic[[1]])
})

