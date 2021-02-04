######################################################################
#                                                                    #
# sprt package                                                       #
# master thesis project                                              #
# master thesis title: "..."                                         #
# author: meike steinhilber                                          #
#                                                                    #
# The generic function in this package provides the implementation   #
# of sequential t-tests.                                             #
#                                                                    #
######################################################################
#MAIN Function
setGeneric("seq_ttest",
           function(input1, ...) standardGeneric("seq_ttest"))

setMethod("seq_ttest",
          signature = "numeric",
          function(input1,
                   y = integer(0),
                   mu = 0,
                   d,
                   alpha = 0.05,
                   power = 0.95,
                   alternative = "two.sided",
                   paired = FALSE,
                   ...){

            if(length(y) == 0) {
              one_sample = TRUE
            } else{
              one_sample = FALSE
            }
            if (alternative == "two.sided") {
              one_sided = FALSE
            } else{
              one_sided = TRUE
            }

            input_arguments <- new(
              "input_arguments",
              x = x,
              y = y,
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
          }
)

setMethod("seq_ttest",
          signature = c("formula"),
          function(input1,
                   data = NULL,
                   mu = 0,
                   d,
                   alpha = 0.05,
                   power = 0.95,
                   alternative = "two.sided",
                   paired = FALSE,
                   ...){
            print("yayyyyy")
          })

setClass("input_arguments",
         slots = c(
           x = "numeric",
           y = "numeric",
           mu = "numeric",
           d = "numeric",
           alpha = "numeric",
           power = "numeric",
           alternative = "character",
           paired = "logical",
           one_sample = "logical",
           one_sided = "logical"
         ))

setMethod("initialize", signature = "input_arguments",
          function(.Object, ...) { # .Object is necessary and can not replaced by x
            .Object <- callNextMethod() # necessary line

            # correct input arguments
            if(.Object@alternative != "two.sided" && .Object@alternative != "greater" && .Object@alternative != "less")
              stop("Invalid argument <alternative>: Must be either 'two.sided', 'greater' or 'less'.")
            if(!(.Object@alpha > 0 && .Object@alpha < 1))
              stop("Invalid argument <alpha>: Probabilities must be in ]0;1[.")
            if(!(.Object@power > 0 && .Object@power < 1))
              stop("Invalid argument <power>: Probabilities must be in ]0;1[.")
            if(d <= 0)
              stop("Invalid argument <d>: Must be greater than 0.")
            if(length(.Object@one_sample) == 0)
              stop("Invalid argument <one_sample>: Error in class input_arguments.")
            if(length(.Object@one_sided) == 0)
              stop("Invalid argument <one_sided>: Error in class input_arguments.")

            # missing data in x or y
            if(length(.Object@x) < 2)
              stop("Length of x is less than 2. Length of x must be greater than 2. ")
            if(.Object@one_sample == FALSE && length(.Object@y) < 2)
              stop("Length of y is less than 2. Length of y must be greater than 2. ")

            .Object
          })


###################################################################################

x <- rnorm(50)
y <- rnorm(50)
d <- 0.3
formula = x ~ y
seq_ttest(x,d = d)
seq_ttest(x ~ y, d)
class(x~y)

new("input_arguments", x = d, alternative = "two.sided", a)
