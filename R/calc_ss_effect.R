calc_ss_effect <- function(seq_anova_arguments) {
  # n_group <- dplyr::count(seq_anova_arguments@data, .data$factor_A)$n[1]
  n_group <- seq_anova_arguments@data %>%
    group_by(.data$factor_A) %>%
    summarise(n_of_group = dplyr::count(., .data$factor_A)$n[1]) %>%
    select(n_of_group) %>%
    unlist()
  group_means <- unique(seq_anova_arguments@data$group_mean)
  grand_mean_factor_A <- mean(group_means)

  sum(n_group * (group_means - grand_mean_factor_A)^2)
}
