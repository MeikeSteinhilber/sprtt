get_one_sample <- function(y) {
  if (is.null(y) || (length(y) == 1)) {
    one_sample <- TRUE
  } else{
    one_sample <- FALSE
  }
  one_sample
}

# get_one_sided <- function(alternative) {
#   if (alternative == "two.sided") {
#     one_sided = FALSE
#   } else if (alternative == "less" || alternative == "greater"){
#     one_sided = TRUE
#   } else {
#     stop("Argument alternative must be 'two.sided', 'less', or 'greater'.")
#   }
#   one_sided
# }
