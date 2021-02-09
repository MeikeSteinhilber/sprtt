check_data_formula <- function(x, y, paired) {
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
}


