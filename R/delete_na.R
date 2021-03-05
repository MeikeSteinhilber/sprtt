delete_na <-  function(x,
                       y = NULL,
                       one_sample,
                       paired = FALSE,
                       na.rm = TRUE,
                       wanted = "both") {
  if(na.rm == FALSE) {
    na_exist_x <- any(is.na(x))
    na_exist_y <- any(is.na(y))
    if(na_exist_x == TRUE || na_exist_y == TRUE) {
      stop("The data contain missing values. Use the argument na.rm = TRUE or
           remove the missings beforehand.")
    }
  } else if(na.rm == TRUE){
    if (one_sample == FALSE && paired == FALSE)
    {
      x <- x[!is.na(x)]
      y <- y[!is.na(y)]
      # if(!is.null(y) && (length(y) > 1)) {
    } else if(one_sample == FALSE && paired == TRUE) {
      whichNA <- is.na(x) | is.na(y)
      x <- x[!whichNA]
      y <- y[!whichNA]
    } else if(one_sample == TRUE){
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
