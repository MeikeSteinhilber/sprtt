library(SPRTPackage)

context("seq_ttest: test main function")

test_that("seq_ttest: comparison results with original script from m. schnuerch", {
  x <- rnorm(20)
  d <- 0.8
  results_original <- SPRTPackage::SPRT(x = x, d = d)
  results_new <- sprt::seq_ttest(x, d = d)

  expect_equal(results_new@likelihood_ratio,
               results_original$statistic[[1]])


})

# test_that("", {
#
#
# })

