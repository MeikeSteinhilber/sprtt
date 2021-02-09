
get_one_sample <- function(y) {
  if (is.null(y) || (y == 1)) {
    one_sample = TRUE
  } else{
    one_sample = FALSE
  }
  one_sample
}

get_one_sided <- function(alternative) {
  if (alternative == "two.sided") {
    one_sided = FALSE
  } else{
    one_sided = TRUE
  }
  one_sided
}
