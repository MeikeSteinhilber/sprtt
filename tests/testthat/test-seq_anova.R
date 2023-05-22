#* @testing seq_anova

test_that("Compare ttest with anova results (two groups)", {
  # load packages
  # library(testthis)
  # library(dplyr)

  # skip the tests in special situations
  skip_on_cran() # skip on CRAN checks: necessary!
  # skip_on_ci() # skip on continuous platforms like GitHub Actions
  skip("seq_anova simulation: not written yet") # skip test

  # test setup: simulate the data
  testthat::source_dir(
    "testdata-raw/",
    pattern = "simulation_anova\\.[rR]$",
    env = test_env(),
    chdir = TRUE,
    wrap = TRUE
  )

  results_anova_simulation <- testthis::read_testdata("results_anova_simulation")
  # test calculation anova function vs martins implementation
  expect_equal(
    results_anova_simulation$likelihood_ratio_anova,
    results_anova_simulation$likelihood_ratio
  )
  expect_equal(
    results_anova_simulation$decision_anova,
    results_anova_simulation$decision
  )
  # test data reduction: seq_anova must be more efficient than fixed anova
  # expect less than
  expect_lte(
    mean(results_anova_simulation$sample_size_seq) /
    mean(results_anova_simulation$sample_size_fixed),
    1
  )
  # at least in 50% of the cases the seq_anova is more efficient
  percent_smaller_samples <- mean(results_anova_simulation$sample_smaller)
  expect_gte(percent_smaller_samples, 0.50)

})


test_that("seq_anova: snapshots", {
  # 3.ed edition necessary for expect_snapshot
  testthat::local_edition(3)
  set.seed(4657)

  data <- draw_sample_normal(4, 0.4, 20, sd = c(1,2,3,4), sample_ratio = c(1,2,1,3))
  expect_snapshot(
    seq_anova(y~x, f = 0.40, data = data)
  )

  df_age <- draw_sample_normal(4, 0.4, 20, sd = c(1,2,3,4), sample_ratio = c(1,2,1,3))
  colnames(df_age) <- c("age", "sex")
  expect_snapshot(
    seq_anova(age~sex, f = 0.40, data = df_age)
  )

})

test_that("seq_anova: ttest vs anova", {
  # 3.ed edition necessary for expect_snapshot
  testthat::local_edition(3)
  set.seed(4657)
  data <- draw_sample_normal(2, 0.4, 20)
  results_anova <- seq_anova(y~x, f = 0.40, data = data)
  results_ttest <- seq_ttest(y~x, d = 0.80, data = data)

  expect_equal(results_anova@likelihood_ratio, results_ttest@likelihood_ratio)
  expect_equal(results_anova@likelihood_ratio_log, results_ttest@likelihood_ratio_log)
  expect_equal(results_anova@decision, results_ttest@decision)
  expect_equal(results_anova@A_boundary_log, results_ttest@A_boundary_log)

})
