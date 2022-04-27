calc_group_means <- function(seq_anova_arguments) {
  # adds column "group means" to data
  seq_anova_arguments@data %>%
    group_by(.data$factor_A) %>%
    mutate(group_mean = mean(.data$y))
}
