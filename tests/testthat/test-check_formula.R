#* @testing check_formula
context("check_formula: Correct error messages.")

test_that("check_formula: Correct error messages", {

  expect_error(
    check_formula(formula = NULL),
    "'formula' is incorrect."
  )
  expect_error(
    check_formula(formula = x~y+z),
    "'formula' is incorrect."
  )

})

test_that("check_formula: silent behaviour: no errors occur", {

  expect_silent(
    check_formula(formula = x~y)
  )
  expect_silent(
    check_formula(formula = a ~ b)
  )
  expect_silent(
    check_formula(formula = x ~ 1)
  )

})


# test_that("", {
#
#
# })
