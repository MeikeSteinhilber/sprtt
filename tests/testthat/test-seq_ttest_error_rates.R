#* @testing seq_ttest
#*
# to run this tests: run beforehand the script:
# "data-raw/simulation_data_error_rates.R"
# the simulation takes about 1.5 h
# the simulated data are stored in the folder: "test/testthat/_simulation"



test_that("Check error rates (normal): simulation results", {
  library(dplyr)
  results_sprt <- read.csv("_simulation/normal/results_sprt.csv")
  leeway <- 0.005

  alpha_errors <-
    results_sprt %>%
    filter(d == 0 & d <= d_hyp) %>%
    select(alpha, error)

  beta_errors <-
    results_sprt %>%
    filter(d != 0 & d >= d_hyp) %>%
    select(beta, error)

  expect_true(all(alpha_errors$error <= alpha_errors$alpha + leeway))

  expect_true(all(beta_errors$error <= alpha_errors$beta + leeway))

})

test_that("Check error rates (paired): simulation results", {
  library(dplyr)
  results_sprt <- read.csv("_simulation/paired/results_sprt.csv")
  leeway <- 0.005

  alpha_errors <-
    results_sprt %>%
    filter(d == 0 & d <= d_hyp) %>%
    select(alpha, error)

  beta_errors <-
    results_sprt %>%
    filter(d != 0 & d >= d_hyp) %>%
    select(beta, error)

  expect_true(all(alpha_errors$error <= alpha_errors$alpha + leeway))

  expect_true(all(beta_errors$error <= alpha_errors$beta + leeway))

})

