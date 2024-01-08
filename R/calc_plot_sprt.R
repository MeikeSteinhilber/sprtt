# seq_anova_arguments <- build_prototype_seq_anova_arguments(max_n = 15, seed = 22)
# seq_anova_results <- calc_seq_anova(seq_anova_arguments)
# seq_steps <- "single"
# seq_steps <- "balanced"
# seq_steps <- c(8, 20, 35, 60)

calc_plot_anova <- function(seq_anova_arguments, seq_steps) {
  k_groups <- length(unique(seq_anova_arguments@data$factor_A))
  N <- seq_anova_arguments@total_sample_size
  temp_arguments <- seq_anova_arguments

  if (is.numeric(seq_steps)) {
    seq_steps <- seq_steps
  } else if (seq_steps == "balanced") {
    seq_steps <- seq(k_groups*2, N, k_groups)
  } else if (seq_steps == "single") {
    seq_steps <- (k_groups*2):N
  } else{
    stop("wrong input for seq_steps argument.")
  }

  lr_log <- double(length(seq_steps))
  sample_size <- double(length(seq_steps))
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
    sample_size[i] <- position
    i <- i + 1
  }

  # plot_sprt(sample_size, lr_log,
  #           seq_anova_results@A_boundary_log,
  #           seq_anova_results@B_boundary_log
  # )

  seq_anova_results@plot <- list(lr_log = lr_log,
                                 sample_size = sample_size,
                                 A_boundary_log = seq_anova_results@A_boundary_log,
                                 B_boundary_log = seq_anova_results@B_boundary_log)
  seq_anova_results
}


# ttest ------------------------------------------------------------------------
# seq_ttest_arguments <- build_prototype_seq_ttest_arguments()
# seq_steps <- "balanced"

# calc_plot_ttest <- function(seq_ttest_arguments, seq_steps = "balanced") {
#   N_x <- length(seq_ttest_arguments@x)
#   x <- seq_ttest_arguments@x
#   # c(rbind(seq_ttest_arguments@x, seq_ttest_arguments@y))
#   #
#   # a = c(1,2,3)
#   # b = c(5,5,5,5)
#   #
#   # c(rbind(a,b))
#
#   if (!seq_ttest_arguments@one_sample) {
#     N_y <- length(seq_ttest_arguments@y)
#     if (N_x == N_y) {
#       y <- seq_ttest_arguments@y
#     } else if (N_x < N_y) {
#       x <- rep(NA, N_y)
#       x <- seq_ttest_arguments@x
#       y <- seq_ttest_arguments@y
#     } else if (N_x > N_y) {
#       y <- rep(NA, N_x)
#       y <- seq_ttest_arguments@y
#     }
#   }
#
#   N <- length(x)
#   temp_arguments <- seq_ttest_arguments
#
#   if (is.numeric(seq_steps)) {
#     seq_steps <- seq_steps
#   } else if (seq_steps == "balanced") {
#     seq_steps <- seq(2, N, 1)
#   # } else if (seq_steps == "single") {
#   #   seq_steps <- (4):N
#   } else{
#     stop("XXX")
#   }
#
#
#   lr_log <- double(length(seq_steps))
#   sample_size <- double(length(seq_steps))
#   i = 1
#
#   for (position in seq_steps) {
#     temp_arguments@x <- x[1:position]
#     if (!seq_ttest_arguments@one_sample) {temp_arguments@y <- y[1:position]}
#     seq_ttest_results <- calc_seq_ttest(temp_arguments)
#     lr_log[i] <- seq_ttest_results@likelihood_ratio_log
#     sample_size[i] <- position
#     i <- i + 1
#   }
#
#   seq_ttest_results@plot <- list(lr_log = lr_log,
#                                  sample_size = sample_size,
#                                  A_boundary_log = seq_ttest_results@A_boundary_log,
#                                  B_boundary_log = seq_ttest_results@B_boundary_log)
#   seq_ttest_results
# }
