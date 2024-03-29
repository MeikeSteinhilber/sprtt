check_constant_data_ttest <- function(x, y) {
  message <- "Can't perform sequential t-test on constant data."

  if (!is.null(y) && !is.factor(y)) {
    sd.check <- c(sd(x), sd(y))
    sd.check <- ifelse(is.na(sd.check), 0, sd.check)
    if (!(max(sd.check) > 0))
      stop(message)

  } else if (!is.null(y) && length(y) != 1) {
    sd.check <- tapply(x, INDEX = y, FUN = sd)
    sd.check <- ifelse(is.na(sd.check), 0, sd.check)
    if (max(sd.check) == 0)
      stop(message)

  } else if (is.null(y)) {
    sd.check <- ifelse(is.na(sd(x)), 0, sd(x))
    if (!(sd.check > 0))
      stop(message)
  }
}

# ANOVA ------------------------------------------------------------------------
check_constant_data_anova <- function(data) {
  message <- "Can't perform sequential ANOVA on constant data."
  sd.check <- tapply(data$y, INDEX = data$factor_A, FUN = sd)
  sd.check <- ifelse(is.na(sd.check), 0, sd.check)
  if (!(max(sd.check) > 0))
    stop(message)
}
