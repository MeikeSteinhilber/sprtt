setClassUnion("numericORnull", c("numeric","NULL"))

#' @exportClass seq_ttest_results
setClass("seq_ttest_results",
         slots = c(
           likelihood_ratio = "numeric",
           decision = "character",
           A_boundary = "numeric",
           B_boundary = "numeric",
           d = "numeric",
           mu = "numericORnull",
           likelihood_1 = "numeric",
           likelihood_2 = "numeric",
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
