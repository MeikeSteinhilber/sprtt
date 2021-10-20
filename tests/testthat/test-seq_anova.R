#* @testing seq_anova

test_that("Check results", {
  # load packages
  library(testthis)
  library(dplyr)

  # skip the tests in special situations
  skip_on_cran() # skip on CRAN checks: necessary!
  # skip_on_ci() # skip on continuous platforms like GitHub Actions
  # skip("seq_anova simulation. (Takes about 10 minutes)") # skip test

  # test setup: simulate the data
  # source_dir(
  #   "testdata-raw/",
  #   pattern = "anova\\.[rR]$",
  #   env = test_env(),
  #   chdir = TRUE,
  #   wrap = TRUE
  # )

  results_anova_simulation <- testthis::read_testdata("results_anova_simulation")

  expect_equal(
    results_anova_simulation$likelihood_ratio_anova,
    results_anova_simulation$likelihood_ratio
  )
  expect_equal(
    results_anova_simulation$decision_anova,
    results_anova_simulation$decision
  )

  # expect_lte(
  #
  # )


})
