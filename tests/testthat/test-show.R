context("show: Check output")


test_that("show: print output?", {
  x <- rnorm(20)
  result <- seq_ttest(x, d = 0.8)
  expect_output(show(result))
  # verify_output(path = test_path(),
  #               code = {seq_ttest(x, d = 0.8)})

  x <- rnorm(20)
  result <- seq_ttest(x, d = 0.8, alternative = "less")
  expect_output(show(result))

  x <- rnorm(20)
  result <- seq_ttest(x, d = 0.8, alternative = "greater")
  expect_output(show(result))

  x <- rnorm(20)
  y <- rnorm(20)
  result <- seq_ttest(x, y, d = 0.8)
  expect_output(show(result))

  x <- rnorm(20)
  y <- rnorm(20)
  result <- seq_ttest(x, y, d = 0.8, alternative = "less")
  expect_output(show(result))

  x <- rnorm(20)
  y <- rnorm(20)
  result <- seq_ttest(x, y, d = 0.8, alternative = "less", verbose = FALSE)
  expect_output(show(result))
})


# test_that("show: correct output?", {
#   seq_ttest_arguments <- build_prototype_seq_ttest_arguments()
#   results <- calc_seq_ttest(seq_ttest_arguments)
#   expect_known_output(
#     object = show(results),
#     file = paste(getwd(),"/example_output_show.txt", sep = ""),
#     print = TRUE)
# })
