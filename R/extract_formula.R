extract_formula <- function(formula, data, wanted = "both") {

  data_matrix_formula <- model.frame(formula, data, na.action = NULL)
  x <- data_matrix_formula[, 1]

  if (formula[[3]] == 1) {
    # one sample
    y <- 1
  } else{
    # two samples
    y <- data_matrix_formula[, 2]
    # transform the structure in to the standard x, y
    x_values <- x[y == levels(y)[1]]
    y_values <- x[y == levels(y)[2]]
    x <- x_values
    y <- y_values
  }

  #get wanted output
  if (wanted == "x") {
    x
  } else if (wanted == "y") {
    y
  } else {
    list(x, y)
  }
}
