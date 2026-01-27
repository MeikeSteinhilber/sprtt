#* @testing check_constant_data_ttest

# t-test -----------------------------------------------------------------------

test_that("check_constant_data_ttest: check error messages", {
  message <- "Can't perform sequential t-test on constant data."

  x <- rep(2, 10)
  y <- NULL
  expect_error(
    check_constant_data_ttest(x, y),
    message
  )

  x <- rep(2, 10)
  y <- rep(2, 10)
  expect_error(
    check_constant_data_ttest(x, y),
    message
  )

  x <- rep(3, 10)
  y <- as.factor(rep(c(1,2), 5))
  expect_error(
    check_constant_data_ttest(x, y),
    message
  )

  x <- rep(2, 10)
  expect_error(
    check_constant_data_ttest(x, 1)
  )

})

test_that("check_constant_data_ttest: silent behaviour: no errors occur", {

  x <- rnorm(10)
  y <- as.factor(sample(c(1,2), 10, replace = TRUE))
  x <- ifelse(y == 1, x + 0.8, x)
  expect_silent(
    check_constant_data_ttest(x, y)
  )

  x <- rnorm(10)
    expect_silent(
    check_constant_data_ttest(x, 1)
  )
})

# ANOVA ------------------------------------------------------------------------

test_that("check_constant_data_anova: check error messages", {
  message <- "Can't perform sequential ANOVA on constant data."

  y <- rep(c(1,2,3), 10)
  factor_A <- as.factor(rep(c(1,2,3), 10))
  data <- data.frame(y, factor_A)
  expect_error(
    check_constant_data_anova(data),
    message
  )
})
