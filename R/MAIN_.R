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
#MAIN Function
setGeneric("seq_ttest",
           function(input1, ...)
             standardGeneric("seq_ttest")) #the same name necessary

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
                   ...) {
            input_arguments <- new(
              "input_arguments",
              x = delete_na(x = input1, y, wanted = "x"),
              y = delete_na(x = input1, y, wanted = "y"),
              mu = mu,
              d = d,
              alpha = alpha,
              power = power,
              alternative = alternative,
              paired = paired,
              one_sample = get_one_sample(y, alternative),
              one_sided = get_one_sided(alternative)
            )
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
                   ...) {
            x = extract_formula(formula = input1, data = data, paired = paired, wanted = "x")
            y = extract_formula(formula = input1, data = data, paired = paired, wanted = "y")

            input_arguments <- new(
              "input_arguments",
              x = delete_na(x, y, wanted = "x"),
              y = delete_na(x, y, wanted = "y"),
              mu = mu,
              d = d,
              alpha = alpha,
              power = power,
              alternative = alternative,
              paired = paired,
              one_sample = get_one_sample(y, alternative),
              one_sided = get_one_sided(alternative)
            )
            input_arguments
          })

#######################################################################################


