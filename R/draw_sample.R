#' @export
draw_sample <- function(k_groups = 3, f = 0.25, sd = c(1, 1, 1), max_n = 50) {
  if(k_groups != length(sd)) {stop(" k_groups needs to be equal to length of sd.")}

  raw_means <- rnorm(k_groups)
  f_new <- f*sqrt(sum(sd^2)/k_groups)
  means = (raw_means - mean(raw_means)) / sd(raw_means) * sqrt(k_groups / (k_groups - 1)) * f_new
  y <- rnorm(max_n * k_groups, means, sd = sd)
  x <- factor(rep(1:k_groups, max_n))
  data.frame(y, x)
}
