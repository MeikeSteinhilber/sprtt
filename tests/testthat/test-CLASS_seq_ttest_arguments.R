context(("CLASS_seq_ttest_arguments: Check class"))

test_that("CLASS_seq_ttest_arguments: Check getters", {
  arguments <- build_prototype_seq_ttest_arguments()
  expect_equal(arguments["x"], arguments@x)
  expect_equal(arguments["y"], arguments@y)
  expect_equal(arguments["mu"], arguments@mu)
  expect_equal(arguments["d"], arguments@d)
  expect_equal(arguments["alpha"], arguments@alpha)
  expect_equal(arguments["power"], arguments@power)
  expect_equal(arguments["alternative"], arguments@alternative)
  expect_equal(arguments["paired"], arguments@paired)
  expect_equal(arguments["one_sample"], arguments@paired)
  expect_equal(arguments["data_name"], arguments@data_name)
  expect_equal(arguments["na.rm"], arguments@na.rm)

  expect_error(arguments["jewhf"], "Wrong slot name:")
})


