#--- GENERAL SETTINGS ----
#' @importFrom stats rnorm dt df model.frame sd t.test
#' @importFrom methods callNextMethod new validObject
# #' @useDynLib sprtt
# #' @importFrom Rcpp sourceCpp
# NULL
# #> NULL


#---- MAIN FUNCTION DOCUMENTATION----
#' @title Sequential Probability Ratio Test using t-statistic
#'
#' @description
#' Performs one-sample, two-sample, and paired sequential t-tests, which are variants of
#' Sequential Probability Ratio Tests (SPRT). The test allows for continuous
#' monitoring of data collection and provides stopping boundaries based on
#' likelihood ratios, offering efficiency gains over traditional fixed-N designs.
#'
#' The sequential t-test continuously evaluates the likelihood ratio after each
#' observation (or pair of observations), stopping when sufficient evidence
#' accumulates for either H0 or H1.
#'
#' For methodological details, see Schnuerch & Erdfelder (2019)
#' <doi:10.1037/met0000234>. For practical guidance, see
#' `vignette("t_test", package = "sprtt")`.
#'
#' @param x Works with two classes: `numeric` and `formula`. Therefore you can
#' write `"x"` or `"x~y"`.
#' * `"numeric input"`: a (non-empty) numeric vector of data values.
#' * `"formula input"`: a formula of the form lhs ~ rhs where lhs is a numeric
#' variable giving the data values and rhs either 1 for a one-sample test or a
#' factor with two levels giving the corresponding groups.
#' @param y An optional (non-empty) numeric vector of data values.
#'   Only used for two-sample tests when `x` is numeric.
#' @param data An optional data frame containing the variables specified in the formula.
#'   Only used when `x` is a formula.
#' @param mu a number indicating the true value of the mean (or difference in
#' means if you are performing a two sample test).
#' @param d a number indicating the specified (expected) effect size (Cohen's d)
#' @param alpha Type I error rate (alpha level). The probability of rejecting H0
#'   when it is true. Default is 0.05. Must be between 0 and 1.
#' @param power Statistical power (1 - beta), where beta is the Type II error rate.
#'   The probability of correctly rejecting H0 when H1 is true with effect size d.
#'   Default is 0.95. Must be between 0 and 1. Higher values lead to wider
#'   stopping boundaries and potentially larger sample sizes.
#' @param alternative a character string specifying the alternative hypothesis,
#' must be one of `two.sided` (default), `greater` or `less`.
#' You can specify just the initial letter.
#' @param paired Logical indicating whether to perform a paired t-test.
#'   Default is `FALSE`.
#' @param na.rm a logical value indicating whether `NA` values should be
#' removed before the computation proceeds.
#' @param verbose a logical value whether you want a verbose output or not.
#'
#' @return An object of the S4 class [`seq_ttest_results-class`]. Click on the
#' class link to see the full description of the slots.
#' To get access to the object use the
#' `@`-operator or `[]`-brackets instead of `$`.
#' See the examples below.
#'
#' @seealso
#' * [`seq_anova()`] for sequential one-way ANOVA
#' * [`draw_sample_normal()`] for simulating test data
#' * `vignette("t_test", package = "sprtt")` for detailed tutorial
#' * `vignette("usage_sprtt", package = "sprtt")` for package overview
#' * Schnuerch & Erdfelder (2019) <doi:10.1037/met0000234> for theoretical background
#' @export
#'
#' @example inst/examples/seq_ttest.R


#---- MAIN FUNCTION ----
seq_ttest <- function(
  x,
  y = NULL,
  data = NULL,
  mu = 0,
  d,
  alpha = 0.05,
  power = 0.95,
  alternative = "two.sided",
  paired = FALSE,
  na.rm = TRUE,
  verbose = TRUE
){
  # get the original names of the variables
  input1_name <- deparse(substitute(x))
  if (is.numeric(x) &&
      !is.null(y)) {
    y_name <- deparse(substitute(y))
    data_name <- paste(input1_name, "and ", y_name)
  } else{
    data_name <- paste(input1_name)
  }

  # calculate the sequential test
  seq_ttest_arguments <-
    build_seq_ttest_arguments(
      input1 = x,
      y,
      data,
      mu,
      d,
      alpha,
      power,
      alternative,
      paired,
      data_name,
      na.rm
  )
  seq_ttest_results <-
    calc_seq_ttest(
      seq_ttest_arguments,
      verbose
    )
  seq_ttest_results
}

