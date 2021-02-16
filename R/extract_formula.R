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
    if (!is.factor(y) && (length(y) != 1))
      stop(paste("The variable after '~' must be either a grouping factor or '1'."))
    if (length(unique(y)) != 2 && (length(y) != 1))
      stop(paste("Grouping factor must contain exactly two levels."))
    if (paired) {
      if (!(table(y)[[1]] == table(y)[[2]]))
        stop("Unequal number of observations per group. Independent samples?")
    }
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
