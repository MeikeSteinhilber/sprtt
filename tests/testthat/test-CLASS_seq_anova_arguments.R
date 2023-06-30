context(("CLASS_seq_anova_arguments: Check class"))

test_that("CLASS_seq_anova_arguments: Check getters", {
  arguments <- build_prototype_seq_anova_arguments()

  expect_equal(arguments["data"], arguments@data)
  expect_equal(arguments["f"], arguments@f)
  expect_equal(arguments["alpha"], arguments@alpha)
  expect_equal(arguments["power"], arguments@power)
  expect_equal(arguments["total_sample_size"], arguments@total_sample_size)
  expect_equal(arguments["data_name"], arguments@data_name)
  expect_equal(arguments["verbose"], arguments@verbose)
  # expect_equal(arguments["na.rm"], arguments@na.rm)

  expect_error(arguments["jewhf"], "Wrong slot name:")
})
