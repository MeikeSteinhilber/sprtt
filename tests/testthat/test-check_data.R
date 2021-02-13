context("check_data: check correct behaviour")

test_that("check_data: numeric: Correct activation of errors", {
  input1 <- 5

  x <- list(1:5, 9:5)
  y <- c(1:5, 9:5)
  expect_error(
    check_data(input1, x, y, paired = FALSE),
    "must be numeric"
  )
  x <- c(1:5, 9:5)
  y <- list(1:5, 9:5)
  expect_error(
    check_data(input1, x, y, paired = FALSE),
    "must be numeric"
  )
  x <- rnorm(10)
  y <- as.factor(sample(c(1,2), 10, replace = TRUE))
  expect_error(
    check_data(input1, x, y, paired = FALSE),
    "grouping factor"
  )
  x <- rnorm(1)
  y <- rnorm(1)
  expect_error(
    check_data(input1, x, y, paired = FALSE),
    "at least 3 observations"
  )
  x <- rnorm(5)
  y <- rnorm(5)
  expect_error(
    check_data(input1, x, y, paired = 5),
    " Must be logical"
  )

})


# test_that("check_data: formula: Correct activation of errors", {
#   input1 <- x~y
#
#   x <- rnorm(1)
#   y <- as.factor(2)
#   expect_error(
#     check_data(input1, x, y, paired = FALSE),
#     "at least 3 observations"
#   )
#   x <- rnorm(3)
#   y <- c(2,5,2)
#   expect_error(
#     check_data(input1, x, y, paired = FALSE),
#     "grouping factor"
#   )
#   x <- rnorm(5)
#   y <- as.factor(c(1,1,1,1,2))
#   expect_error(
#     check_data(input1, x, y, paired = TRUE),
#     "Unequal number of observations"
#   )
#   x <- c(2,5)
#   y <- as.factor(c(1,2))
#   expect_error(
#     check_data(input1, x, y, paired = FALSE),
#     "at least 3 observations"
#   )

# })


# context("")
# test_that("", {
#
#
# })

