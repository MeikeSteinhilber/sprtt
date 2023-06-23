#---- GENERAL SETTINGS ---------------------------------------------------------
#' @importFrom stats dt df model.frame
#' @importFrom methods callNextMethod new validObject
#' @importFrom MBESS conf.limits.ncf
#' @import dplyr
#'
#'
#---- MAIN FUNCTION DOCUMENTATION ----------------------------------------------
#' @title Sequential Analysis of Variance
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' Performs a sequential one-way fixed effects ANOVA, see Steinhilber et al. (2023) <>
#' for more information.
#'
#' @param formula A formula specifying the model.
#' @param data A data frame in which the variables specified in the formula will be found.
#' @param f Cohen's f (expected minimal effect size or effect size of interest).
#' @param alpha the type I error. A number between 0 and 1.
#' @param power 1 - beta (beta is the type II error probability). A number
#' between 0 and 1.
#' @param verbose a logical value whether you want a verbose output or not.
#' @param plot calculates the ANOVA sequentially on the data and saves the results in the slot called plot.
#' This calculation is necessary for the plot_anova() function.
#' @param seq_steps Defines the sequential steps for the sequential calculation if `plot = TRUE`.
#' Argument takes either a vector of numbers or the argument `single` or `balanced`.
#' A vector of numbers specifies the sample sizes at which the anova is calculated.
#' `single` specifies that after each single point the test statistic is calculated (step size = 1).
#' Attention: the calculation starts at the number of groups times two.
#' If the data do not fit to this, you have to specify the sequential steps yourself in this argument.
#' `balanced` specifies that the step size is equal to the number of groups.
#' Attention: the calculation starts at the number of groups times two.
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
  verbose = TRUE,
  plot = FALSE,
  seq_steps = "single"
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
  if (plot) {
    seq_anova_results <- calc_plot_anova(
      seq_anova_arguments,
      seq_steps
    )
  }
  seq_anova_results
}
