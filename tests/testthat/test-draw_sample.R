#* @testing draw_sample

context("draw_sample")

test_that("draw_sample: check correct behaviour", {
  set.seed(333)
  # 3.ed edition necessary for expect_snapshot
  testthat::local_edition(3)
  expect_snapshot(
    show(
      draw_sample()
    )
  )
  expect_snapshot(
    show(
      draw_sample(k_groups = 4, sd = c(1, 0.8, 1, 1), max_n = 30)
    )
  )
})

test_that("draw_sample: check error messages", {
  expect_error(
    draw_sample(k_groups = 4),
    "k_groups needs to be equal to length of sd"
  )
})
