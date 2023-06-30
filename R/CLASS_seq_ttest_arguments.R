setClassUnion("numericORnull", c("numeric","NULL"))


setClass(
  Class = "seq_ttest_arguments",
  slots = c(
    x = "numeric",
    y = "numericORnull",
    mu = "numeric",
    d = "numeric",
    alpha = "numeric",
    power = "numeric",
    alternative = "character",
    paired = "logical",
    one_sample = "logical",
    data_name = "character",
    na.rm = "logical"
  )
)
build_prototype_seq_ttest_arguments <- function() {
  new(
    Class = "seq_ttest_arguments",
    x = c(-0.8576829, -1.2119236, -1.2883021,  0.2532647, -1.6749356,
          1.2018224,  0.4220293, -0.3896717,  1.5371334,  0.6254288
          ),
    y = c(1.4016121,  1.2807517,  1.8763097,  0.5280401,  1.7045422,
          1.2462588, -0.2278561, -0.1054774,  0.9764811,  1.8253478
          ),
    mu = 0,
    d = 0.8,
    alpha = .05,
    power = .80,
    alternative = "two.sided",
    paired = FALSE,
    one_sample = FALSE,
    data_name = "x and y",
    na.rm = FALSE
  )
}

setValidity(
  Class = "seq_ttest_arguments",
  function(object) {
  # correct input arguments
  if (object@alternative != "two.sided" &&
     object@alternative != "greater" &&
     object@alternative != "less"
     )
    stop("Invalid argument <alternative>: Must be either 'two.sided', 'greater' or 'less'.")
  if (!(object@alpha > 0 &&
       object@alpha < 1
       ))
    stop("Invalid argument <alpha>: Probabilities must be in ]0;1[.")
  if (!(object@power > 0 &&
       object@power < 1
       ))
    stop("Invalid argument <power>: Probabilities must be in ]0;1[.")
  if (object@d <= 0)
    stop("Invalid argument <d>: Must be greater than 0.")
  if (length(object@one_sample) == 0)
    stop("Invalid argument <one_sample>: Error in class input_arguments.")

  # missing data in x or y
  if (length(object@x) < 2)
    stop("Length of x is less than 2. Length of x must be greater than 2. ")
  if (!is.null(object@y)) {
    if (object@one_sample == FALSE &&
        length(object@y) < 2
        )
      stop("Length of y is less than 2. Length of y must be greater than 2. ")
  }
  TRUE
})
setMethod(
  f = "initialize",
  signature = "seq_ttest_arguments",
  function(.Object, ...) { # '.Object' is necessary and can not replaced by 'x'
    .Object <- callNextMethod() # necessary line
    validObject(.Object)
    .Object
  }
)

#' Method to retrieve the contents of a slot of an object of the
#'  seq_ttest_arguments class.
#'
#' @description This method is only used internally to process
#' the input arguments of the [`seq_ttest`] function. As a normal user,
#' you can ignore this specific documentation.
#'
#' @param seq_ttest_arguments the corresponding class to this method.
#' @param x the seq_ttest_arguments object.
#' @param i indices indicating elements to extract.
#' @param j not used.
#' @param drop not used.
#'
#' @keywords internal
#' @return Returns the contents of the specified slot of an
#' seq_ttest_arguments object. For more information, see the arguments of the
#' [`seq_ttest`] function.
setMethod(
  f = "[",
  signature = "seq_ttest_arguments",
  function(x, i, j, drop){ # must be this names!
    if (i == "x") {return(x@x)}
    if (i == "y") {return(x@y)}
    if (i == "mu") {return(x@mu)}
    if (i == "d") {return(x@d)}
    if (i == "alpha") {return(x@alpha)}
    if (i == "power") {return(x@power)}
    if (i == "alternative") {return(x@alternative)}
    if (i == "paired") {return(x@paired)}
    if (i == "one_sample") {return(x@one_sample)}
    if (i == "data_name") {return(x@data_name)}
    if (i == "na.rm") {return(x@na.rm)}
    stop(paste("Wrong slot name: '", i, "' is not a slot name of the class 'seq_ttest_arguments'"))
  }
)



