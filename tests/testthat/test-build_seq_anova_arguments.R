#* @testing build_seq_anova_arguments

context("build_seq_anova_arguments: Check structure of the class object")

test_that("build_seq_anova_arguments: silent", {
  formula = y ~ x
  data = draw_sample()
  f = 0.25
  alpha = 0.05
  power = 0.95
  data_name = "test_data"
  verbose = TRUE

  expect_silent(
    build_seq_anova_arguments(
      formula = formula,
      data = data,
      f = f,
      alpha = alpha,
      power = power,
      data_name = data_name,
      verbose = verbose
    )
  )
})

