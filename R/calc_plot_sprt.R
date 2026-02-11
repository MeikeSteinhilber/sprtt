# seq_anova_arguments <- build_prototype_seq_anova_arguments(max_n = 15, seed = 22)
# seq_anova_arguments <- build_prototype_seq_anova_arguments(
#                         seed = 333, max_n = 50, f_sim = 0.4, f_exp = 0.4,
#                         k_groups = 4,
#                         alpha = 0.05, power = 0.95)
# seq_anova_results <- calc_seq_anova(seq_anova_arguments)
# seq_steps <- "single"
# seq_steps <- "balanced"
# seq_steps <- c(8, 20, 35, 60)

calc_plot_anova <- function(seq_anova_arguments, seq_steps) {
  k_groups <- length(unique(seq_anova_arguments@data$factor_A))
  N <- seq_anova_arguments@total_sample_size
  temp_arguments <- seq_anova_arguments

  seq_steps <- get_seq_steps(seq_steps, N, k_groups)

  lr_log <- double(length(seq_steps))
  sample_size <- double(length(seq_steps))
  decision <- character(length(seq_steps))
  i = 1

  k_groups_start <- table(seq_anova_arguments@data[1:seq_steps[1], 2])

  if (any(k_groups_start < 2)) {
    stop("The first 2*k_groups data points are not balanced. Every group needs two data points.
         Solution: Use the argument 'plot' to define a customized vector with the sample size steps in the seq_anova() function")
  }

  for (position in seq_steps) {
    temp_arguments@data <- seq_anova_arguments@data[1:position, ]
    temp_arguments@total_sample_size <- position
    seq_anova_results <- calc_seq_anova(temp_arguments)
    lr_log[i] <- seq_anova_results@likelihood_ratio_log
    decision[i] <- seq_anova_results@decision
    sample_size[i] <- position
    i <- i + 1
  }

  # plot_sprt(sample_size, lr_log,
  #           seq_anova_results@A_boundary_log,
  #           seq_anova_results@B_boundary_log
  # )

  seq_anova_results@plot <- data.frame(
    lr_log = lr_log,
    sample_size = sample_size,
    decision = decision)
  seq_anova_results
}


# ttest ------------------------------------------------------------------------
# seq_ttest_arguments <- build_prototype_seq_ttest_arguments()
# seq_ttest_arguments <- build_prototype_seq_ttest_arguments(type = "formula")
# seq_steps <- "single"
# seq_steps <- "balanced"
# seq_steps <- c(5,10,12)

# for this code to work, we have to refactore all the ttest cal functions, so they use all the long format for the calculations

calc_plot_ttest <- function(seq_ttest_arguments, seq_steps = "single") {

  N <- seq_ttest_arguments@total_sample_size

  if (is.null(seq_ttest_arguments@data)) {
    # x / y input
    k_groups <- ifelse(seq_ttest_arguments@one_sample,1,2)
    if (k_groups == 1) {
      seq_ttest_arguments@data = data.frame(
        y = seq_ttest_arguments@x,
        x = rep(1,N)
      )
    } else {
      seq_ttest_arguments@data = get_long_data(seq_ttest_arguments@x,seq_ttest_arguments@y)
    }

  }

  k_groups <- length(unique(seq_ttest_arguments@data$x))

  temp_arguments <- seq_ttest_arguments
  seq_steps <- get_seq_steps(seq_steps, N, k_groups)

  lr_log <- double(length(seq_steps))
  sample_size <- double(length(seq_steps))
  decision <- character(length(seq_steps))
  i = 1

  k_groups_start <- table(seq_ttest_arguments@data[1:seq_steps[1], 2])

  if (any(k_groups_start < 2)) {
    stop("The first 2*k_groups data points are not balanced. Every group needs two data points.
         Solution: Use the argument 'plot' to define a customized vector with the sample size steps in the seq_anova() function")
  }

  for (position in seq_steps) {
    temp_arguments@data <- seq_ttest_arguments@data[1:position, ]
    temp_arguments@total_sample_size <- position
    seq_results <- calc_seq_ttest(temp_arguments)
    lr_log[i] <- seq_results@likelihood_ratio_log
    decision[i] <- seq_results@decision
    sample_size[i] <- position
    i <- i + 1
  }

  seq_results@plot <- data.frame(
    lr_log = lr_log,
    sample_size = sample_size,
    decision = decision)
  seq_results
}
