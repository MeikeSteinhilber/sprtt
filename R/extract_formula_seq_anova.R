extract_formula_seq_anova <- function(formula, data) {

  data_matrix_formula <- model.frame(formula, data, na.action = NULL)
  names <- c("y",
             "factor_A",
             "factor_B",
             "factor_C",
             "factor_D",
             "factor_E"
  )
  colnames(data_matrix_formula)<- names[1:ncol(data_matrix_formula)]
  data_matrix_formula

  # y <- data_matrix_formula[, 2]
  # # transform the structure in to the standard x, y
  # x_values <- x[y == levels(y)[1]]
  # y_values <- x[y == levels(y)[2]]
  # x <- x_values
  # y <- y_values

}
