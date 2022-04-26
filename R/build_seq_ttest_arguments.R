build_seq_ttest_arguments <- function(
  input1,
  y = NULL,
  data = NULL,
  mu, d, alpha, power, alternative, paired, data_name, na.rm
){

  if (class(input1) == "formula") {
    check_formula_ttest(formula = input1, data = data, paired = paired)
    x <- extract_formula_ttest(formula = input1, data = data, wanted = "x")
    y <- extract_formula_ttest(formula = input1, data = data, wanted = "y")
  } else if (class(input1) == "numeric") {
    x <- input1
  } else {
    stop(
      "The class of the input1 argument hast to be either 'formula' or 'numeric'."
      )
  }

  one_sample <- get_one_sample(y)
  x <- delete_na(x, y, one_sample, paired, na.rm, wanted = "x")
  y <- delete_na(x, y, one_sample, paired, na.rm, wanted = "y")
  check_data_ttest(x, y, paired)

  seq_ttest_arguments <-
    new(
      "seq_ttest_arguments",
      x = x,
      y = y,
      mu = mu,
      d = d,
      alpha = alpha,
      power = power,
      alternative = alternative,
      paired = paired,
      one_sample = one_sample,
      data_name = data_name,
      na.rm = na.rm
    )
  seq_ttest_arguments
}
