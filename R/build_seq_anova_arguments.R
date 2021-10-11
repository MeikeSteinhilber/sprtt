build_seq_anova_arguments <- function(
  formula,
  data,
  f,
  alpha,
  power,
  verbose
) {
  if (class(formula) == "formula") {
    # check_formula(formula = formula, data = data)
    x <- extract_formula(formula = formula, data = data, wanted = "x")
    y <- extract_formula(formula = formula, data = data, wanted = "y")
  } else{
    "The class of the formula argument hast to be formula."
  }

  # check_data(formula, x, y)
  seq_anova_arguments <-
    new(
      "seq_anova_arguments",
      x = x,
      y = y,
      data = data,
      f = f,
      alpha = alpha,
      power = power,
      verbose = verbose
    )
  seq_anova_arguments

}
