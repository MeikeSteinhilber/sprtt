context("extract_formula: Correct extraction of the formula.")
library(stats)
library(base)

test_that("extract_formula: effect in data: data are correct", {
  x <- rnorm(10)
  y <- as.factor(sample(c(1,2), 50, replace = TRUE))
  x <- ifelse(y == 1, x + 0.8, x)
  z <- rnorm(10)
  data <- data.frame(x, z, y)

  a <- x
  b <- y
  c <- z

  x <- NULL
  y <- NULL
  z <- NULL

  formula <- x ~ y
  x_test <- extract_formula(formula, data, paired = F, wanted = "x")
  y_test <- extract_formula(formula, data, paired = F, wanted = "y")
  x_y <- extract_formula(formula, data, paired = F)
  expect_equal(x_test, a)
  expect_equal(y_test, b)
  expect_equal(x_y, list(a,b))

  formula <- x ~ 1
  x_test <- extract_formula(formula, data, paired = F, wanted = "x")
  y_test <- extract_formula(formula, data, paired = F, wanted = "y")
  expect_equal(x_test, a)
  expect_equal(y_test, 1)
})


# test_that("", {
#
#
# })

# expect_warning(log(0))
# expect_error(1 / 2)
# expect_message(library(mgcv), "This is mgcv")
# expect_equal(str_length("a"), 1)
# expect_identical(10, 10 + 1e-7)
# expect_match(string, "Testing")
# expect_is() #checks that an object inherit()s from a specified class
# expect_true()
# expect_false()
