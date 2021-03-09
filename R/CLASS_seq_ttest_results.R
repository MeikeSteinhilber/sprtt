setClassUnion("numericORnull", c("numeric","NULL"))


#' An S4 class to represent the results of a sequential t-test.
#'
#' @slot likelihood_ratio_log the logarithmic test statistic.
#' @slot decision the test decision: "accept H1", "accept H0",
#' or "continue sampling".
#' @slot A_boundary_log the lower logarithmic boundary of the test.
#' @slot B_boundary_log the upper logarithmic boundary of the test.
#' @slot d a number indicating the specified effect size (Cohen's d).
#' @slot mu a number indicating the true value of the mean.
#' @slot alpha the type I error. A number between 0 and 1.
#' @slot power 1 - beta (beta is the type II error probability). A number
#' between 0 and 1.
#' @slot likelihood_ratio the likelihood ratio of the test without logarithm.
#' @slot likelihood_1 the likelihood of the alternative Hypothesis (H1).
#' @slot likelihood_2 the likelihood of the null Hypothesis (H0).
#' @slot likelihood_1_log the logarithmic likelihood of the alternative
#' Hypothesis (H1).
#' @slot likelihood_2_log the logarithmic likelihood of the null
#' Hypothesis (H0).
#' @slot non_centrality_parameter parameter to calculate the likelihoods
#' @slot t_value the t-value of the t-statistic.
#' @slot p_value the p-value of the t-test.
#' @slot df degrees of freedom.
#' @slot mean_x mean of the first group.
#' @slot mean_y mean of the second group.
#' @slot alternative a character string specifying the alternative hypothesis:
#'       "two.sided" (default), "greater" or "less".
#' @slot one_sample "true" if it is a one-sample test, "false" if it is a
#' two-sample test.
#' @slot ttest_method a character string indicating what type of t-test was
#' performed.
#' @slot data_name a character string giving the name(s) of the data.
setClass(
  "seq_ttest_results",
  slots = c(
    likelihood_ratio_log = "numeric",
    decision = "character",
    A_boundary_log = "numeric",
    B_boundary_log = "numeric",
    d = "numeric",
    mu = "numericORnull",
    alpha = "numeric",
    power = "numeric",
    likelihood_ratio = "numeric",
    likelihood_1 = "numeric",
    likelihood_2 = "numeric",
    likelihood_1_log = "numeric",
    likelihood_2_log = "numeric",
    non_centrality_parameter = "numeric",
    t_value = "numeric",
    p_value = "numeric",
    df = "numeric",
    mean_x = "numeric",
    mean_y = "numericORnull",
    alternative = "character",
    one_sample = "logical",
    ttest_method = "character",
    data_name = "character"
  )
)

#' Method to retrieve the contents of a slot of an object of the
#'  seq_ttest_results class.
#'
#' @param seq_ttest_results the corresponding class to this method.
#' @param x the seq_ttest_results object.
#' @param i the start of the string of the slot name.
#' @param j the end of the string of the slot name.
#' @param drop not used.
#'
#' @return the content of the slot.
#' @export
#'
# #' @examples
setMethod(
  f = "[",
  signature = "seq_ttest_results",
  function(x, i, j, drop){ # must be this names!
    if (i == "likelihood_ratio") {return(x@likelihood_ratio)}
    if (i == "likelihood_ratio_log") {return(x@likelihood_ratio_log)}
    if (i == "decision") {return(x@decision)}
    if (i == "A_boundary_log") {return(x@A_boundary_log)}
    if (i == "B_boundary_log") {return(x@B_boundary_log)}
    if (i == "d") {return(x@d)}
    if (i == "mu") {return(x@mu)}
    if (i == "alpha") {return(x@alpha)}
    if (i == "power") {return(x@power)}
    if (i == "likelihood_1") {return(x@likelihood_1)}
    if (i == "likelihood_2") {return(x@likelihood_2)}
    if (i == "likelihood_1_log") {return(x@likelihood_1_log)}
    if (i == "likelihood_2_log") {return(x@likelihood_2_log)}
    if (i == "non_centrality_parameter") {return(x@non_centrality_parameter)}
    if (i == "t_value") {return(x@t_value)}
    if (i == "p_value") {return(x@p_value)}
    if (i == "df") {return(x@df)}
    if (i == "mean_x") {return(x@mean_x)}
    if (i == "mean_y") {return(x@mean_y)}
    if (i == "alternative") {return(x@alternative)}
    if (i == "one_sample") {return(x@one_sample)}
    if (i == "ttest_method") {return(x@ttest_method)}
    if (i == "data_name") {return(x@data_name)}
    stop(paste("Wrong slot name: '", i, "' is not a slot name of the class 'seq_ttest_results'"))
  }
)


# likelihood_ratio
# likelihood_ratio_log
# decision
# A_boundary_log
# B_boundary_log
# d
# mu
# likelihood_1
# likelihood_2
# likelihood_1_log
# likelihood_2_log
# non_centrality_parameter
# t_value
# p_value
# df
# mean_x
# mean_y
# alternative
# one_sample
# ttest_method
# data_name
