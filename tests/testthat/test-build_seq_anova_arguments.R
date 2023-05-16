#* @testing build_seq_anova_arguments

context("build_seq_anova_arguments: Check structure of the class object")

test_that("build_seq_anova_arguments: silent", {
  formula = y ~ x
  data = draw_sample(4, 0.4, 20)
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

test_that("build_seq_anova_arguments: correct build", {
  formula = y ~ x
  data = draw_sample(4, 0.4, 20)
  f = 0.25
  alpha = 0.05
  power = 0.95
  data_name = "test_data"
  verbose = TRUE

  test <- build_seq_anova_arguments(
    formula = formula,
    data = data,
    f = f,
    alpha = alpha,
    power = power,
    data_name = data_name,
    verbose = verbose
  )

  expect_equal(test@data$y, data$y)
  expect_equal(test@data$factor_A, data$x)
  expect_equal(test@f, f)
  expect_equal(test@alpha, alpha)
  expect_equal(test@power, power)
  expect_equal(test@data_name, data_name)
  expect_equal(test@verbose, verbose)
})


test_that("build_seq_anova_arguments: correct build", {
  formula = 5
  data = draw_sample(4, 0.4, 20)
  f = 0.25
  alpha = 0.05
  power = 0.95
  data_name = "test_data"
  verbose = TRUE

  expect_error(
    build_seq_anova_arguments(
      formula = formula,
      data = data,
      f = f,
      alpha = alpha,
      power = power,
      data_name = data_name,
      verbose = verbose
    ),
    "invalid formula"
  )
})
