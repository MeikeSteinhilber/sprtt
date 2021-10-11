extract_formula <- function(formula, data, wanted = "both") {

  data_matrix_formula <- model.frame(formula, data, na.action = NULL)
  x <- data_matrix_formula[, 1]
  y <- data_matrix_formula[, 2]


  #get wanted output
  if (wanted == "x") {
    x
  } else if (wanted == "y") {
    y
  } else {
    list(x, y)
  }
}
