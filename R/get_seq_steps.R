get_seq_steps <- function(seq_steps, N, k_groups) {
  if (is.numeric(seq_steps)) {
    seq_steps
  } else if (seq_steps == "balanced") {
    seq(k_groups*2, N, k_groups)
  } else if (seq_steps == "single") {
    (k_groups*2):N
  } else{
    stop("wrong input for seq_steps argument.")
  }
}
