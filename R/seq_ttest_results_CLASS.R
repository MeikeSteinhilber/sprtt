setClassUnion("numericORnull", c("numeric","NULL"))

setClass("seq_ttest_results",
         slots = c(
           t_value = "numeric",
           df = "numeric",
           p_value = "numeric",
           mean_x = "numeric",
           mean_y = "numericORnull",
           alternative = "character",
           ttest_method = "character",
           data_name = "character",
           non_centrality_parameter = "numeric",
           likelihood_1 = "numeric",
           likelihood_2 = "numeric",
           likelihood_ratio = "numeric",
           A_boundary = "numeric",
           B_boundary = "numeric",
           decision = "character"

         ))

# setMethod("initialize", signature = "seq_ttest_results",
#           function(.Object, ...) { # .Object is necessary and can not replaced by x
#             .Object <- callNextMethod() # necessary line
#
#             # correct input arguments
#
#
#             # missing data in x or y
#
#
#             .Object
#           })
