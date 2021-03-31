context("CLASS_seq_ttest_results: Check class")
test_that("CLASS_seq_ttest_results: Check access to class", {
  x <- rnorm(20)
  d <- 0.8
  results <- seq_ttest(x, d = d)

  expect_equal(results["likelihood_ratio_log"], results@likelihood_ratio_log)
  expect_equal(results["decision"], results@decision)
  expect_equal(results["A_boundary_log"], results@A_boundary_log)
  expect_equal(results["B_boundary_log"], results@B_boundary_log)
  expect_equal(results["d"], results@d)
  expect_equal(results["mu"], results@mu)
  expect_equal(results["alpha"], results@alpha)
  expect_equal(results["power"], results@power)
  expect_equal(results["likelihood_ratio"], results@likelihood_ratio)
  expect_equal(results["likelihood_1"], results@likelihood_1)
  expect_equal(results["likelihood_0"], results@likelihood_0)
  expect_equal(results["likelihood_1_log"], results@likelihood_1_log)
  expect_equal(results["likelihood_0_log"], results@likelihood_0_log)
  expect_equal(results["non_centrality_parameter"], results@non_centrality_parameter)
  expect_equal(results["t_value"], results@t_value)
  expect_equal(results["p_value"], results@p_value)
  expect_equal(results["df"], results@df)
  expect_equal(results["mean_estimate"], results@mean_estimate)
  expect_equal(results["alternative"], results@alternative)
  expect_equal(results["one_sample"], results@one_sample)
  expect_equal(results["ttest_method"], results@ttest_method)
  expect_equal(results["data_name"], results@data_name)
  expect_equal(results["verbose"], results@verbose)

  expect_error(results["gdjhfgd"], "Wrong slot name:")


})
