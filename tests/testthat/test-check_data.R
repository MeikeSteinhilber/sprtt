# test_that("extract_formula: random data: Correct activation of errors", {
#   x <- rnorm(10)
#   y <- rnorm(10)
#   z <- rnorm(10)
#   data <- data.frame(x, y, z)
#
#   formula <- x ~ y + z
#   expect_error(
#     extract_formula(formula, data, paired = F),
#     "'formula' is incorrect")
#
#   formula <- x ~ y
#   expect_error(
#     extract_formula(formula, data, paired = F),
#     "Grouping factor must contain exactly two levels.")
# })
#
# test_that("extract_formula: effect in data: Correct activation of errors", {
#   x <- rnorm(10)
#   y <- as.factor(sample(c(1,2), 50, replace = TRUE))
#   x <- ifelse(y == 1, x + 0.8, x)
#   data <- data.frame(x, y)
#   formula <- x ~ y
#
#   expect_error(
#     extract_formula(formula, data, paired = T, wanted = "x"),
#     "Unequal number of observations per group. Independent samples?")
#
#   data$x <- rep(5,10)
#   expect_error(
#     extract_formula(formula, data, paired = F),
#     "Can't perform SPRT on constant data.")
#
#   x <- c(5,8)
#   y <- c(1,2)
#   data <- data.frame(x,y)
#   expect_error(
#     extract_formula(formula, data, paired = F),
#     "SPRT for two independent samples requires at least 3 observations.")
#
# })



# test_that("", {
#
#
# })

# expect_warning(log(0))
# expect_error(1 / 2)
# expect_message(library(mgcv), "This is mgcv")
# expect_equal(str_length("a"), 1)
# expect_identical(10, 10 + 1e-7)
# expect_match(string, "Testing")
# expect_is() #checks that an object inherit()s from a specified class
# expect_true()
# expect_false()
