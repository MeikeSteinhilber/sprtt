#* @testing seq_ttest

test_that("Check error rates", {
  # load packages
  library(testthis)
  library(dplyr)

  # skip the tests in special situations
  skip_on_cran() # skip on CRAN checks: necessary!
  skip_on_ci() # skip on continuous platforms like GitHub Actions
  skip("Check error rates. (Takes about 10 minutes)") # skip test

  # test setup: simulate the data
  source_dir(
    "testdata-raw/",
    pattern = "\\.[rR]$",
    env = test_env(),
    chdir = TRUE,
    wrap = TRUE
  )

  results_2sample_1sided <- testthis::read_testdata("results_2sample_1sided")
  results_2sample_2sided <- testthis::read_testdata("results_2sample_2sided")
  results_1sample_2sided <- testthis::read_testdata("results_1sample_2sided")

  expect_true(all(results_2sample_1sided$alert == 0))
  expect_true(all(results_2sample_2sided$alert == 0))
  expect_true(all(results_1sample_2sided$alert == 0))

})



