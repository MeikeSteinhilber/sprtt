delete_na <-  function(x,
                       y = NULL,
                       one_sample,
                       paired = FALSE,
                       wanted = NULL) {
  if (one_sample == FALSE && paired == FALSE)
  {
    x <- x[!is.na(x)]
    y <- y[!is.na(y)]
  } else {
    if (!is.null(y) && (length(y) > 1)) {
      whichNA <- is.na(x) | is.na(y)
      x <- x[!whichNA]
      y <- y[!whichNA]
    } else if (y == 1 || (is.null(y))) {
      whichNA <- is.na(x)
      x <- x[!whichNA]
    } else {
      x <- x[!is.na(x)]
    }
  }

  if (wanted == "x") {
    x
  } else if (wanted == "y") {
    y
  } else {
    list(x, y)
  }
}
