#* @testing check_formula
context("check_formula: Correct error messages.")

test_that("check_formula: Check structure: Correct error messages", {
  x <- 1:10
  y <- as.factor(c(rep(1,5), rep(2,5)))
  data <- data.frame(x, z = x, y)
  formula <- x~y
  paired <- FALSE

  expect_error(
    check_formula(formula = NULL, data, paired),
    "'formula' is incorrect."
  )
  expect_error(
    check_formula(formula = x~y+z, data, paired),
    "'formula' is incorrect."
  )

})

test_that("check_formula: Check y: Correct messages", {
  x <- rnorm(20, mean = 0, sd = 1)
  y <- c(rep(1, 10), rep(2, 10))
  expect_error(
    seq_ttest(x ~ y, d = 0.8),
    "is not a factor"
  )


  x <- 1:10
  y_2 <- as.factor(c(rep(1,5), rep(2,5)))
  y_3 <- as.factor(c(rep(1,4), rep(2,5), 3))
  formula <- x~y
  paired <- FALSE

  data <- data.frame(x, y = rep(c(2,1), 5))
  expect_error(
    check_formula(formula, data, paired),
    "is not a factor"
  )

  data <- data.frame(x, y = y_3)
  expect_error(
    check_formula(formula, data, paired),
    "contain exactly two levels"
  )

  data <- data.frame(x, y = y_2)
  formula <- x ~ 5
  expect_error(
    check_formula(formula, data, paired)
  )

  x <- 1:10
  y <- as.factor(c(rep(1,3), rep(2,7)))
  expect_error(
    check_formula(x ~ y, data = data.frame(x,y), paired = TRUE),
    "Unequal number of observations per group"
  )
})

test_that("check_formula: silent behaviour: no errors occur", {

  x <- 1:10
  y <- as.factor(c(rep(1,5), rep(2,5)))
  z <- 1:10
  data <- data.frame(x, z, y)
  formula <- x~y
  paired <- FALSE

  expect_silent(
    check_formula(formula = x~y, data, paired)
  )
  expect_silent(
    check_formula(formula = x ~ 1, data, paired)
  )

  data <- data.frame(a = x, c = z, b = y, paired)
  expect_silent(
    check_formula(formula = a ~ b, data, paired)
  )

})


# test_that("", {
#
#
# })
