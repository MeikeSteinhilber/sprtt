calc_boundaries <- function(power, alpha, log = FALSE){
  A <- power / alpha
  B <- (1 - power) / (1 - alpha)

  if (log == FALSE) {
    list(
      A = A,
      B = B
    )
  } else{
    list(
      A = log(A),
      B = log(B)
    )
  }
}
