#* @testing extract_formula
context("extract_formula: Correct extraction of the formula.")

# t-test -----------------------------------------------------------------------
test_that("extract_formula_ttest: effect in data: data are correct", {
  x_1 <- rnorm(5)
  x_2 <- rnorm(5)
  x <- c(x_1, x_2)
  y <- as.factor(c(rep(1,5),rep(2,5)))
  z <- x
  data <- data.frame(x, z, y)
  formula <- x ~ y

  x_test <- extract_formula_ttest(formula, data, wanted = "x")
  y_test <- extract_formula_ttest(formula, data, wanted = "y")
  x_y <- extract_formula_ttest(formula, data)
  expect_equal(x_test,x_1)
  expect_equal(y_test, x_2)
  expect_equal(x_y, list(x_1, x_2))

  data <- data.frame(a = x,c = z,b = y)
  formula <- a ~ 1
  x_test <- extract_formula_ttest(formula, data, wanted = "x")
  y_test <- extract_formula_ttest(formula, data, wanted = "y")
  expect_equal(x_test, x)
  expect_equal(y_test, 1)
})

# ANOVA ------------------------------------------------------------------------
test_that("extract_formula_anova: effect in data: data are correct", {
  # one-way ANOVA
  formula <- y ~ factor_A
  data <- draw_sample()
  colnames(data) <- c("y", "factor_A")
  data_test <- cbind(data, test = rnorm(nrow(data)))

  results <- extract_formula_anova(formula, data_test)
  expect_equivalent(data, results)

  # two-way ANOVA
  formula <- y ~ factor_A+factor_B
  data <- draw_sample()
  colnames(data) <- c("y", "factor_A")
  data_test <- cbind(data,
                     factor_B = as.factor(rep(c(1,0), 25)))

  results <- extract_formula_anova(formula, data_test)
  expect_equivalent(data_test, results)


})
