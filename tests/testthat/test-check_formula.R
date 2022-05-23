#* @testing check_formula

# t-test -----------------------------------------------------------------------
context("check_formula_ttest: Correct error messages.")

test_that("check_formula_ttest: Check structure: Correct error messages", {
  x <- 1:10
  y <- as.factor(c(rep(1,5), rep(2,5)))
  data <- data.frame(x, z = x, y)
  formula <- x~y
  paired <- FALSE

  expect_error(
    check_formula_ttest(formula = NULL, data, paired),
    "'formula' is incorrect."
  )
  expect_error(
    check_formula_ttest(formula = x~y+z, data, paired),
    "'formula' is incorrect."
  )
  expect_error(
    check_formula_ttest(formula = data$x ~ data$y, data = NULL, paired = paired),
    "please use the 'data' argument"
  )
  expect_error(
    check_formula_ttest(formula = x ~ 1, data, paired = TRUE),
    "Paired test: The second group is missing."
  )

})

test_that("check_formula_ttest: Check y: Correct messages", {
  x <- rnorm(20, mean = 0, sd = 1)
  y <- c(rep(1, 10), rep(2, 10))
  expect_error(
    seq_ttest(x ~ y, d = 0.8),
    "is not a factor"
  )


  x <- 1:10
  y_2 <- as.factor(c(rep(1,5), rep(2,5)))
  y_3 <- as.factor(c(rep(1,4), rep(2,5), 3))
  formula <- x~y
  paired <- FALSE

  data <- data.frame(x, y = rep(c(2,1), 5))
  expect_error(
    check_formula_ttest(formula, data, paired),
    "is not a factor"
  )

  data <- data.frame(x, y = y_3)
  expect_error(
    check_formula_ttest(formula, data, paired),
    "contain exactly two levels"
  )

  data <- data.frame(x, y = y_2)
  formula <- x ~ 5
  expect_error(
    check_formula_ttest(formula, data, paired)
  )

  x <- 1:10
  y <- as.factor(c(rep(1,3), rep(2,7)))
  expect_error(
    check_formula_ttest(x ~ y, data = data.frame(x,y), paired = TRUE),
    "Unequal number of observations per group"
  )
})

test_that("check_formula_ttest: silent behaviour: no errors occur", {

  x <- 1:10
  y <- as.factor(c(rep(1,5), rep(2,5)))
  z <- 1:10
  data <- data.frame(x, z, y)
  formula <- x~y
  paired <- FALSE

  expect_silent(
    check_formula_ttest(formula = x~y, data, paired)
  )
  expect_silent(
    check_formula_ttest(formula = x ~ 1, data, paired)
  )

  data <- data.frame(a = x, c = z, b = y, paired)
  expect_silent(
    check_formula_ttest(formula = a ~ b, data, paired)
  )

})

# ANOVA ------------------------------------------------------------------------
context("check_formula_anova: Correct error messages.")

test_that("check_formula_anova: Check structure: Correct error messages", {
  data <- draw_sample()
  formula <- y~x

  # Sys.setenv("LANGUAGE"="EN")

  expect_error(
    check_formula_anova(formula = "y~x", data),
    "The formula argument must be a formula"
  )
  expect_error(
    check_formula_anova(formula = y+z~x, data),
    "'formula' is incorrect."
  )
  expect_error(
    check_formula_anova(formula = x~y+z, data),
    "one-way ANOVA: 'formula' is incorrect."
  )
  expect_error(
    check_formula_anova(formula = data$x ~ data$y, data = NULL),
    "'formula' is incorrect."
  )
  expect_error(
    check_formula_anova(formula = formula),
    'argument "data" is missing, with no default'
  )
  expect_error(
    check_formula_anova(data = data),
    'argument "formula" is missing, with no default'
  )
  data$x <- as.double(data$x)
  expect_error(
    check_formula_anova(formula, data),
    'x must be a factor'
  )
  data$x <- as.factor(double(length(data$x)))
  expect_error(
    check_formula_anova(formula, data),
    'Grouping factor must contain at least two levels.'
  )
})

test_that("check_formula_anova: silent behaviour: no errors occur", {
  data <- draw_sample()
  colnames(data) <- c("observation", "factor")
  formula <- observation ~ factor

  expect_silent(
    check_formula_anova(formula, data)
  )
})
