check_constant_data <- function(x, y, paired = NULL) {
  message <- "Can't perform SPRT on constant data."

  if(!is.null(y) && !is.factor(y)){
    sd.check <- c(sd(x), sd(y))
    sd.check <- ifelse(is.na(sd.check), 0, sd.check)
    if (!(max(sd.check) > 0))
      stop(message)

  }else if (!is.null(y) && length(y) != 1) {
    sd.check <- tapply(x, INDEX = y, FUN = sd)
    sd.check <- ifelse(is.na(sd.check), 0, sd.check)
    if (max(sd.check) == 0)
      stop(message)

  }else if(is.null(y)){
  sd.check <- ifelse(is.na(sd(x)), 0, sd(x))
  if (!(sd.check > 0))
    stop(message)
  }
}
