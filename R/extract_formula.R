extract_formula <- function(formula, data, paired, wanted = "both") {
  check_formula(formula)

  #get x and y values
  temp <- model.frame(formula, data)
  x <- temp[, 1]
  formula_list <- as.list(formula)
  if (formula_list[[3]] == 1) {
    y = 1
  } else {
    y <- temp[, 2]
    x_temp <- x[y == levels(y)[1]]
    y_temp <- x[y == levels(y)[2]]
    x <- x_temp
    y <- y_temp
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
