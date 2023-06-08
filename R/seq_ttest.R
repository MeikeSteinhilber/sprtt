#--- GENERAL SETTINGS ----
#' @importFrom stats rnorm dt df model.frame sd t.test
#' @importFrom methods callNextMethod new validObject
# #' @useDynLib sprtt
# #' @importFrom Rcpp sourceCpp
# NULL
# #> NULL


#---- MAIN FUNCTION DOCUMENTATION----
#' @title Sequential Probability Ratio Test using t-statistic
#' @description Performs one and two sample sequential t-tests on vectors of
#' data. For more information on the sequential t-test, see Schnuerch & Erdfelder (2019) <doi:10.1037/met0000234>.
#'
#' @param x Works with two classes: `numeric` and `formula`. Therefore you can
#' write `"x"` or `"x~y"`.
#' * `"numeric input"`: a (non-empty) numeric vector of data values.
#' * `"formula input"`: a formula of the form lhs ~ rhs where lhs is a numeric
#' variable giving the data values and rhs either 1 for a one-sample test or a
#' factor with two levels giving the corresponding groups.
#' @param y an optional (non-empty) numeric vector of data values.
#' @param data an optional `data.frame`, which you can use only in combination
#' with a `"formula input"` in argument `x`.
#' @param mu a number indicating the true value of the mean (or difference in
#' means if you are performing a two sample test).
#' @param d a number indicating the specified effect size (Cohen's d)
#' @param alpha the type I error. A number between 0 and 1.
#' @param power 1 - beta (beta is the type II error probability). A number
#' between 0 and 1.
#' @param alternative a character string specifying the alternative hypothesis,
#' must be one of `two.sided` (default), `greater` or `less`.
#' You can specify just the initial letter.
#' @param paired a logical indicating whether you want a paired t-test.
#' @param na.rm a logical value indicating whether `NA` values should be
#' stripped before the computation proceeds.
#' @param verbose a logical value whether you want a verbose output or not.
#' @param plot calculates the ANOVA sequentially on the data and saves the results in the slot called plot.
#' This calculation is necessary for the plot_sprt() function.
#' @param seq_steps Defines the sequential steps for the sequential calculation if `plot = TRUE`.
#' Argument takes either a vector of numbers or the argument `single` or `balanced`.
#' A vector of numbers specifies the sample sizes at which the t-test is calculated.
#' `single` specifies that after each single point the test statistic is calculated (step size = 1).
#' Attention: the calculation starts at the number of groups times two.
#' If the data do not fit to this, you have to specify the sequential steps yourself in this argument.
#' `balanced` specifies that the step size is equal to the number of groups.
#' Attention: the calculation starts at the number of groups times two.
#'
#' @return An object of the S4 class [`seq_ttest_results-class`]. Click on the
#' class link to see the full description of the slots.
#' To get access to the object use the
#' `@`-operator or `[]`-brackets instead of `$`.
#' See the examples below.
#'
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
  verbose = TRUE,
  plot = FALSE,
  seq_steps = "balanced"
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
  if (plot) {
    seq_ttest_results <- calc_plot_ttest(
      seq_ttest_arguments,
      seq_steps
    )
  }
  seq_ttest_results
}

