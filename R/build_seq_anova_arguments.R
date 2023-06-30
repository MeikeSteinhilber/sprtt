build_seq_anova_arguments <- function(
  formula,
  data,
  f,
  alpha,
  power,
  data_name,
  verbose
) {
  formula <- formula(formula)
  check_formula_anova(formula = formula, data = data)
  data <- extract_formula_anova(formula = formula, data = data)

  check_data_anova(data)
  seq_anova_arguments <-
    new(
      "seq_anova_arguments",
      data = data,
      f = f,
      alpha = alpha,
      power = power,
      total_sample_size = length(data$y),
      data_name = data_name,
      verbose = verbose
    )
  seq_anova_arguments
}
