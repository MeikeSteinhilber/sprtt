setClassUnion("numericORnull", c("numeric","NULL"))


#' @exportClass seq_ttest_results
setClass("seq_ttest_results",
         slots = c(
           likelihood_ratio_log = "numeric",
           decision = "character",
           A_boundary_log = "numeric",
           B_boundary_log = "numeric",
           d = "numeric",
           mu = "numericORnull",
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
         ))

# setGeneric("$",function(object,value, ...){standardGeneric("$")})
setMethod(
  f = "[",
  signature = "seq_ttest_results",
  function(x, i, j, drop){ # must be this names!
    if(i == "likelihood_ratio"){return(x@likelihood_ratio)}
    if(i == "likelihood_ratio_log"){return(x@likelihood_ratio_log)}
    if(i == "decision"){return(x@decision)}
    if(i == "A_boundary_log"){return(x@A_boundary_log)}
    if(i == "B_boundary_log"){return(x@B_boundary_log)}
    if(i == "d"){return(x@d)}
    if(i == "mu"){return(x@mu)}
    if(i == "likelihood_1"){return(x@likelihood_1)}
    if(i == "likelihood_2"){return(x@likelihood_2)}
    if(i == "likelihood_1_log"){return(x@likelihood_1_log)}
    if(i == "likelihood_2_log"){return(x@likelihood_2_log)}
    if(i == "non_centrality_parameter"){return(x@non_centrality_parameter)}
    if(i == "t_value"){return(x@t_value)}
    if(i == "p_value"){return(x@p_value)}
    if(i == "df"){return(x@df)}
    if(i == "mean_x"){return(x@mean_x)}
    if(i == "mean_y"){return(x@mean_y)}
    if(i == "alternative"){return(x@alternative)}
    if(i == "one_sample"){return(x@one_sample)}
    if(i == "ttest_method"){return(x@ttest_method)}
    if(i == "data_name"){return(x@data_name)}
    stop(paste("Wrong slot name: '", i, "' is not a slot name of the class 'seq_ttest_results'"))
  }
)

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
