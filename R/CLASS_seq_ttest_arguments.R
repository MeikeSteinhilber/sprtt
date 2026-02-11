setClassUnion("numericORnull", c("numeric","NULL"))
setClassUnion("data.frameORnull", c("data.frame", "NULL"))

setClass(
  Class = "seq_ttest_arguments",
  slots = c(
    data = "data.frameORnull",
    mu = "numeric",
    d = "numeric",
    alpha = "numeric",
    power = "numeric",
    alternative = "character",
    paired = "logical",
    one_sample = "logical",
    total_sample_size = "numeric",
    data_name = "character",
    na.rm = "logical"
  )
)

build_prototype_seq_ttest_arguments <- function(seed=3, type = NULL) {

  if (is.null(type)) {
    new(
      Class = "seq_ttest_arguments",
      data = data.frame(y = rnorm(20), x = rep(c(1,2),10)),
      mu = 0,
      d = 0.8,
      alpha = .05,
      power = .80,
      alternative = "two.sided",
      paired = FALSE,
      one_sample = FALSE,
      total_sample_size = 20,
      data_name = "x and y",
      na.rm = FALSE
    )
  }else if (type == "formula") {
    set.seed(seed)
    new(
      Class = "seq_ttest_arguments",
      data <- draw_sample_normal(2, 0.2, max_n = 20),
      mu = 0,
      d = 0.2,
      alpha = .05,
      power = .90,
      alternative = "two.sided",
      paired = FALSE,
      one_sample = FALSE,
      total_sample_size = nrow(data),
      data_name = "x",
      na.rm = FALSE
    )
  } else {
    stop("set type to NULL or to 'formula'")
  }

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
  if (length(object@data$x) < 2)
    stop("Length of x is less than 2. Length of x must be greater than 2. ")
  if (!is.null(object@data$y)) {
    if (object@one_sample == FALSE &&
        length(object@data$y) < 2
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
    # if (i == "x") {return(x@x)}
    # if (i == "y") {return(x@y)}
    if (i == "data") {return(x@data)}
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



