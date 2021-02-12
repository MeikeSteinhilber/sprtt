calc_seq_ttest_boundaries <- function(power, alpha){
  A <- power/alpha
  B <- (1 - power)/(1 - alpha)
  list(A = A,
       B = B)
}
