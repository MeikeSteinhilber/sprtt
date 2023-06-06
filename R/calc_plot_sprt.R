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
    stop("XXX")
  }


  lr_log <- double(length(seq_steps))
  sample_size <- double(length(seq_steps))
  i = 1

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
