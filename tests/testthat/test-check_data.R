#* @testing check_data

# t-test -----------------------------------------------------------------------

context("check_data_ttest: check correct behaviour")

test_that("check_data_ttest: numeric: Correct activation of errors", {

  x <- list(1:5, 9:5)
  y <- c(1:5, 9:5)
  expect_error(
    check_data_ttest(x, y, paired = FALSE),
    "must be numeric"
  )
  x <- c(1:5, 9:5)
  y <- list(1:5, 9:5)
  expect_error(
    check_data_ttest(x, y, paired = FALSE),
    "must be numeric"
  )
  x <- rnorm(10)
  y <- as.factor(sample(c(1,2), 10, replace = TRUE))
  expect_error(
    check_data_ttest(x, y, paired = FALSE),
    "grouping factor"
  )
  x <- rnorm(1)
  y <- rnorm(1)
  expect_error(
    check_data_ttest(x, y, paired = FALSE),
    "at least 3 observations"
  )
  x <- rnorm(5)
  y <- rnorm(5)
  expect_error(
    check_data_ttest(x, y, paired = 5),
    " Must be logical"
  )
})

# ANOVA ------------------------------------------------------------------------

context("check_data_ttest: check correct behaviour")

test_that("check_data_ttest: numeric: Correct activation of errors", {
  data <- draw_sample_normal(k_groups = 2, f = 0, max_n = 10)
  colnames(data) <- c("y", "factor_A")
  formula <- y~factor_A
  data$y <- as.character(data$y)
  expect_error(
    check_data_anova(data),
    "Invalid argument: y must be numeric "
  )

  data <- draw_sample_normal(k_groups = 2, f = 0, max_n = 2)[1:2,]
  colnames(data) <- c("y", "factor_A")
  formula <- y~factor_A
  expect_error(
    check_data_anova(data),
    "Requires at least 3 observations"
  )

  data <- draw_sample_normal(k_groups = 2, f = 0, sample_ratio = c(3, 1), max_n = 2)[1:3,]
  colnames(data) <- c("y", "factor_A")
  formula <- y~factor_A
  expect_error(
    check_data_anova(data),
    "A factor needs at least 2 levels."
  )

  data <- draw_sample_normal(k_groups = 2, f = 0, sd = c(1, 1), max_n = 2)
  colnames(data) <- c("y", "factor_A")
  formula <- y~factor_A
  expect_silent(
    check_data_anova(data)
  )

  data <- draw_sample_normal(k_groups = 2, f = 0, sample_ratio = c(3, 1), max_n = 2)[1:4,]
  colnames(data) <- c("y", "factor_A")
  formula <- y~factor_A
  expect_error(
    check_data_anova(data),
    "Every group needs at least two observations"
  )
  data <- draw_sample_normal(k_groups = 3, f = 0, sample_ratio = c(3, 2, 1), max_n = 2)[1:6,]
  colnames(data) <- c("y", "factor_A")
  formula <- y~factor_A
  expect_error(
    check_data_anova(data),
    "Every group needs at least two observations"
  )

})
