get_one_sample <- function(y) {
  if (is.null(y) || (length(y) == 1)) {
    one_sample <- TRUE
  } else{
    one_sample <- FALSE
  }
  one_sample
}

