calc_ss_effect <- function(seq_anova_arguments) {
  # n_group <- dplyr::count(seq_anova_arguments@data, .data$factor_A)$n[1]
  n_group <- seq_anova_arguments@data %>%
    group_by(.data$factor_A) %>%
    summarise(n_of_group = dplyr::count(., .data$factor_A)$n[1]) %>%
    select(n_of_group) %>%
    unlist()
  group_mean_A <- unique(seq_anova_arguments@data$group_mean_A)
  grand_mean_factor_A <- mean(group_mean_A)

  sum(n_group * (group_mean_A - grand_mean_factor_A)^2)
}
