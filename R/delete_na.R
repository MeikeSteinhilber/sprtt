delete_na <- function(x, y = NULL, wanted = NULL) {
  if (!is.null(y)) {
    whichNA <- is.na(x) | is.na(y)
    x <- x[!whichNA]
    y <- y[!whichNA]
  } else {
    x <- na.omit(x)
  }

  if (wanted == "x") {
    x
  } else if (wanted == "y") {
    y
  } else {
    list(x, y)
  }
}
