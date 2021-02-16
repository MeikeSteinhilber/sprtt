#######################################################################################
#     sprt package                                                                    #
#                                                                                     #
#     master thesis project                                                           #
#     master thesis title: "..."                                                      #
#     author: meike steinhilber                                                       #
#                                                                                     #
#     The generic function in this package provides the implementation                #
#     of sequential t-tests.                                                          #
#                                                                                     #
#######################################################################################
#--- GENERAL SETTINGS

#' @import stats
#' @importFrom methods callNextMethod new
#' @export seq_ttest

library(methods)

seq_ttest <- function(input1,
                    y = NULL,
                    data = NULL,
                    mu = 0,
                    d,
                    alpha = 0.05,
                    power = 0.95,
                    alternative = "two.sided",
                    paired = FALSE,
                    ...){
  input1_name <- deparse(substitute(input1))
  if(!is.null(y)){
    y_name <- deparse(substitute(y))
    data_name <- paste(input1_name, "and ", y_name)
  } else{
    data_name <- paste(input1_name)
  }

  # data_name <- get_data_name(input1, y)

  ttest_arguments <- build_ttest_arguments(input1, y, data,  mu, d, alpha,
                                           power, alternative, paired, data_name)
  seq_ttest_results <- calc_seq_ttest(ttest_arguments)
  seq_ttest_results

  # visualize_results(seq_ttest_results)
}


########################################################################################
