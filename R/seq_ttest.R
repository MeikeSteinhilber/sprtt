################################################################################
#     sprtt package                                                            #
#                                                                              #
#     master thesis project                                                    #
#     master thesis title: "sprtt: An R Package for Sequential Probability     #
#     Ratio Tests Using the Associated t-Statistic"                            #
#     author: Meike Steinhilber                                                #
#                                                                              #
#     This package provides the implementation of sequential probability       #
#     ratio tests using t-statistic.                                           #
#                                                                              #
################################################################################
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
#' data.
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
  verbose = TRUE
){
  # get the original names of the variables
  input1_name <- deparse(substitute(x))
  if (class(x) == "numeric" &&
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
      mu, d,
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

