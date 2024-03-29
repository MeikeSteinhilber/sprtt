#* @testing draw_sample_normal

context("draw_sample_normal")

test_that("draw_sample_normal: check correct behaviour", {
  set.seed(333)
  # 3.ed edition necessary for expect_snapshot
  testthat::local_edition(3)
  expect_snapshot(
    show(
      draw_sample_normal(k_groups = 2, f = .25, max_n = 30)
    )
  )
  expect_snapshot(
    show(
      draw_sample_normal(k_groups = 4, f = 1, sd = c(1, 0.8, 1, 1), max_n = 30)
    )
  )
  expect_snapshot(
    show(
      draw_sample_normal(k_groups = 3,
                  f = 0.12,
                  sd = c(1, 0.8, 2),
                  sample_ratio = c(1,2,1),
                  max_n = 50)
    )
  )
})

test_that("draw_sample_normal: check error messages", {
  expect_error(
    draw_sample_normal(),
    'argument "k_groups" is missing, with no default'
  )
  expect_error(
    draw_sample_normal(k_groups = 4),
    'argument "f" is missing'
  )
  expect_error(
    draw_sample_normal(k_groups = 3, f = 2),
    'argument "max_n" is missing'
  )

  expect_error(
    draw_sample_normal(k_groups = "3", f = 2, max_n = 10),
    'k_groups must be numeric.'
  )
  expect_error(
    draw_sample_normal(k_groups = 3, f = "2", max_n = 10),
    'f must be numeric.'
  )
  expect_error(
    draw_sample_normal(k_groups = 3, f = 2, max_n = "10"),
    'max_n must be numeric.'
  )

  expect_error(
    draw_sample_normal(k_groups = 0, f = 2, max_n = 10),
    'k_groups must be larger than 1.'
  )
  expect_error(
    draw_sample_normal(k_groups = 1, f = 2, max_n = 10),
    'k_groups must be larger than 1.'
  )
  expect_error(
    draw_sample_normal(k_groups = 2, f = -2, max_n = 10),
    'argument f must be equal to or larger than 0.'
  )
  expect_error(
    draw_sample_normal(k_groups = 3, f = 2, max_n = 0),
    'argument max_n must be larger than 1.'
  )


  expect_error(
    draw_sample_normal(k_groups = 3, f = 10, max_n = 1),
    'total sample size must be greater than k_groups.'
  )
  expect_error(
    draw_sample_normal(k_groups = 3, f = .4, max_n = 40, sd = c(1,1,1,1)),
    'sd'
  )
  expect_error(
    draw_sample_normal(k_groups = 3, f = .4, max_n = 40, sd = c("1,1,1,1"))
    , 'numeric'
  )
  expect_error(
    draw_sample_normal(k_groups = 3, f = .4, max_n = 40, sample_ratio = c(1,1)),
    'sample_ratio'
  )
  expect_error(
    draw_sample_normal(k_groups = 3, f = .4, max_n = 40, sample_ratio = c("1","1")),
    'numeric'
  )
})

test_that("draw_sample_normal: check correct behaviour", {
  set.seed(333)
  # 3.ed edition necessary for expect_snapshot
  testthat::local_edition(3)
  expect_snapshot(
    show(
      draw_sample_normal(k_groups = 2, f = .25, max_n = 30)
    )
  )
  expect_snapshot(
    show(
      draw_sample_normal(k_groups = 4, f = 1, sd = c(1, 0.8, 1, 1), max_n = 30)
    )
  )
  expect_snapshot(
    show(
      draw_sample_normal(k_groups = 3,
                  f = 0.12,
                  sd = c(1, 0.8, 2),
                  sample_ratio = c(1,2,1),
                  max_n = 50)
    )
  )
})

test_that("draw_sample_normal: check error messages", {
  expect_error(
    draw_sample_normal(),
    'argument "k_groups" is missing, with no default'
  )
  expect_error(
    draw_sample_normal(k_groups = 4),
    'argument "f" is missing'
  )
  expect_error(
    draw_sample_normal(k_groups = 3, f = 2),
    'argument "max_n" is missing'
  )

  expect_error(
    draw_sample_normal(k_groups = "3", f = 2, max_n = 10),
    'k_groups must be numeric.'
  )
  expect_error(
    draw_sample_normal(k_groups = 3, f = "2", max_n = 10),
    'f must be numeric.'
  )
  expect_error(
    draw_sample_normal(k_groups = 3, f = 2, max_n = "10"),
    'max_n must be numeric.'
  )

  expect_error(
    draw_sample_normal(k_groups = 0, f = 2, max_n = 10),
    'k_groups must be larger than 1.'
  )
  expect_error(
    draw_sample_normal(k_groups = 1, f = 2, max_n = 10),
    'k_groups must be larger than 1.'
  )
  expect_error(
    draw_sample_normal(k_groups = 2, f = -2, max_n = 10),
    'argument f must be equal to or larger than 0.'
  )
  expect_error(
    draw_sample_normal(k_groups = 3, f = 2, max_n = 0),
    'argument max_n must be larger than 1.'
  )


  expect_error(
    draw_sample_normal(k_groups = 3, f = 10, max_n = 1),
    'total sample size must be greater than k_groups.'
  )
  expect_error(
    draw_sample_normal(k_groups = 3, f = .4, max_n = 40, sd = c(1,1,1,1)),
    'sd'
  )
  expect_error(
    draw_sample_normal(k_groups = 3, f = .4, max_n = 40, sd = c("1,1,1,1"))
    , 'numeric'
  )
  expect_error(
    draw_sample_normal(k_groups = 3, f = .4, max_n = 40, sample_ratio = c(1,1)),
    'sample_ratio'
  )
  expect_error(
    draw_sample_normal(k_groups = 3, f = .4, max_n = 40, sample_ratio = c("1","1")),
    'numeric'
  )
})

# mixture distribution ---------------------------------------------------------
test_that("draw_sample_normal: check correct behaviour", {
  set.seed(333)
  # 3.ed edition necessary for expect_snapshot
  testthat::local_edition(3)
  expect_snapshot(
    show(
      draw_sample_mixture(k_groups = 2, f = .25, max_n = 30)
    )
  )
  expect_snapshot(
    show(
      draw_sample_mixture(k_groups = 4, f = 1, max_n = 30, verbose = TRUE)
    )
  )
  expect_snapshot(
    show(
      draw_sample_mixture(k_groups = 3,
                         f = 0.12,
                         max_n = 50,
                         verbose = TRUE)
    )
  )
})

test_that("draw_sample_mixture: check error messages", {
  expect_error(
    draw_sample_mixture(),
    'argument "k_groups" is missing, with no default'
  )
  expect_error(
    draw_sample_mixture(k_groups = 4),
    'argument "f" is missing'
  )
  expect_error(
    draw_sample_mixture(k_groups = 3, f = 0.2),
    'argument "max_n" is missing'
  )

  expect_error(
    draw_sample_mixture(k_groups = "3", f = 0.2, max_n = 10),
    'k_groups must be numeric.'
  )
  expect_error(
    draw_sample_mixture(k_groups = 3, f = "0.2", max_n = 10),
    'f must be numeric.'
  )
  expect_error(
    draw_sample_mixture(k_groups = 3, f = 0.4, max_n = "10"),
    'max_n must be numeric.'
  )
  expect_error(
    draw_sample_mixture(k_groups = 3, f = 0.4, max_n = 10, counter_n = "1000"),
    'counter_n must be numeric.'
  )
  expect_error(
    draw_sample_mixture(k_groups = 3, f = 0.4, max_n = 10, counter_n = -2),
    'argument counter_n must be equal to or larger than 1'
  )

  expect_error(
    draw_sample_mixture(k_groups = 0, f = 0.2, max_n = 10),
    'k_groups must be larger than 1.'
  )
  expect_error(
    draw_sample_mixture(k_groups = 1, f = 0.2, max_n = 10),
    'k_groups must be larger than 1.'
  )
  expect_error(
    draw_sample_mixture(k_groups = 2, f = -0.2, max_n = 10),
    'argument f must be equal to or larger than 0.'
  )
  expect_error(
    draw_sample_mixture(k_groups = 3, f = 0.2, max_n = 0),
    'argument max_n must be larger than 1.'
  )
  expect_error(
    draw_sample_mixture(k_groups = 3, f = 0.2, max_n = 1),
    'total sample size must be greater than k_groups.'
  )
  expect_message(
    draw_sample_mixture(k_groups = 4, f = 1.51, max_n = 5,
                        counter_n = 1000000, verbose = TRUE),
  "f values larger than 1.5 should not be used in this function."
  )
  expect_error(
    draw_sample_mixture(k_groups = 4, f = 4, max_n = 5,
                        counter_n = 100, verbose = TRUE),
  "Internal calulation failed:"
  )

})

# check effect size structure od the simulated data ----------------------------


