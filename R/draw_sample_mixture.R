rnorm_mix <- function(n, mu1, sig1, mu2, sig2, gamma) {
  x <- sample(c(1,0), n, replace = T, prob = c(gamma, 1 - gamma))
  x <- ifelse(x,
              rnorm(sum(x), mean = mu1, sd = sig1),
              rnorm(sum(!x), mean = mu2, sd = sig2))
  return(x)
}



#' @title Draw Samples from a Gaussian Mixture Distribution
#' @description Draws exemplary samples with a certain effect size for the sequential one-oway ANOVA or the sequential t-test.
#' @param k_groups number of groups (levels of factor_A)
#' @param f Cohen's f. The simulated effect size.
#' @param max_n sample size for the groups (total sample size = max_n*k_groups)
#' @param counter_n number of times the functions. Default value is 1 for each group.
#' @param sample_ratio sample ratio between th groups. Default value is 1 for each group.
#'
#' @return returns a data.frame with the columns y (observations) and x (factor_A).
#'
#' @export
#'
#' @example inst/examples/draw_sample_normal.R


draw_sample_mixture <- function(
    k_groups,
    f,
    max_n,
    counter_n = 100,
    verbose = FALSE
) {
  gamma <- 0.5
  sd <- rep(1, k_groups)
  sample_ratio <- rep(1, k_groups)

  if (is.null(sd)) {sd <- rep(1, k_groups)}
  if (is.null(sample_ratio)) {sample_ratio <- rep(1, k_groups)}

  if (!is.numeric(k_groups)) {stop("argument k_groups must be numeric.")}
  if (k_groups <= 1) {stop("argument k_groups must be larger than 1.")}

  if (!is.numeric(f)) {stop("argument f must be numeric.")}
  if (f < 0) {stop("argument f must be equal to or larger than 0.")}

  if (!is.numeric(max_n)) {stop("argument max_n must be numeric.")}
  if (max_n <= 0) {stop("argument max_n must be larger than 1.")}

  if (!is.numeric(counter_n)) {stop("argument counter_n must be numeric.")}
  if (counter_n < 1) {stop("argument counter_n must be equal to or larger than 1.")}

  if (!is.numeric(sd)) {stop("argument sd must be numeric.")}
  if (length(sd) != k_groups) {stop("argument sd must contain as many elements as defined in k_groups argument.")}

  if (!is.numeric(sample_ratio)) {stop("argument sample_ratio must be numeric.")}
  if (length(sample_ratio) != k_groups) {stop("argument sample_ratio must contain as many elements as defined in k_groups argument.")}

  sample_sizes_max <- max_n * sample_ratio
  total_sample_size <- sum(max_n*sample_ratio)
  if (total_sample_size <= k_groups) {stop("total sample size must be greater than k_groups. Try to increase max_n argument.")}

  seq_step_increase <- sum(sample_ratio)
  seq_steps <- seq((seq_step_increase), total_sample_size, seq_step_increase)
  # seq_steps <- seq_steps[2:length(seq_steps)]


  test <- TRUE
  counter <- 0
  while (any(test) & counter < counter_n) {
    raw_means <- rnorm(k_groups)
    pop_means = (raw_means - mean(raw_means)) / sd(raw_means) * sqrt(k_groups / (k_groups - 1)) * f

    # draw factor randomly & calulate means
    factor <- runif(k_groups, min = 0.8, max = 1)
    mean1 = pop_means*2*factor
    mean2 = pop_means*2*(1-factor)

    test <- (sd^2 - 0.25*(mean1 - mean2)^2) <= 0
    counter <- counter + 1
  }
  if (counter == counter_n) {message("Maximum of counter_n was reached.")}
  if (verbose == TRUE) {message(paste(c("Internal counter reached = ", counter)))}
  if (verbose == TRUE & f > 1.5) {message(paste(c("f values larger than 1.5 should not be used in this function.")))}
  if (any(test)) {stop("Internal calulation failed: try to increase counter_n or decrease f and set verbose to TRUE.")}



  # calculate variance
  factor <- runif(k_groups, min = 0.8, max = 1)
  variance_12 = 2*sd^2-0.5*(mean1-mean2)^2
  sigma1 = sqrt(variance_12 * factor)
  sigma2 = sqrt(variance_12 * (1-factor))

  position <- 1
  data <- matrix(double(total_sample_size*2), ncol = 2)

  for (steps in seq_steps) {

    y <- 1:k_groups %>%
      # purrr::map(~EnvStats::rnormMix(n = sample_ratio[.x], mean1 = mean1[.x], sd1 = sd[.x], mean2 = mean2[.x], sd2 = sd[.x], p.mix = gamma)) %>%
      purrr::map(~rnorm_mix(n = sample_ratio[.x], mu1 = mean1[.x], sig1 = sigma1[.x], mu2 = mean2[.x], sig2 = sigma2[.x], gamma = gamma)) %>%
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




# k_groups = 4
# f = 1
# f = 1.51
# max_n = 50
# counter_n = 100
# verbose = FALSE
