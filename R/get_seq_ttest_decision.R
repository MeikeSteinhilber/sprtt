get_seq_ttest_decision <- function(likelihood_ratio, boundaries){
  if (likelihood_ratio >= boundaries$A) {
    decision <- "accept H1"
  } else if (likelihood_ratio <= boundaries$B) {
    decision <- "accept H0"
  } else{
    decision <- "continue sampling"
  }
  decision
}
