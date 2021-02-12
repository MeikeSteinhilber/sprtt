library(base)

context("build_ttest_arguments: Check structure of the class object")

test_that("build_ttest_arguments: errors", {
  input1 <- TRUE
  mu <- 0
  d <- 0.8
  alpha <- .05
  power <- .80
  alternative <- "two.sided"
  paired <- FALSE
  expect_error(
    build_ttest_arguments(input1, y = NULL, data = NULL,
                          mu, d, alpha, power, alternative, paired),
    "argument hast to be either 'formula' or 'numeric'"
  )
})

test_that("build_ttest_arguments: numeric", {
  input1 <- rnorm(10)
  mu <- 0
  d <- 0.8
  alpha <- .05
  power <- .80
  alternative <- "two.sided"
  paired <- FALSE
  test <- build_ttest_arguments(input1, y = NULL, data = NULL,
                                    mu, d, alpha, power, alternative, paired)
  expect_identical(test@x, input1)
  expect_identical(test@y, NULL)
  expect_identical(test@mu, mu)
  expect_identical(test@d, d)
  expect_identical(test@alpha, alpha)
  expect_identical(test@power, power)
  expect_identical(test@alternative, alternative)
  expect_identical(test@paired, paired)
  expect_identical(test@one_sample, TRUE)
  expect_identical(test@one_sided, FALSE)


  y <- rnorm(10)
  alternative <- "less"
  paired <- FALSE
  test <- build_ttest_arguments(input1, y, data = NULL,
                                mu, d, alpha, power, alternative, paired)
  expect_identical(test@x, input1)
  expect_identical(test@y, y)
  expect_identical(test@mu, mu)
  expect_identical(test@d, d)
  expect_identical(test@alpha, alpha)
  expect_identical(test@power, power)
  expect_identical(test@alternative, alternative)
  expect_identical(test@paired, paired)
  expect_identical(test@one_sample, FALSE)
  expect_identical(test@one_sided, TRUE)

  y <- rnorm(10)
  alternative <- "greater"
  paired <- TRUE
  test <- build_ttest_arguments(input1, y = NULL, data = NULL,
                                mu, d, alpha, power, alternative, paired)

  expect_identical(test@alternative, alternative)
  expect_identical(test@one_sample, TRUE)
  expect_identical(test@one_sided, TRUE)

})

test_that("build_ttest_arguments: formula", {
  input1 <- a~b
  a <- rnorm(10)
  b <- as.factor(sample(c(1,2), 10, replace = TRUE))
  mu <- 0
  d <- 0.8
  alpha <- .05
  power <- .80
  alternative <- "two.sided"
  paired <- FALSE
  test <- build_ttest_arguments(input1, y = NULL, data = NULL,
                        mu, d, alpha, power, alternative, paired)
  expect_identical(test@x, a)
  expect_identical(test@y, b)
  expect_identical(test@mu, mu)
  expect_identical(test@d, d)
  expect_identical(test@alpha, alpha)
  expect_identical(test@power, power)
  expect_identical(test@alternative, alternative)
  expect_identical(test@paired, paired)
  expect_identical(test@one_sample, FALSE)
  expect_identical(test@one_sided, FALSE)



  c <- rnorm(10)
  data <- data.frame(a,c,b)
  test <- build_ttest_arguments(input1, y = NULL, data,
                        mu, d, alpha, power, alternative, paired)
  expect_identical(test@x, a)
  expect_identical(test@y, b)

  a <- c(NA, 1:4, NA, NA, 5:10, NA)
  b <- as.factor(rep(c(1,2), 7))

  data <- data.frame(a,b)
  test <- build_ttest_arguments(input1, y = NULL, data,
                                mu, d, alpha, power, alternative, paired)
  expect_identical(test@x, 1:10)
  expect_identical(test@y,
                   as.factor(rep(c(2,1), 5)))

})

# context("")
# test_that("", {
#
#
# })
