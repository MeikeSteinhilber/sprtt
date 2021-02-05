#######################################################################################
#                                                                    #
# sprt package                                                       #
# master thesis project                                              #
# master thesis title: "..."                                         #
# author: meike steinhilber                                          #
#                                                                    #
# The generic function in this package provides the implementation   #
# of sequential t-tests.                                             #
#                                                                    #
#######################################################################################
#MAIN Function
setGeneric("seq_ttest",
           function(input1, ...) standardGeneric("seq_ttest")) #the same name necessary

setMethod("seq_ttest",
          signature(input1 = "numeric"),
          function(input1,
                   y = NULL,
                   mu = 0,
                   d,
                   alpha = 0.05,
                   power = 0.95,
                   alternative = "two.sided",
                   paired = FALSE,
                   ...){

            input_arguments = build_input_arguments(input1 = input1,
                                                    y = y,
                                                    mu = mu,
                                                    d = d,
                                                    alpha = alpha,
                                                    power = power,
                                                    alternative = alternative,
                                                    paired = paired)
            input_arguments
          })

setMethod("seq_ttest",
          signature(input1 = "formula"),
          function(input1,
                   data = NULL,
                   mu = 0,
                   d,
                   alpha = 0.05,
                   power = 0.95,
                   alternative = "two.sided",
                   paired = FALSE,
                   ...){
            input_arguments = build_input_arguments(input1 = input1,
                                                    data = data,
                                                    mu = mu,
                                                    d = d,
                                                    alpha = alpha,
                                                    power = power,
                                                    alternative = alternative,
                                                    paired = paired)
            input_arguments
          })




#######################################################################################


