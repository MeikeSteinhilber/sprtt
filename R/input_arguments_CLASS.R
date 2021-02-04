# define a union of two classes. Is needed for the y argument.
# setOldClass("data.frame")
setClassUnion("numericORnull", c("numeric","NULL"))
# setClassUnion("data.frameORnull", c("data.frame","NULL"))


setClass("input_arguments",
         slots = c(
           x = "numeric",
           y = "numericORnull",
           # data = "data.frameORnull",
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
            if (!is.null(.Object@y)) {
              if (.Object@one_sample == FALSE && length(.Object@y) < 2)
                stop("Length of y is less than 2. Length of y must be greater than 2. ")
            }

            .Object
          })
