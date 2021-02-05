extract_formula <- function(formula, data, paired, wanted = "both") {
  formula_list <- as.list(formula)

  #check formula
  if ((length(formula) != 3L) || (length(formula[[3]]) != 1L))
    stop("'formula' is incorrect. Please specify as 'x~y'.")
  #get x and y values
  temp <- model.frame(formula, data)
  x <- temp[, 1]
  if (formula_list[[3]] == 1) {
    y = 1
  } else {
    y <- temp[, 2]
  }
  #check input
  if (length(unique(y)) != 2 && (length(y) != 1))
    stop(paste("Grouping factor must contain exactly two levels."))
  if (paired) {
    if (!(table(y)[[1]] == table(y)[[2]]))
      stop("Unequal number of observations per group. Independent samples?")
  } else{
    if (length(x) < 3)
      stop("SPRT for two independent samples requires at least 3 observations.")
  }
  if (y[1] != 1) {
    sd.check <- tapply(x, INDEX = y, FUN = sd)
    sd.check <- ifelse(is.na(sd.check), 0, sd.check)
    if (max(sd.check) == 0)
      stop("Can't perform SPRT on constant data.")
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
