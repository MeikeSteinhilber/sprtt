test_that("plot with ANOVA", {
  set.seed(333)
  testthat::local_edition(3)

  data <- draw_sample_normal(k_groups = 4, f = 0.20, max_n = 150)
  formula <- y ~ x
  results <- seq_anova(formula, f = 0.10, data = data)

  expect_identical(results@plot, NULL)

  sprt_results <- seq_anova(formula, f = 0.10, data = data, plot = TRUE)
  p <- plot_anova(sprt_results)
  vdiffr::expect_doppelganger("general", p)

  k_groups = 4
  sprt_results <- seq_anova(formula, f = 0.10, data = data, plot = TRUE, seq_steps = c(k_groups*2, k_groups*5, k_groups*7))
  p <- plot_anova(sprt_results)
  vdiffr::expect_doppelganger("custom steps", p)

  data <- draw_sample_normal(k_groups = 4, f = 0, max_n = 90)
  anova_results <- seq_anova(formula, f = 0.20, data = data, plot = TRUE)
  p <- plot_anova(anova_results)
  vdiffr::expect_doppelganger("larger sample", p)

  p <- plot_anova(anova_results, position_lr_x = -0.5)
  vdiffr::expect_doppelganger("change lr position", p)

  sprt_results <- seq_anova(formula, f = 0.20, data = data, plot = TRUE, seq_steps = "balanced")
  p <- plot_anova(sprt_results)
  vdiffr::expect_doppelganger("balanced", p)

  sprt_results <- seq_anova(formula, f = 0.20, data = data, plot = TRUE, seq_steps = c(8, 20, 300))
  p <- plot_anova(sprt_results)
  vdiffr::expect_doppelganger("custom steps 2", p)

  data <- draw_sample_normal(k_groups = 4, f = 0, max_n = 90)
  sprt_results <- seq_anova(formula, f = 0.20, data = data, plot = TRUE)
  p <- plot_anova(sprt_results, highlight_color = "green")
  vdiffr::expect_doppelganger("color change", p)

  set.seed(333)
  data <- sprtt::draw_sample_normal(3, f = 0.25, max_n = 30)
  anova_results <- sprtt::seq_anova(y~x, f = 0.25, data = data, plot = TRUE)
  p <- plot_anova(anova_results,
                  labels = TRUE,
                  position_labels_x = 0.5,
                  position_labels_y = 0.1,
                  position_lr_x = -0.5,
                  font_size = 25,
                  line_size = 2,
                  highlight_color = "green")
  vdiffr::expect_doppelganger("exmple case all arguments", p)

  # check errors ---------------------------------------------------------------
  expect_error(sprtt::seq_anova(y~x, f = 0.25, data = data, plot = TRUE, seq_steps = "X"),
               "seq_steps")

  data <- sprtt::draw_sample_normal(2, f = 0.25, max_n = 30)
  ttest_results <- sprtt::seq_ttest(y~x, d = 0.25, data = data)
  expect_error(plot_anova(ttest_results),
               "only works for sequential anovas")

  expect_error(plot_anova("ttest_results"),
               "must be of class seq_anova_results")
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
