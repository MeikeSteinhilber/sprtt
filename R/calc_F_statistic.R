calc_F_statistic_ <- function(
  seq_anova_arguments,
  ss_effect,
  ss_residual
) {

  n_levels_factor_A <- length(unique(seq_anova_arguments@data$factor_A))

  df_1 <- n_levels_factor_A - 1
  df_2 <- seq_anova_arguments@total_sample_size - n_levels_factor_A
  F_value <- (ss_effect / df_1) / (ss_residual / df_2)

  return(list(
    F_value = F_value,
    df_1 = df_1,
    df_2 = df_2
  ))
}
