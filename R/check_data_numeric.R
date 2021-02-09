check_data_numeric <- function(x, y, paired) {
  if (!is.null(y)) {
    x.name <- deparse(substitute(x))
    y.name <- deparse(substitute(y))
    data.name <- paste(x.name, "and", y.name)
    if (!(is.atomic(x) && is.null(dim(x))))
      warning(paste(x.name, "is not a vector. This might have caused problems."),
              call. = F)
    if (!(is.atomic(y) && is.null(dim(y))))
      warning(paste(y.name, "is not a vector. This might have caused problems."),
              call. = F)
    if (is.factor(y))
      stop("Is y a grouping factor? Use formula interface x ~ y.")
    if (!is.numeric(x))
      stop(paste("Invalid argument:",  x.name, "must be numeric."))
    if (!is.numeric(y))
      stop(paste("Invalid argument:",  y.name, "must be numeric."))
    if (!paired && (length(x) + length(y) < 3))
      stop("SPRT for two independent samples requires at least 3 observations.")

    sd.check <- c(sd(x), sd(y))
    sd.check <- ifelse(is.na(sd.check), 0, sd.check)
    if (!(max(sd.check) > 0))
      stop("Can't perform SPRT on constant data.")
    if (!is.logical(paired))
      stop("Invalid argument <paired>: Must be logical.")

    }else{
    data.name <- deparse(substitute(x))

    x <- x[!is.na(x)]
    if (!is.numeric(x))
      stop(paste("Invalid argument:",  data.name, "must be numeric."))
    sd.check <- ifelse(is.na(sd(x)), 0, sd(x))
    if (!(sd.check > 0))
      stop("Can't perform SPRT on constant data.")
  }
}
