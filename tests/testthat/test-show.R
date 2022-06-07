context("show: Check output")

# t-TEST -----------------------------------------------------------------------
test_that("show: print output ttest?", {
  # 3.ed edition necessary for expect_snapshot
  testthat::local_edition(3)
  set.seed(4657)

  expect_snapshot(
    show(
      seq_ttest(
        rnorm(20),
        d = 0.8)
    )
  )

  x_special_name <- rnorm(20)
  expect_snapshot(
    show(
      seq_ttest(x_special_name, d = 0.8, alternative = "less", mu = 2)
    )
  )

  x <- rnorm(20)
  result <-
  expect_snapshot(
    show(
      seq_ttest(x, d = 0.8, alternative = "greater")
    )
  )

  x_special_name <- rnorm(20)
  y_secial_name <- rnorm(20)
  expect_snapshot(
    show(
      seq_ttest(x_special_name, y_secial_name, d = 0.8)
    )
  )

  x <- rnorm(20)
  y <- rnorm(20)
  expect_snapshot(
    show(
      seq_ttest(x, y, d = 0.8, alternative = "less")
    )
  )

  x <- rnorm(20)
  y <- as.factor(rep(c(0, 1), 10))
  expect_snapshot(
    show(
      seq_ttest(
        x ~ y,
        d = 0.8)
    )
  )
})

test_that("show: verbose", {
  # 3.ed edition necessary for expect_snapshot
  testthat::local_edition(3)

  expect_snapshot(
    show(
      calc_seq_ttest(
        build_prototype_seq_ttest_arguments()
      )
    )
  )

  expect_snapshot(
    show(
      calc_seq_ttest(
        build_prototype_seq_ttest_arguments(),
        verbose = FALSE
      )
    )
  )


})

# ANOVA ------------------------------------------------------------------------
test_that("show: print output anova?", {
  # 3.ed edition necessary for expect_snapshot
  testthat::local_edition(3)
  set.seed(4657)

  data <- draw_sample(f = 0.25)
  expect_snapshot(
    show(
      seq_anova(
        y ~ x,
        f = 0.25,
        data = data)
    )
  )

  data <- draw_sample(f = 0.25)
  colnames(data) <- c("happiness", "job_satisfaction")
  expect_snapshot(
    show(
      seq_anova(
        happiness ~ job_satisfaction,
        f = 0.25,
        data = data)
    )
  )

  data <- draw_sample(k_groups = 4, f = 0.1, sd = c(1,1,1,1), max_n = 20)
  expect_snapshot(
    show(
      seq_anova(
        y ~ x,
        f = 0.1,
        data = data)
    )
  )

  data <- draw_sample(k_groups = 2, f = 0.5, sd = c(1, 1), max_n = 60)
  expect_snapshot(
    show(
      seq_anova(
        y ~ x,
        f = 0.25,
        data = data)
    )
  )
})
