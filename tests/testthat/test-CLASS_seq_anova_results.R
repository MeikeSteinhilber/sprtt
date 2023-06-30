context("CLASS_seq_anova_results: Check class")

test_that("CLASS_seq_anova_results: Check access to class", {
  data <- draw_sample_normal(4, 0.23, 35)
  results <- seq_anova(y~x, f = 0.25, data = data)

  expect_equal(results["likelihood_ratio_log"], results@likelihood_ratio_log)
  expect_equal(results["decision"], results@decision)
  expect_equal(results["A_boundary_log"], results@A_boundary_log)
  expect_equal(results["B_boundary_log"], results@B_boundary_log)
  expect_equal(results["f"], results@f)
  expect_equal(results["effect_sizes"], results@effect_sizes)
  expect_equal(results["alpha"], results@alpha)
  expect_equal(results["power"], results@power)
  expect_equal(results["likelihood_ratio"], results@likelihood_ratio)
  expect_equal(results["likelihood_1"], results@likelihood_1)
  expect_equal(results["likelihood_0"], results@likelihood_0)
  expect_equal(results["likelihood_1_log"], results@likelihood_1_log)
  expect_equal(results["likelihood_0_log"], results@likelihood_0_log)
  expect_equal(results["non_centrality_parameter"], results@non_centrality_parameter)
  expect_equal(results["F_value"], results@F_value)
  expect_equal(results["df_1"], results@df_1)
  expect_equal(results["df_2"], results@df_2)
  expect_equal(results["ss_effect"], results@ss_effect)
  expect_equal(results["ss_residual"], results@ss_residual)
  expect_equal(results["ss_total"], results@ss_total)
  expect_equal(results["total_sample_size"], results@total_sample_size)
  expect_equal(results["data_name"], results@data_name)
  expect_equal(results["verbose"], results@verbose)

  expect_error(results["gdjhfgd"], "Wrong slot name:")


})
