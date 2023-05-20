#* @testing draw_sample

context("draw_sample")

test_that("draw_sample: check correct behaviour", {
  set.seed(333)
  # 3.ed edition necessary for expect_snapshot
  testthat::local_edition(3)
  expect_snapshot(
    show(
      draw_sample(k_groups = 2, f = .25, max_n = 30)
    )
  )
  expect_snapshot(
    show(
      draw_sample(k_groups = 4, f = 1, sd = c(1, 0.8, 1, 1), max_n = 30)
    )
  )
  expect_snapshot(
    show(
      draw_sample(k_groups = 3,
                  f = 0.12,
                  sd = c(1, 0.8, 2),
                  sample_ratio = c(1,2,1),
                  max_n = 50)
    )
  )
})

test_that("draw_sample: check error messages", {
  expect_error(
    draw_sample(),
    'argument "k_groups"'
  )
  expect_error(
    draw_sample(max_n = 40),
    'argument "k_groups" is missing'
  )
  expect_error(
    draw_sample(k_groups = 3, max_n = 40),
    'argument "f" is missing'
  )
  expect_error(
    draw_sample(k_groups = 3, max_n = 1),
    'max_n'
  )
  expect_error(
    draw_sample(k_groups = 3, f = .4, max_n = 40, sd = c(1,1,1,1)),
    'sd'
  )
  expect_error(
    draw_sample(k_groups = 3, f = .4, max_n = 40, sd = c("1,1,1,1"))
    , 'numeric'
  )
  expect_error(
    draw_sample(k_groups = 3, f = .4, max_n = 40, sample_ratio = c(1,1)),
    'sample_ratio'
  )
  expect_error(
    draw_sample(k_groups = 3, f = .4, max_n = 40, sample_ratio = c("1","1")),
    'numeric'
  )
})
