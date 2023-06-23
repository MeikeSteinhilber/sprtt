#' @title Draw Samples from a Normal Distribution
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' Draws exemplary samples with a certain effect size for the sequential one-oway ANOVA or the sequential t-test.
#' @param k_groups number of groups (levels of factor_A)
#' @param f Cohen's f. The simulated effect size.
#' @param sd vector of standard deviations of the groups. Default value is 1 for each group.
#' @param sample_ratio vector of sample ratios between th groups. Default value is 1 for each group.
#' @param max_n sample size for the groups (total sample size = max_n*k_groups)
#'
#' @return returns a data.frame with the columns y (observations) and x (factor_A).
#'
#' @export
#'
#' @example inst/examples/draw_sample_normal.R



draw_sample_normal <- function(
  k_groups,
  f,
  max_n,
  sd = NULL,
  sample_ratio = NULL
) {

  if (is.null(sd)) {sd <- rep(1, k_groups)}
  if (is.null(sample_ratio)) {sample_ratio <- rep(1, k_groups)}

  if (!is.numeric(k_groups)) {stop("argument k_groups must be numeric.")}
  if (k_groups <= 1) {stop("argument k_groups must be larger than 1.")}

  if (!is.numeric(f)) {stop("argument f must be numeric.")}
  if (f < 0) {stop("argument f must be equal to or larger than 0.")}

  if (!is.numeric(max_n)) {stop("argument max_n must be numeric.")}
  if (max_n <= 0) {stop("argument max_n must be larger than 1.")}

  if (!is.numeric(sd)) {stop("argument sd must be numeric.")}
  if (length(sd) != k_groups) {stop("argument sd must contain as many elements as defined in k_groups argument.")}

  if (!is.numeric(sample_ratio)) {stop("argument sample_ratio must be numeric.")}
  if (length(sample_ratio) != k_groups) {stop("argument sample_ratio must contain as many elements as defined in k_groups argument.")}

  total_sample_size <- max_n*sample_ratio
  if (sum(total_sample_size) <= k_groups) {stop("total sample size must be greater than k_groups. Try to increase max_n argument.")}

  seq_step_increase <- sum(sample_ratio)
  seq_steps <- seq((seq_step_increase), sum(total_sample_size), seq_step_increase)
  # seq_steps <- seq_steps[2:length(seq_steps)]


  raw_means <- rnorm(k_groups)

  f_new <- f*sqrt(
    sum(sd^2*(total_sample_size - 1)) /
      (sum(total_sample_size) - k_groups)
  )

  pop_means = (raw_means - mean(raw_means)) / sd(raw_means) * sqrt(k_groups / (k_groups - 1)) * f_new
  position <- 1
  data <- matrix(double(sum(total_sample_size)*2), ncol = 2)

  for (steps in seq_steps) {

    y <- 1:k_groups %>%
      purrr::map(~rnorm(n = sample_ratio[.x], mean = pop_means[.x], sd = sd[.x])) %>%
      unlist()

    indice <- 1:100
    x <- 1:k_groups %>%
      purrr::map(~rep(indice[.x], sample_ratio[.x])) %>%
      unlist()

    data[position:steps, 1] <- y
    data[position:steps, 2] <- x
    position <- position + seq_step_increase
  }
  data.frame(y = data[, 1], x = as.factor(data[, 2]))
}
