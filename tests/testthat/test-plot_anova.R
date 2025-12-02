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

  p <- plot_anova(anova_results, position_lr_x = 200)
  vdiffr::expect_doppelganger("change lr position", p)

  sprt_results <- seq_anova(formula, f = 0.20, data = data, plot = TRUE, seq_steps = "balanced")
  p <- plot_anova(sprt_results)
  vdiffr::expect_doppelganger("balanced", p)

  sprt_results <- seq_anova(formula, f = 0.20, data = data, plot = TRUE, seq_steps = c(8, 20, 300))
  p <- plot_anova(sprt_results)
  vdiffr::expect_doppelganger("custom steps 2", p)

  sprt_results <- seq_anova(formula, f = 0.20, data = data[1:20,], plot = TRUE, seq_steps = c(8, 20))
  p <- plot_anova(sprt_results)
  vdiffr::expect_doppelganger("early stage", p)

  data <- draw_sample_normal(k_groups = 4, f = 0, max_n = 90)
  sprt_results <- seq_anova(formula, f = 0.20, data = data, plot = TRUE)
  p <- plot_anova(sprt_results, highlight_color = "green")
  vdiffr::expect_doppelganger("color change", p)

  sprt_results <- seq_anova(formula, f = 0.20, data = data, plot = TRUE, seq_steps = "balanced")
  p <- plot_anova(sprt_results, labels = FALSE)
  vdiffr::expect_doppelganger("no labels", p)

  sprt_results <- seq_anova(formula, f = 0.20, data = data, plot = TRUE, seq_steps = "balanced")
  p <- plot_anova(sprt_results, position_labels_x = 1)
  vdiffr::expect_doppelganger("position_labels_x", p)

  sprt_results <- seq_anova(formula, f = 0.20, data = data, plot = TRUE, seq_steps = "balanced")
  p <- plot_anova(sprt_results, position_labels_y = -5)
  vdiffr::expect_doppelganger("position_labels_y", p)


  sprt_results <- seq_anova(formula, f = 0.20, data = data, plot = TRUE, seq_steps = "balanced")
  p <- plot_anova(sprt_results, position_lr_x  = 300)
  vdiffr::expect_doppelganger("position_lr_x", p)

  sprt_results <- seq_anova(formula, f = 0.20, data = data, plot = TRUE, seq_steps = "balanced")
  p <- plot_anova(sprt_results, position_lr_y  = 6)
  vdiffr::expect_doppelganger("position_lr_y", p)

  sprt_results <- seq_anova(formula, f = 0.20, data = data, plot = TRUE, seq_steps = "balanced")
  p <- plot_anova(sprt_results, font_size = 6)
  vdiffr::expect_doppelganger("font_size", p)

  sprt_results <- seq_anova(formula, f = 0.20, data = data, plot = TRUE, seq_steps = "balanced")
  p <- plot_anova(sprt_results, line_size = 0.1)
  vdiffr::expect_doppelganger("line_size", p)


  data <- draw_sample_normal(k_groups = 4, f = 0, max_n = 150)
  sprt_results <- seq_anova(formula, f = 0.20, data = data, plot = TRUE, seq_steps = "balanced")
  p <- plot_anova(sprt_results, highlight_color = "darkgreen")
  vdiffr::expect_doppelganger("highlight_color", p)


  set.seed(333)
  data <- sprtt::draw_sample_normal(3, f = 0.25, max_n = 30)
  anova_results <- sprtt::seq_anova(y~x, f = 0.25, data = data, plot = TRUE)
  p <- plot_anova(anova_results,
                  labels = TRUE,
                  position_labels_x = 0.5,
                  position_labels_y = 0.1,
                  position_lr_x = 75,
                  font_size = 25,
                  line_size = 2,
                  highlight_color = "green")
  vdiffr::expect_doppelganger("exmple case all arguments", p)

  # check errors ---------------------------------------------------------------
  expect_error(sprtt::seq_anova(y~x, f = 0.25, data = data, plot = TRUE, seq_steps = "X"),
               "seq_steps")

  # wrong first data points - unequal sample sizes
  set.seed(333)
  data <- sprtt::draw_sample_normal(3, f = 0.25, max_n = 30, sample_ratio = c(1,2,2))
  data <- data[sample(nrow(data)),] # destroy the perfect order of the data
  expect_error(sprtt::seq_anova(y~x, f = 0.25, data = data, plot = TRUE),
               "Every group needs two data points.")

  data <- sprtt::draw_sample_normal(2, f = 0.25, max_n = 30)
  ttest_results <- sprtt::seq_ttest(y~x, d = 0.25, data = data)
  expect_error(plot_anova(ttest_results),
               "only works for sequential anovas")

  expect_error(plot_anova("character"),
               "must be of class seq_anova_results")

  expect_error(plot_anova(sprtt::seq_anova(y~x, f = 0.25, data = data)),
               "The anova_results@plot is NULL.")
})
