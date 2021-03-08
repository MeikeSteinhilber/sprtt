#* @testing extract_formula
context("extract_formula: Correct extraction of the formula.")

test_that("extract_formula: effect in data: data are correct", {
  x_1 <- rnorm(5)
  x_2 <- rnorm(5)
  x <- c(x_1, x_2)
  y <- as.factor(c(rep(1,5),rep(2,5)))
  z <- x
  data <- data.frame(x, z, y)
  formula <- x ~ y

  x_test <- extract_formula(formula, data, wanted = "x")
  y_test <- extract_formula(formula, data, wanted = "y")
  x_y <- extract_formula(formula, data)
  expect_equal(x_test,x_1)
  expect_equal(y_test, x_2)
  expect_equal(x_y, list(x_1, x_2))

  data <- data.frame(a = x,c = z,b = y)
  formula <- a ~ 1
  x_test <- extract_formula(formula, data, wanted = "x")
  y_test <- extract_formula(formula, data, wanted = "y")
  expect_equal(x_test, x)
  expect_equal(y_test, 1)
})


# test_that("", {
#
#
# })
