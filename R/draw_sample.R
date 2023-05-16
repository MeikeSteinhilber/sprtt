#' @title Draw Samples
#' @description Draw exemplary samples for the sequential ANOVA function.



#' @param k_groups number of groups (levels of factor_A)
#' @param f cohens f.
#' @param sd standard deviations of the groups. Default value is 1 for each group.
#' @param sample_ratio sample ratio between th groups. Default value is 1 for each group.
#' @param max_n sample size for the groups (total sample size = max_n*k_groups)
#'
#' @return returns a data.frame with the columns y (observations) and x (factor_A).
#'
#' @export
#'
#' @example inst/examples/draw_sample.R


draw_sample <- function(
    k_groups,
    f,
    max_n,
    sd = NULL,
    sample_ratio = NULL
) {

  if (is.null(sd)) {sd <- rep(1, k_groups)}
  if (is.null(sample_ratio)) {sample_ratio <- rep(1, k_groups)}

  if (!is.numeric(sd)) {stop("sd must be numeric")}
  if (!is.numeric(sample_ratio)) {stop("sample_ratio must be numeric")}
  if (length(sd) != k_groups) {stop("sd must contain as many elements as defined in k_groups argument.")}
  if (length(sample_ratio) != k_groups) {stop("sample_ratio must contain as many elements as defined in k_groups argument.")}

  total_sample_size <- sum(max_n*sample_ratio)
  if (total_sample_size <= k_groups) {stop("total sample size must be greater than k_groups. Try to increase max_n.")}

  seq_step_increase <- sum(sample_ratio)
  seq_steps <- seq((seq_step_increase), total_sample_size, seq_step_increase)
  # seq_steps <- seq_steps[2:length(seq_steps)]


  raw_means <- rnorm(k_groups)

  f_new <- f*sqrt(
    sum(sd^2*(total_sample_size - 1)) /
      (sum(total_sample_size) - k_groups)
  )

  means = (raw_means - mean(raw_means)) / sd(raw_means) * sqrt(k_groups / (k_groups - 1)) * f_new
  position <- 1
  data <- matrix(double(total_sample_size*2), ncol = 2)

  for (steps in seq_steps) {

    y <- 1:k_groups %>%
      purrr::map(~rnorm(n = sample_ratio[.x], mean = means[.x], sd = sd[.x])) %>%
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
