calc_cohens_f <- function(seq_anova_arguments, F_statistic) {
  k_groups <- length(unique(seq_anova_arguments@data$factor_A))
  # n_groups <- seq_anova_arguments@data %>%
  #   group_by(.data$factor_A) %>%
  #   summarise(n_of_group = dplyr::count(., .data$factor_A)$n[1]) %>%
  #   select(n_of_group) %>%
  #   unlist()
  N <- length(seq_anova_arguments@data$y)
  # n_ratio_groups <- n_groups/N
  #
  #
  # group_means <- unique(seq_anova_arguments@data$group_mean)
  # grand_mean_factor_A <- mean(group_means)
  #
  # sd_in_groups <- seq_anova_arguments@data %>%
  #   group_by(.data$factor_A) %>%
  #   summarise(sd = sd(.data$y)) %>%
  #   select(sd) %>%
  #   unlist()

  # equal samples
  # sigma_m <- sum(n_groups*(group_means - grand_mean_factor_A)^2) / (k_groups - 1)
  # MSw <- sum((n_groups - 1)*sd_in_groups) /
  #   (N - k_groups)
  # f_empiric <- sqrt(sigma_m/MSw)

  f_empiric_corrected <- sqrt((k_groups - 1)/N * (F_statistic$F_value - 1))

 # effectsize::cohens_f(lm(y~factor_A, seq_anova_arguments@data))$Cohens_f

  return(f_empiric_corrected)

}
# seq_anova_arguments <- build_prototype_seq_anova_arguments(56, 1000)
#  seq_anova_arguments@data <-
#     calc_group_means(
#        seq_anova_arguments
#     )
