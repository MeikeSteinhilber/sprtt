#* @testing check_constant_data

library(base)

context("check_constant_data: check error messages")

test_that("check_constant_data: check error messages", {
  message = "Can't perform SPRT on constant data."

  x <- rep(2, 10)
  y <- rep(2, 10)
  expect_error(
    check_constant_data(x, y),
    message
  )

  x <- rep(3, 10)
  y <- as.factor(rep(c(1,2), 5))
  expect_error(
    check_constant_data(x, y),
    message
  )

  x <- rep(2, 10)
  expect_error(
    check_constant_data(x, 1)
  )

})

test_that("check_constant_data: silent behaviour: no errors occur", {

  x <- rnorm(10)
  y <- as.factor(sample(c(1,2), 10, replace = TRUE))
  x <- ifelse(y == 1, x + 0.8, x)
  expect_silent(
    check_constant_data(x, y)
  )

  x <- rnorm(10)
    expect_silent(
    check_constant_data(x, 1)
  )

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
