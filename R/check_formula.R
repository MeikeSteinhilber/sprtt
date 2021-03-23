check_formula <- function(formula, data, paired) {

  # check structure
  if ((length(formula) != 3L) || (length(formula[[3]]) != 1L))
    stop(
      "'formula' is incorrect. Please specify as 'x~y'.
      If your variables are in a data frame, please use the 'data' argument."
    )

  # quick extraction of the formula for testing y
  data_matrix_formula <- model.frame(formula, data)

  # get the y value
  if (length(data_matrix_formula) == 2) {
    y <- data_matrix_formula[,2]
  } else{
    # correct because model.frame allows only 1 as input
    y <- 1
  }

  # check y
  if (!is.factor(y) && (length(y) != 1)) {
    stop(paste(
      formula[[3]],
      "is not a factor. Are you sure, that you want to use the fomula input?"))
  }
  if (length(unique(y)) != 2 && (length(y) != 1)) {
    stop(paste("Grouping factor must contain exactly two levels."))
  }
  if (paired == TRUE && !(table(y)[[1]] == table(y)[[2]])) {
    stop("Unequal number of observations per group. Independent samples?")
  }
}
