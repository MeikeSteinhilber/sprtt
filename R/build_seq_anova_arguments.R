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
    check_formula_anova(formula = formula, data = data, paired = FALSE)
    data <- extract_formula_seq_anova(formula = formula, data = data)
  } else{
    "The class of the formula argument hast to be formula."
  }

  check_data_anova(data, formula, paired = FALSE)
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
