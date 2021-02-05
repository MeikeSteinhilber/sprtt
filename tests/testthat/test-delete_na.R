context("delete_na: Correct deletion of the missing values in the data.")
library(sprt)

test_that("delete_na: with similar NAs in x and y", {
  x <- c(1:5,NA,NA,6:10)
  y <- c(1:5,NA,NA,6:10)
  x_test <- delete_na(x,y,one_sample = F, paired = T, "x")
  y_test <- delete_na(x,y,one_sample = F, paired = T, "y")

  expect_equal(x_test, 1:10)
  expect_equal(y_test, 1:10)

})

test_that("delete_na: with different NAs in x and y", {
  x <- c(1:3,NA,NA,4:10)
  y <- c(1:5,NA,NA,6:10)
  x_test <- delete_na(x,y,one_sample = F, paired = T, "x")
  y_test <- delete_na(x,y,one_sample = F, paired = T, "y")

  expect_equal(x_test,y_test)
  expect_equal(x_test, c(1:3,6:10))


  x <- c(1:3,NA,NA,4:10)
  y <- c(1:5,NA,NA,6:10)
  x_test <- delete_na(x,y,one_sample = F, paired = F, "x")
  y_test <- delete_na(x,y,one_sample = F, paired = F, "y")


  expect_equal(x_test, y_test)
  expect_equal(x_test, c(1:10))

})

test_that("delete_na: with y = 1", {
  x <- c(1:3,NA,NA,4:10)
  y <- 1
  x_test <- delete_na(x,y,one_sample = T, paired = F, "x")
  y_test <- delete_na(x,y,one_sample = T, paired = F, "y")

  expect_equal(x_test,1:10)
  expect_equal(y_test, 1)
})

test_that("delete_na: with y = NULL", {
  x <- c(1:3,NA,NA,4:10)
  y <- NULL
  x_test <- delete_na(x,y,one_sample = T, paired = F, "x")
  y_test <- delete_na(x,y,one_sample = T, paired = F, "y")

  expect_equal(x_test,1:10)
  expect_equal(y_test, NULL)
})
