test_that("plot with ANOVA", {
  set.seed(3333)
  data <- draw_sample_normal(k_groups = 4, f = 0.20, max_n = 150)
  formula <- y ~ x
  results <- seq_anova(formula, f = 0.10, data = data)

  expect_equal(results@plot, NULL)

  sprt_results <- seq_anova(formula, f = 0.10, data = data, plot = TRUE)
  plot_sprt(sprt_results)

  sprt_results <- seq_anova(formula, f = 0.10, data = data, plot = TRUE, seq_steps = c(k_groups*2, k_groups*5, k_groups*7))
  plot_sprt(sprt_results)

  data <- draw_sample_normal(k_groups = 4, f = 0, max_n = 90)
  sprt_results <- seq_anova(formula, f = 0.20, data = data, plot = TRUE)
  plot_sprt(sprt_results)

  sprt_results <- seq_anova(formula, f = 0.20, data = data, plot = TRUE, seq_steps = "balanced")
  sprt_results <- seq_anova(formula, f = 0.20, data = data, plot = TRUE, seq_steps = c(8, 20, 300))
  plot_sprt(sprt_results)

  data <- draw_sample_normal(k_groups = 4, f = 0, max_n = 90)
  sprt_results <- seq_anova(formula, f = 0.20, data = data, plot = TRUE)
  plot_sprt(sprt_results, highlight_color = "green")

})

# ttest ------------------------------------------------------------------------

test_that("plot ttest", {
  set.seed(3333)
  data <- draw_sample_normal(k_groups = 2, f = 0.20, max_n = 150)
  formula <- y ~ x

  sprt_results <- seq_ttest(formula, d = 0.10, data = data, plot = TRUE)
  plot_sprt(sprt_results)

  set.seed(3333)
  d <- 0.7
  x <- rnorm(30)
  y <- rnorm(15)
  sprt_results <- seq_ttest(x, y, d = d, plot = TRUE)
  plot_sprt(sprt_results)

})
