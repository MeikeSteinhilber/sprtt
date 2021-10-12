build_seq_anova_arguments <- function(
  formula,
  data,
  f,
  alpha,
  power,
  data_name,
  verbose
) {
  if (class(formula) == "formula") {
    # check_formula(formula = formula, data = data)
    data <- extract_formula_seq_anova(formula = formula, data = data)
  } else{
    "The class of the formula argument hast to be formula."
  }

  # check_data(formula, x, y)
  seq_anova_arguments <-
    new(
      "seq_anova_arguments",
      data = data,
      f = f,
      alpha = alpha,
      power = power,
      data_name = data_name,
      verbose = verbose
    )
  seq_anova_arguments

}
