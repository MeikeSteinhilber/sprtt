#---- GENERAL SETTINGS ---------------------------------------------------------
#' @importFrom stats dt df model.frame as.formula runif
#' @importFrom methods callNextMethod new validObject
#' @importFrom MBESS conf.limits.ncf
#' @importFrom glue glue
#' @importFrom knitr opts_chunk
#' @importFrom ggtext element_markdown
#' @importFrom scales percent_format percent
#' @import dplyr ggplot2 gt
#'
#'
#---- MAIN FUNCTION DOCUMENTATION ----------------------------------------------
#' @title Sequential Analysis of Variance
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' Performs a sequential one-way fixed effects ANOVA, which is a variant of a Sequential
#' Probability Ratio Test (SPRT). The test allows for continuous
#' monitoring of data collection and provides stopping boundaries based on
#' likelihood ratios, offering efficiency gains over traditional fixed-N designs.
#'
#' The sequential ANOVA continuously evaluates the likelihood ratio after each
#' observation (or group of observations), stopping when sufficient evidence
#' accumulates for either H0 or H1.
#'
#' For methodological details, see Steinhilber et al. (2024)
#' <doi:10.1037/met0000677>. For practical guidance, see
#' `vignette("one_way_anova", package = "sprtt")`.
#'
#' @section Limitations:
#' * Only one-way fixed effects ANOVA is currently supported
#' * Repeated measures ANOVA is not yet implemented
#'
#' @param formula A formula specifying the model (e.g., `outcome ~ group`).
#'   The response variable should be on the left side and the grouping factor
#'   on the right side. Currently only supports one-way designs.
#' @param data A data frame containing the variables specified in the formula.
#'   Missing values (NA) will be removed with a warning
#' @param f Cohen's f (expected minimal effect size or effect size of interest), that defines the H1.
#' @param alpha Type I error rate (alpha level). The probability of rejecting H0
#'   when it is true. Default is 0.05. Must be between 0 and 1.
#' @param power Statistical power (1 - beta), where beta is the Type II error rate.
#'   The probability of correctly rejecting H0 when H1 is true with effect size f.
#'   Default is 0.95. Must be between 0 and 1. Higher values lead to wider
#'   stopping boundaries and potentially larger sample sizes.
#' @param verbose a logical value whether you want a verbose output or not.
#' @param plot Logical. If `TRUE`, stores sequential test statistics at each sequential step
#'   for visualization with `plot_anova()`. This enables retrospective examination
#'   of the decision process but increases computation time for large datasets.
#'   Default is `FALSE`.
#' @param seq_steps Specifies when to calculate test statistics during sequential
#'   testing (only relevant when `plot = TRUE`). Options:
#'   * Vector of integers: Calculate at specific sample sizes (e.g., `c(10, 20, 30)`)
#'   * `"single"`: Calculate after each observation (step size = 1).
#'     Note: Starts at `k_groups * 2` to ensure sufficient data
#'   * `"balanced"`: Calculate when each group gains one observation
#'     (step size = number of groups). Note: Starts at `k_groups * 2`
#'
#'   For unbalanced designs or non-standard sequences, specify custom steps as a vector.
#'
#'@return An object of the S4 class [`seq_anova_results-class`]. Click on the
#' class link to see the full description of the slots.
#' To get access to the object use the
#' `@`-operator or `[]`-brackets instead of `$`.
#' See the examples below.
#'
#' @seealso
#' * [`plot_anova()`] for visualizing sequential ANOVA results
#' * [`plan_sample_size()`] for sample size planning
#' * [`seq_ttest()`] for sequential t-tests
#' * `vignette("one_way_anova", package = "sprtt")` for detailed tutorial
#' * `vignette("plan_sample_size", package = "sprtt")` for planning guidance
#' * Steinhilber et al. (2023) for theoretical background
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
