#* @testing seq_anova

test_that("Compare results with Martins Implementation", {
  # load packages
  library(testthis)
  library(dplyr)

  # skip the tests in special situations
  # skip_on_cran() # skip on CRAN checks: necessary!
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
