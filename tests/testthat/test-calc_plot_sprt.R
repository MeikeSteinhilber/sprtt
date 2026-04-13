test_that("plot with ANOVA", {
  set.seed(333)
  seq_anova_arguments <- build_prototype_seq_anova_arguments()

  # check seq_steps ------------------------------------------------------------
  results <- calc_plot_anova(seq_anova_arguments, seq_steps = c(8,20,15))
  expect_true(nrow(results@plot) == 3)

  results <- calc_plot_anova(seq_anova_arguments, seq_steps = "single")
  expect_equal(results@plot$sample_size, seq(8,200,1))

  results <- calc_plot_anova(seq_anova_arguments, seq_steps = "balanced")
  expect_equal(results@plot$sample_size, seq(8,200,4))


  # wrong first data points - unequal sample sizes
  set.seed(333)
  data <- sprtt::draw_sample_normal(3, f = 0.25, max_n = 30, sample_ratio = c(1,2,2))
  seq_anova_arguments@data <- data[sample(nrow(data)),] # destroy the perfect order of the data
  expect_error(calc_plot_anova(seq_anova_arguments, seq_steps = "single"),
               "Every group needs two data points.")

})


# # ttest ------------------------------------------------------------------------
#
# test_that("plot ttest", {
#   set.seed(3333)
#   data <- draw_sample_normal(k_groups = 2, f = 0.20, max_n = 150)
#   formula <- y ~ x
#
#   sprt_results <- seq_ttest(formula, d = 0.10, data = data, plot = TRUE)
#   plot_anova(sprt_results)
#
#   set.seed(3333)
#   d <- 0.7
#   x <- rnorm(30)
#   y <- rnorm(15)
#   sprt_results <- seq_ttest(x, y, d = d, plot = TRUE)
#   plot_anova(sprt_results)
#
# })
