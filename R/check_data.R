check_data <- function(input1, x, y, paired, na.rm = FALSE) {

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

  check_constant_data(x, y, paired)
}


