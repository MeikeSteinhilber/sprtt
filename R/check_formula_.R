check_formula_ttest <- function(formula, data, paired) {
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
  if (paired == TRUE) {
    if (length(y) == 1 & y[1] == 1) {
      stop("Paired test: The second group is missing.")
    }
    if (!(table(y)[[1]] == table(y)[[2]])) {
      stop("Unequal number of observations per group. Independent samples?")
    }
  }
}


check_formula_anova <- function(formula, data, paired) {
  # check structure
  if ((length(formula) != 3L) || (length(formula[[3]]) != 1L))
    stop(
      "'formula' is incorrect. Please specify as 'y~factor_A'.
      If your variables are in a data frame, please use the 'data' argument."
    )

  # quick extraction of the formula for testing y
  data_matrix_formula <- model.frame(formula, data)
  factor_A <- data_matrix_formula[, 2]

  # check y
  if (!is.factor(factor_A) && (length(factor_A) != 1)) {
    stop(paste(
      formula[[3]],
      "muste be a factor."))
  }

  if (length(levels(factor_A)) < 2) {
    stop(paste("Grouping factor must contain at least two levels."))
  }

  # if (paired == TRUE) {
  #   if (length(y) == 1 & y[1] == 1) {
  #     stop("Paired test: The second group is missing.")
  #   }
  #   if (!(table(y)[[1]] == table(y)[[2]])) {
  #     stop("Unequal number of observations per group. Independent samples?")
  #   }
  # }
}
