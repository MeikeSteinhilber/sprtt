context("calc_boundaries")

test_that("calc_boundaries: ", {
  power <- 0.95
  alpha <- 0.05
  boundaries <- calc_boundaries(power, alpha)
  boundaries_log <- calc_boundaries(power, alpha, log = TRUE)
  expect_equal(log(boundaries$A), boundaries_log$A)
  expect_equal(log(boundaries$B), boundaries_log$B)
  expect_equal(boundaries_log$A, boundaries_log$B * -1) #log boundaries ar symmetrical if alpha & beta are equal

  power <- 0.80
  alpha <- 0.10
  boundaries <- calc_boundaries(power, alpha)
  boundaries_log <- calc_boundaries(power, alpha, log = TRUE)
  expect_equal(log(boundaries$A), boundaries_log$A)
  expect_equal(log(boundaries$B), boundaries_log$B)
})
