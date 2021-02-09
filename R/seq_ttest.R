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
           function(input1,
                    y = NULL,
                    data = NULL,
                    mu = 0,
                    d,
                    alpha = 0.05,
                    power = 0.95,
                    alternative = "two.sided",
                    paired = FALSE,
                    ...)
             standardGeneric("seq_ttest")) #the same name necessary

setMethod("seq_ttest",
          signature(input1 = "numeric"),
          function(input1,
                   ...) {
            one_sample = get_one_sample(y)
            one_sided = get_one_sided(alternative)

            input_arguments <- new(
              "input_arguments",
              x = delete_na(x = input1, y, one_sample = one_sample, wanted = "x"),
              y = delete_na(x = input1, y, one_sample = one_sample, wanted = "y"),
              mu = mu,
              d = d,
              alpha = alpha,
              power = power,
              alternative = alternative,
              paired = paired,
              one_sample = one_sample,
              one_sided = one_sided
            )
            input_arguments
          })

setMethod("seq_ttest",
          signature(input1 = "formula"),
          function(input1,
                    ...) {
            x = extract_formula(formula = input1, data = data, paired = paired, wanted = "x")
            y = extract_formula(formula = input1, data = data, paired = paired, wanted = "y")
            one_sample = get_one_sample(y)
            one_sided = get_one_sided(alternative)

            input_arguments <- new(
              "input_arguments",
              x = delete_na(x, y, one_sample = one_sample, wanted = "x"),
              y = delete_na(x, y, one_sample = one_sample, wanted = "y"),
              mu = mu,
              d = d,
              alpha = alpha,
              power = power,
              alternative = alternative,
              paired = paired,
              one_sample = one_sample,
              one_sided = one_sided
            )
            input_arguments
          })

#######################################################################################

