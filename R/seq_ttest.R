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
  ttest_arguments <- build_ttest_arguments(input1, y, data,  mu, d, alpha,
                                           power, alternative, paired
  )
  seq_ttest_results <- calc_seq_ttest(ttest_arguments)
  seq_ttest_results

  # print_results(seq_ttest_results)
  # visualize_results(seq_ttest_results)
}


########################################################################################
