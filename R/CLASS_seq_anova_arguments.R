setClassUnion("numeric_data.frame", c("numeric","data.frame"))


setClass(
  Class = "seq_anova_arguments",
  slots = c(
    data = "data.frame",
    f = "numeric",
    alpha = "numeric",
    power = "numeric",
    total_sample_size = "numeric",
    data_name = "character",
    verbose = "logical"
  )
)
build_prototype_seq_anova_arguments <- function(seed = 333, max_n = 50, f = 0.4) {
  set.seed(seed)
  data <- draw_sample(f = f, max_n = max_n)
  formula <- y~x
  build_seq_anova_arguments(formula, data, 0.5, 0.05, 0.95, "test name", TRUE)
}

setValidity(
  Class = "seq_anova_arguments",
  function(object) {
    # correct input arguments
    if(object@f <= 0){stop("f must be greater than 0.")}
    if (!(object@alpha > 0 &&
          object@alpha < 1
    ))
      stop("Invalid argument <alpha>: Probabilities must be in ]0;1[.")
    if (!(object@power > 0 &&
          object@power < 1
    ))
      stop("Invalid argument <power>: Probabilities must be in ]0;1[.")

    TRUE
  })
setMethod(
  f = "initialize",
  signature = "seq_anova_arguments",
  function(.Object, ...) { # '.Object' is necessary and can not replaced by 'x'
    .Object <- callNextMethod() # necessary line
    validObject(.Object)
    .Object
  }
)

#' Method to retrieve the contents of a slot of an object of the
#'  seq_anova_arguments class.
#'
#' @description This method is only used internally to process
#' the input arguments of the [`seq_anova`] function. As a normal user,
#' you can ignore this specific documentation.
#'
#' @param seq_anova_arguments the corresponding class to this method.
#' @param x the seq_anova_arguments object.
#' @param i indices indicating elements to extract.
#' @param j not used.
#' @param drop not used.
#'
#' @return Returns the contents of the specified slot. For more information,
#' see the documentation for the seq_anova_arguments class.
#' @export
#'
#' @keywords internal
# #' @examples
setMethod(
  f = "[",
  signature = "seq_anova_arguments",
  function(x, i, j, drop){ # must be this names!

    if (i == "data") {return(x@data)}
    if (i == "f") {return(x@f)}
    if (i == "alpha") {return(x@alpha)}
    if (i == "power") {return(x@power)}
    if (i == "total_sample_size") {return(x@total_sample_size)}
    if (i == "data_name") {return(x@data_name)}
    if (i == "verbose") {return(x@verbose)}
    stop(paste("Wrong slot name: '", i, "' is not a slot name of the class 'seq_anova_arguments'"))
  }
)

