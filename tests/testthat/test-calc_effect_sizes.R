
test_that("calc_effect_sizes", {
  # 3.ed edition necessary for expect_snapshot
  testthat::local_edition(3)
  set.seed(333)

  expect_error(
    effect_sizes(NULL, 1:10),
    "formula"
  )

  expect_error(
    effect_sizes(x~k, NULL),
    "data"
  )


  formula <- y ~ x
  df_no_effect <- draw_sample_normal(k_groups = 4, f = 0, max_n = 20)
  df_0.01_effect <- draw_sample_normal(k_groups = 4, f = 0.01, max_n = 500)
  df_0.10_effect <- draw_sample_normal(k_groups = 4, f = 0.10, max_n = 200)
  df_0.25_effect <- draw_sample_normal(k_groups = 3, f = 0.25, max_n = 50)
  df_0.40_effect <- draw_sample_normal(k_groups = 5, f = 0.40, max_n = 10)
  df_2_effect <- draw_sample_normal(k_groups = 2, f = 2, max_n = 10)

  expect_equal(ignore_attr = TRUE,
    effect_sizes(formula, df_no_effect)$cohens_f,
    effectsize::cohens_f(verbose = FALSE,
                         lm(formula, df_no_effect))$Cohens_f
  )

  expect_equal(ignore_attr = TRUE,
    effect_sizes(formula, df_0.01_effect)$cohens_f,
    effectsize::cohens_f(verbose = FALSE,
                         lm(formula, df_0.01_effect))$Cohens_f
  )
  expect_equal(ignore_attr = TRUE,
    effect_sizes(formula, df_0.10_effect)$cohens_f,
    effectsize::cohens_f(verbose = FALSE,
                         lm(formula, df_0.10_effect))$Cohens_f
  )
  expect_equal(ignore_attr = TRUE,
    effect_sizes(formula, df_0.25_effect)$cohens_f,
    effectsize::cohens_f(verbose = FALSE,
                         lm(formula, df_0.25_effect))$Cohens_f
  )
  expect_equal(ignore_attr = TRUE,
    effect_sizes(formula, df_0.40_effect)$cohens_f,
    effectsize::cohens_f(verbose = FALSE,
                         lm(formula, df_0.40_effect))$Cohens_f
  )
  expect_equal(ignore_attr = TRUE,
    effect_sizes(formula, df_2_effect)$cohens_f,
    effectsize::cohens_f(verbose = FALSE,
                         lm(formula, df_2_effect))$Cohens_f
  )

})


test_that("snaphot: effect_size", {
  # 3.ed edition necessary for expect_snapshot
  testthat::local_edition(3)
  set.seed(333)

  df_no_effect <- draw_sample_normal(k_groups = 4, f = 0, max_n = 2000)
  df_no_effect_extreme <- draw_sample_normal(k_groups = 4, f = 0, max_n = 20000)
  df_0.01_effect <- draw_sample_normal(k_groups = 4, f = 0.01, max_n = 500)
  df_0.10_effect <- draw_sample_normal(k_groups = 4, f = 0.10, max_n = 200)
  df_0.25_effect <- draw_sample_normal(k_groups = 3, f = 0.25, max_n = 50)
  df_0.40_effect <- draw_sample_normal(k_groups = 5, f = 0.40, max_n = 10)
  df_2_effect <- draw_sample_normal(k_groups = 2, f = 2, max_n = 10)
  formula <- "y ~ x"

  expect_snapshot(effect_sizes(formula, df_no_effect))
  expect_snapshot(effect_sizes(formula, df_no_effect_extreme))
  expect_snapshot(seq_anova(formula, 1, data = df_no_effect_extreme))
  expect_snapshot(seq_anova(formula, 0.01, data = df_0.01_effect))
  expect_snapshot(effect_sizes(formula, df_0.01_effect))
  expect_snapshot(effect_sizes(formula, df_0.10_effect))
  expect_snapshot(effect_sizes(formula, df_0.25_effect))
  expect_snapshot(effect_sizes(formula, df_0.40_effect))
  expect_snapshot(effect_sizes(formula, df_2_effect))

  formula <- y ~ x

  expect_snapshot(effect_sizes(formula, df_no_effect))
  expect_snapshot(effect_sizes(formula, df_0.01_effect))
  expect_snapshot(effect_sizes(formula, df_0.10_effect))
  expect_snapshot(effect_sizes(formula, df_0.25_effect))
  expect_snapshot(effect_sizes(formula, df_0.40_effect))
  expect_snapshot(effect_sizes(formula, df_2_effect))

  set.seed(7)
  df_no_effect <- draw_sample_normal(k_groups = 4, f = 0, max_n = 2000,
                              sd = c(1,2,4,4),
                              sample_ratio = c(1,2,1,2))
  # effect_sizes(formula, df_no_effect)$eta
  results <- seq_anova(formula, 0.10, data =  df_no_effect)
  expect_equal(results@effect_sizes$ci_ncp_upper, 0)
})
