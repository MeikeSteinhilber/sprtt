extract_formula_seq_anova <- function(formula, data) {

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
