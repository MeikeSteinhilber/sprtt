check_formula <- function(formula) {
  if ((length(formula) != 3L) || (length(formula[[3]]) != 1L))
    stop("'formula' is incorrect. Please specify as 'x~y'.")
}
