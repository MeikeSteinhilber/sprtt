#* @testing seq_anova

test_that("Ceck error rates", {
  # load packages
  library(testthis)
  library(dplyr)

  # skip the tests in special situations
  # skip_on_cran() # skip on CRAN checks: necessary!
  # skip_on_ci() # skip on continuous platforms like GitHub Actions
  # skip("seq_anova simulation. (Takes about 10 minutes)") # skip test

  # test setup: simulate the data
  # testthat::source_dir(
  #   "testdata-raw/",
  #   pattern = "error_rates_anova\\.[rR]$",
  #   env = test_env(),
  #   chdir = TRUE,
  #   wrap = TRUE
  # )

  error_rates_anova_simulation <- testthis::read_testdata("error_rates_anova_simulation")

  effect_data <- error_rates_anova_simulation %>%
    dplyr::filter(f_simulated != 0)

  # test data reduction: seq_anova must be more efficient than fixed anova
  # expect less than
  expect_lte(
    mean(effect_data$sample_size_seq, na.rm = TRUE) /
    mean(effect_data$sample_size_fixed, na.rm = TRUE),
    1
  )

  expect_true(
    sum(effect_data$sample_size_seq, na.rm = TRUE) /
    sum(effect_data$sample_size_fixed, na.rm = TRUE),
    1
  )
  # at least in 50% of the cases the seq_anova is more efficient
  percent_smaller_samples <- mean(error_rates_anova_simulation$sample_smaller, na.rm = TRUE)
  expect_gte(percent_smaller_samples, 0.80)

  alpha_error_table <- error_rates_anova_simulation %>%
    dplyr::filter(f_simulated == 0) %>%
    dplyr::count(decision)
  alpha_error_rate <- alpha_error_table$n[2] / sum(alpha_error_table$n)

  beta_error_table <- error_rates_anova_simulation %>%
    dplyr::filter(f_simulated != 0) %>%
    dplyr::count(decision)
  beta_error_rate <- beta_error_table$n[1] / sum(beta_error_table$n)

  expect_true(alpha_error_rate < 0.05)
  expect_true(beta_error_rate < 0.05)


})
