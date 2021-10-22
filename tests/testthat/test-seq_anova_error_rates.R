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
  testthat::source_dir(
    "testdata-raw/",
    pattern = "error_rates_anova\\.[rR]$",
    env = test_env(),
    chdir = TRUE,
    wrap = TRUE
  )

  all_data <- testthis::read_testdata("error_rates_anova_simulation")

  effect_data <- all_data %>%
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
  # at least in 80% of the cases the seq_anova is more efficient
  percent_smaller_samples <- mean(effect_data$sample_smaller)
  expect_true(percent_smaller_samples > 0.80)

  alpha_error_table <- all_data %>%
    dplyr::filter(f_simulated == 0) %>%
    dplyr::count(decision)
  alpha_error_rate <- alpha_error_table$n[2] / sum(alpha_error_table$n)

  # all_data <- all_data %>%
  #   dplyr::filter(f_simulated == 0) %>%
  #   dplyr::group_by(f_expected) %>%
  #   dplyr::mutate(alpha_error_f = mean(decision))

  beta_error_table <- all_data %>%
    dplyr::filter(f_simulated != 0) %>%
    dplyr::count(decision)
  beta_error_rate <- beta_error_table$n[1] / sum(beta_error_table$n)

  error_f_alpha <- all_data %>%
    dplyr::filter(f_simulated == 0) %>%
    dplyr::group_by(f_expected) %>%
    dplyr::mutate(error_f_ = mean(decision)) %>%
    dplyr::ungroup() %>%
    dplyr::pull(error_f_)

  error_f_beta <- all_data %>%
    dplyr::filter(f_simulated != 0) %>%
    dplyr::group_by(f_expected) %>%
    dplyr::mutate(error_f_ = 1 - mean(decision)) %>%
    dplyr::ungroup() %>%
    dplyr::pull(error_f_)

  all_data <- all_data %>%
    dplyr::mutate(error_f = c(error_f_alpha, error_f_beta))

  expect_true(alpha_error_rate < 0.05)
  expect_true(beta_error_rate < 0.05)


})
