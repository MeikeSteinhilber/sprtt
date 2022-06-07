#---- GENERAL SETTINGS ---------------------------------------------------------
#' @importFrom stats dt df model.frame
#' @importFrom methods callNextMethod new validObject
#' @import dplyr
#'
#'
#---- MAIN FUNCTION DOCUMENTATION ----------------------------------------------
#' @title Sequential Analysis of Variance
#' @description Performs a sequential ANOVA.
#'
#' @param formula a formula.
#' @param data data frame.
#' @param f cohens f (expected minimal effect size or effect size of interest).
#' @param alpha the type I error. A number between 0 and 1.
#' @param power 1 - beta (beta is the type II error probability). A number
#' between 0 and 1.
#' @param verbose a logical value whether you want a verbose output or not.
#'
#'@return An object of the S4 class [`seq_anova_results-class`]. Click on the
#' class link to see the full description of the slots.
#' To get access to the object use the
#' `@`-operator or `[]`-brackets instead of `$`.
#' See the examples below.
#'
#' @export
#'
#' @example inst/examples/seq_anova.R


#---- MAIN FUNCTION ------------------------------------------------------------
seq_anova <- function(
  formula,
  f,
  alpha = 0.05,
  power = 0.95,
  data,
  verbose = TRUE
) {
  # get the original names of the variables
  data_name <- deparse(substitute(formula))

  # calculate the sequential anova
  seq_anova_arguments <-
    build_seq_anova_arguments(
      formula,
      data,
      f,
      alpha,
      power,
      data_name,
      verbose
    )
  seq_anova_results <-
    calc_seq_anova(
      seq_anova_arguments
    )
  seq_anova_results
}
