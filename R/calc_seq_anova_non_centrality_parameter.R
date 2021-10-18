calc_seq_anova_non_centrality_parameter <- function(seq_anova_arguments) {
  # seq_anova_arguments@f^2 * seq_anova_arguments@n
  seq_anova_arguments@f^2 * length(seq_anova_arguments@data$y)
}
