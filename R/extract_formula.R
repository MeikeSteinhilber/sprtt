# t-test -----------------------------------------------------------------------
extract_formula_ttest <- function(formula, data, wanted = "both") {

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

# ANOVA ------------------------------------------------------------------------
extract_formula_anova <- function(formula, data) {

  data_matrix_formula <- model.frame(formula, data, na.action = NULL)
  names <- c("y",
             "factor_A", # one-way ANOVA only uses factor_A
             "factor_B", # two-way ANOVA
             "factor_C", # tree-way ANOVA
             "factor_D",
             "factor_E"
  )
  colnames(data_matrix_formula) <- names[1:ncol(data_matrix_formula)]
  data_matrix_formula
}
