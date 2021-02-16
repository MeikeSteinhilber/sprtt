#* @testing get_one_sample
context("get_one_sample: Check correct output.")
test_that("get_one_sample: Check correct output.", {

  y <- NULL
  expect_equal(
    get_one_sample(y),
    TRUE
  )
  y <- 1
  expect_equal(
    get_one_sample(y),
    TRUE
  )
  y <- 2
  expect_equal(
    get_one_sample(y),
    TRUE
  )
  y <- c(1,2,3)
  expect_equal(
    get_one_sample(y),
    FALSE
  )
  y <- list(1,2,3)
  expect_equal(
    get_one_sample(y),
    FALSE
  )

})

#* @testing get_one_sided
context("get_one_sided: Check correct output.")
test_that("get_one_sided: Check correct output.", {

    expect_equal(
    get_one_sided(alternative = "two.sided"),
    FALSE
  )
  expect_equal(
    get_one_sided(alternative = "less"),
    TRUE
  )
  expect_equal(
    get_one_sided(alternative = "greater"),
    TRUE
  )
  expect_error(
    get_one_sided(alternative = "test")
  )

})



# test_that("", {
#
#
# })


