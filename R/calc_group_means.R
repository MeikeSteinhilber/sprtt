calc_group_means <- function(seq_anova_arguments) {

  # levels <- levels(seq_anova_arguments@factor)
  #
  # if (is.null(levels)) {
  #   stop("Levels are NULL: Wrong Data Input?")
  # }


  group_means_A <-
    seq_anova_arguments@data %>%
    dplyr::group_by(.data$factor_A) %>%
    dplyr::summarise_at(vars(.data$y), list(means = mean))

  seq_anova_arguments@data %>%
    group_by(.data$factor_A) %>%
    mutate(group_mean = mean(.data$y))
}
