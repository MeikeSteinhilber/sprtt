# seq_anova_arguments <- build_prototype_seq_anova_arguments(56, 1000)

calc_effect_sizes <- function(ss_effect, ss_total, F_statistic) {
  eta_squared <- ss_effect/ss_total
  partial_eta_squared <- (F_statistic$F_value * F_statistic$df_1) / (F_statistic$F_value * F_statistic$df_1 + F_statistic$df_2)
  effect_sizes = list(
    "cohens_f" = sqrt(eta_squared/(1-eta_squared)),
    "eta_squared" = eta_squared,
    "partial_eta_squared" = partial_eta_squared,
    "adjusted_eta_squared" = partial_eta_squared - (1 - partial_eta_squared) * F_statistic$df_1 / F_statistic$df_2
  )
  effect_sizes
}

# calc_cohens_f <- function(seq_anova_arguments, F_statistic, eta_squared) {
#   # k_groups <- length(unique(seq_anova_arguments@data$factor_A))
#   # N <- length(seq_anova_arguments@data$y)
#   #
#   # f_empiric_corrected <- sqrt((k_groups - 1)/N * (F_statistic$F_value - 1))
#
#   f_etha <- sqrt(eta_squared/(1-eta_squared))
#
#   return(f_etha)
# }


#' Calculate effect sizes.
#'
#' @param formula formula
#' @param data data set
#'
#' @return numerica value
#' @export
#'
#' @examples "no test yet"
effect_sizes <- function(formula, data) {
  seq_anova_arguments <-
    build_seq_anova_arguments(
      formula,
      data,
      f = 0,
      alpha = 0.1,
      power = 0.1,
      data_name = "test_name",
      verbose = FALSE
    )
  seq_anova_arguments@data <-
    calc_group_means(
      seq_anova_arguments
    )
  ss_effect <-
    calc_ss_effect(
      seq_anova_arguments
    )
  ss_residual <-
    calc_ss_residual(
      seq_anova_arguments
    )
  ss_total <-
    calc_ss_total(
      seq_anova_arguments
    )
  F_statistic <-
    calc_F_statistic_(
      seq_anova_arguments,
      ss_effect,
      ss_residual
    )

  calc_effect_sizes(ss_effect, ss_total, F_statistic)

}
# data = draw_sample(k_groups = 3, f = 0.25, sd = c(1, 1, 1), max_n = 50)
# formula = y~x
# effect_sizes(formula, data)


# effectsize::cohens_f(lm(formula, data))$Cohens_f


# m <- lm(formula, data)
# parameters::model_parameters(anova(m))
