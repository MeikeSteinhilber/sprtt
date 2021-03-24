#* @testing seq_ttest
#*
# to run this tests: run beforehand the script:
# "data-raw/normal_results_sprtt.R"
# "data-raw/paired_results_sprtt.R"
# the simulation takes about 1.5 h
# the simulated data are stored in the folder: "test/testthat/_simulation"


test_that("Check error rates (normal): simulation results", {
  library(testthis)
  library(dplyr)

  normal_results_sprtt <- testthis::read_testdata("normal_results_sprtt")
  leeway_alpha <- 0.005
  leeway_beta <- 0.005

  alpha_errors <-
    normal_results_sprtt %>%
    filter(d == 0 & d <= d_hyp) %>%
    select(alpha, error)

  beta_errors <-
    normal_results_sprtt %>%
    filter(d != 0 & d >= d_hyp) %>%
    select(beta, error)

  expect_true(all(alpha_errors$error <= alpha_errors$alpha + leeway_alpha))
  expect_true(all(beta_errors$error <= beta_errors$beta + leeway_beta))

})

test_that("Check error rates (paired): simulation results", {
library(testthis)
library(dplyr)

  paired_results_sprtt <- testthis::read_testdata("paired_results_sprtt")
  leeway_alpha <- 0.01
  leeway_beta <- 0.02

  alpha_errors <-
    paired_results_sprtt %>%
    filter(d == 0 & d <= d_hyp) %>%
    select(alpha, error)

  beta_errors <-
    paired_results_sprtt %>%
    filter(d != 0 & d >= d_hyp) %>%
    select(beta, error)

  expect_true(all(alpha_errors$error <= alpha_errors$alpha + leeway_alpha))
  expect_true(all(beta_errors$error <= beta_errors$beta + leeway_beta))

})

