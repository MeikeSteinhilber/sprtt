#* @testing calc_likelihoods_ttest

# t-test -----------------------------------------------------------------------

test_that("calc_likelihoods_ttest: check log", {
  seq_ttest_arguments <-
    build_prototype_seq_ttest_arguments()
  t_statistic <-
    calc_t_statistic(seq_ttest_arguments)
  non_centrality_parameter <-
    calc_non_centrality_parameter_ttest(seq_ttest_arguments)
  df <- 18
  likelihoods <-
    calc_likelihoods_ttest(
      seq_ttest_arguments,
      t_statistic,
      df,
      non_centrality_parameter,
      wanted = NULL
  )
  expect_true(log(likelihoods$ratio) - likelihoods$ratio_log < 1e-5)

})

test_that("calc_likelihoods_ttest: Check warnings & messages", {
  x <- rnorm(2000000)
  d <- 5
  expect_warning(seq_ttest(x, d = d),
                 "At least one likelihood is equal to 0")
})


test_that("calc_likelihoods_ttest: Check warnings & messages", {
  set.seed(3)
  seq_ttest_arguments <-
    build_prototype_seq_ttest_arguments()

  seq_ttest_arguments@x <- rnorm(40, mean = 0)
  seq_ttest_arguments@y <- rnorm(40, mean = 5)
  seq_ttest_arguments@alternative <- "less"

  t_statistic <-
    calc_t_statistic(seq_ttest_arguments)
  non_centrality_parameter <-
    calc_non_centrality_parameter_ttest(seq_ttest_arguments)
  df <- 78

  warning_text <- capture_warnings(
    calc_likelihoods_ttest(
      seq_ttest_arguments,
      t_statistic,
      df,
      non_centrality_parameter,
      wanted = NULL
    )
  )

  # at least one warning occurred
  expect_true(length(warning_text) > 0)

  # check for your specific warning (substring match)
  expect_true(any(grepl(
    "At least one log-likelihood reached infinity",
    warning_text,
    fixed = TRUE
  )))
})

# ANOVA ------------------------------------------------------------------------

test_that("calc_likelihoods_anova: Check warnings & messages", {
  set.seed(333)

  data <- draw_sample_normal(f = 1000, k_groups = 3, max_n = 100)
  warning_text <- capture_warnings(seq_anova(y~x, f = 0.1, data = data))
  # at least one warning occurred
  expect_true(length(warning_text) > 0)
  # check for your specific warning (substring match)
  expect_true(any(grepl(
    "At least one likelihood is equal to 0",
    warning_text,
    fixed = TRUE
  )))

  data <- draw_sample_normal(f = 1000000000, k_groups = 3, max_n = 100)
  warning_text <- capture_warnings(seq_anova(y~x, f = 0.000001, data = data))
  # at least one warning occurred
  expect_true(length(warning_text) > 0)
  # check for your specific warning (substring match)
  expect_true(any(grepl(
    "At least one log-likelihood reached infinity.",
    warning_text,
    fixed = TRUE
  )))

  data <- draw_sample_normal(f = 0, k_groups = 3, max_n = 100)
  warning_text <- capture_warnings(seq_anova(y~x, f = 10000, data = data))
  # at least one warning occurred
  expect_true(length(warning_text) > 0)
  # check for your specific warning (substring match)
  expect_true(any(grepl(
    "At least one likelihood is equal to 0",
    warning_text,
    fixed = TRUE
  )))

})


test_that("calc_likelihoods_anova: Check warnings & messages", {
  set.seed(333)

  seq_anova_arguments <- build_prototype_seq_anova_arguments()
  non_centrality_parameter <-
    calc_non_centrality_parameter_anova(
      seq_anova_arguments
    )
  seq_anova_arguments@data <-
    calc_group_means(
      seq_anova_arguments
    )
  ss_effect <-
    calc_ss_effect(
      seq_anova_arguments
    )
  ss_residual <-
    calc_ss_residual(
      seq_anova_arguments
    )
  F_statistic <-
    calc_F_statistic_(
      seq_anova_arguments,
      ss_effect,
      ss_residual
    )

  # 3.ed edition necessary for expect_snapshot
  testthat::local_edition(3)

  expect_snapshot(
    calc_likelihoods_anova(
      seq_anova_arguments,
      non_centrality_parameter,
      F_statistic
    )
  )
})
