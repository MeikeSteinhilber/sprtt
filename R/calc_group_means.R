calc_group_means <- function(seq_anova_arguments) {

  # levels <- levels(seq_anova_arguments@factor)
  #
  # if (is.null(levels)) {
  #   stop("Levels are NULL: Wrong Data Input?")
  # }

  group_means_A <-
    seq_anova_arguments@data %>%
    group_by(factor_A) %>%
    summarise_at(vars(y), list(means = mean))

  group_means$means
}
