check_data_ttest <- function(x, y, paired) {

  if (!is.numeric(x))
    stop(paste("Invalid argument: x must be numeric."))

  if (!is.null(y)) {
    if (is.factor(y))
      stop("Is y a grouping factor? Use formula interface x ~ y.")
    if (!is.numeric(y))
      stop(paste("Invalid argument:y must be numeric."))
    if (!paired && (length(x) + length(y) < 3))
      stop("SPRT for two independent samples requires at least 3 observations.")
    if (!is.logical(paired))
      stop("Invalid argument <paired>: Must be logical.")
  }

  check_constant_data_ttest(x, y)
}

check_data_anova <- function(data) {

  if (!is.numeric(data$y))
    stop(paste("Invalid argument: y must be numeric (y~factor_A)."))
  if (length(levels(data$factor_A)) == 2 && (length(data$y) < 3))
    stop("Requires at least 3 observations.")
  if (length(unique(data$factor_A)) < 2)
    stop("A factor needs at least 2 levels.")
  if (any(as.numeric(table(data$factor_A)) < 2))
    stop("Every group needs at least two observations.")
  # if (!is.logical(paired))
  #   stop("Invalid argument <paired>: Must be logical.")

  check_constant_data_anova(data)
}

