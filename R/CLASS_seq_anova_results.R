setClassUnion("numericORnull", c("numeric","NULL"))


#' An S4 class to represent the results of a sequential anova.
#'
#' @slot likelihood_ratio_log the logarithmic test statistic.
#' @slot decision the test decision: "accept H1", "accept H0",
#' or "continue sampling".
#' @slot A_boundary_log the lower logarithmic boundary of the test.
#' @slot B_boundary_log the upper logarithmic boundary of the test.
#' @slot f a number indicating the specified effect size (Cohen's f).
#' @slot effect_sizes a list with effect sizes (Cohen's f, eta squared, ...).
#' @slot alpha the type I error. A number between 0 and 1.
#' @slot power 1 - beta (beta is the type II error probability). A number
#' between 0 and 1.
#' @slot likelihood_ratio the likelihood ratio of the test without logarithm.
#' @slot likelihood_1 the likelihood of the alternative Hypothesis (H1).
#' @slot likelihood_0 the likelihood of the null Hypothesis (H0).
#' @slot likelihood_1_log the logarithmic likelihood of the alternative
#' Hypothesis (H1).
#' @slot likelihood_0_log the logarithmic likelihood of the null
#' Hypothesis (H0).
#' @slot non_centrality_parameter parameter to calculate the likelihoods
#' @slot F_value the F-value of the F-statistic.
#' @slot df_1 degrees of freedom.
#' @slot df_2 degrees of freedom.
#' @slot ss_effect ss_effect.
#' @slot ss_residual ss_residual.
#' @slot ss_total ss_total.
#' @slot total_sample_size total sample size.
#' @slot data_name a character string giving the name(s) of the data.
#' @slot verbose a logical value whether you want a verbose output or not.
#' @param plot list with all arguments for the plot_anova() function
#'
#' @keywords internal
setClass(
  "seq_anova_results",
  slots = c(
    likelihood_ratio_log = "numeric",
    decision = "character",
    A_boundary_log = "numeric",
    B_boundary_log = "numeric",
    f = "numeric",
    effect_sizes = "ANY",
    alpha = "numeric",
    power = "numeric",
    likelihood_ratio = "numeric",
    likelihood_1 = "numeric",
    likelihood_0 = "numeric",
    likelihood_1_log = "numeric",
    likelihood_0_log = "numeric",
    non_centrality_parameter = "numeric",
    F_value = "numeric",
    df_1 = "numeric",
    df_2 = "numeric",
    ss_effect = "numeric",
    ss_residual = "numeric",
    ss_total = "numeric",
    total_sample_size = "numeric",
    data_name = "character",
    verbose = "logical",
    plot = "ANY"
  )
)

setMethod(
  f = "initialize",
  signature = "seq_anova_results",
  function(.Object, ...) { # '.Object' is necessary and can not replaced by 'x'
    .Object <- callNextMethod() # necessary line
    # validObject(.Object)
    .Object
  }
)

#' Method to retrieve the contents of a slot of an object of the
#'  [`seq_anova_results-class`] class.
#'
#' @param seq_anova_results the corresponding class to this method.
#' @param x the seq_ttest_results object.
#' @param i indices indicating elements to extract.
#' @param j not used.
#' @param drop not used.
#'
#' @return Returns the contents of the specified slot. For more information,
#' see the documentation for the [`seq_anova_results-class`] class.
#' @export
#'
#' @keywords internal
# #' @examples
setMethod(
  f = "[",
  signature = "seq_anova_results",
  function(x, i, j, drop){ # must be this names!
    if (i == "likelihood_ratio") {return(x@likelihood_ratio)}
    if (i == "likelihood_ratio_log") {return(x@likelihood_ratio_log)}
    if (i == "decision") {return(x@decision)}
    if (i == "A_boundary_log") {return(x@A_boundary_log)}
    if (i == "B_boundary_log") {return(x@B_boundary_log)}
    if (i == "f") {return(x@f)}
    if (i == "effect_sizes") {return(x@effect_sizes)}
    if (i == "alpha") {return(x@alpha)}
    if (i == "power") {return(x@power)}
    if (i == "likelihood_1") {return(x@likelihood_1)}
    if (i == "likelihood_0") {return(x@likelihood_0)}
    if (i == "likelihood_1_log") {return(x@likelihood_1_log)}
    if (i == "likelihood_0_log") {return(x@likelihood_0_log)}
    if (i == "non_centrality_parameter") {return(x@non_centrality_parameter)}
    if (i == "F_value") {return(x@F_value)}
    if (i == "df_1") {return(x@df_1)}
    if (i == "df_2") {return(x@df_2)}
    if (i == "ss_effect") {return(x@ss_effect)}
    if (i == "ss_residual") {return(x@ss_residual)}
    if (i == "ss_total") {return(x@ss_total)}
    if (i == "total_sample_size") {return(x@total_sample_size)}
    if (i == "data_name") {return(x@data_name)}
    if (i == "verbose") {return(x@verbose)}
    stop(paste("Wrong slot name: '", i, "' is not a slot name of the class 'seq_anova_results'"))
  }
)


## @slot f_empiric a number indicating the calculated empirical effect size (Cohen's f).
## @slot eta_squared a number indicating the calculated empirical effect size (eta^2).
# if (i == "f_empiric") {return(x@f_empiric)}
# if (i == "eta_squared") {return(x@eta_squared)}
