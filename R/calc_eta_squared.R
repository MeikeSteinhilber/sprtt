# seq_anova_arguments <- build_prototype_seq_anova_arguments(56, 1000)

calc_eta_squared <- function(ss_effect, ss_total) {
  ss_effect/ss_total
}


# data = draw_sample(k_groups = 3, f = 0.25, sd = c(1, 1, 1), max_n = 50)
# formula = y~x

#' Calculate eta squared.
#'
#' @param formula formula
#' @param data data set
#'
#' @return numeric value
#' @export
#'
#' @examples "no test yet"
eta_squared <- function(formula, data) {
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
  calc_eta_squared(ss_effect, ss_total)
}

# cohens_f(formula, data)
# effectsize::cohens_f(lm(formula, data))$Cohens_f


