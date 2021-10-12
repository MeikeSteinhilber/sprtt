setClassUnion("numeric_data.frame", c("numeric","data.frame"))


setClass(
  Class = "seq_anova_arguments",
  slots = c(
    data = "data.frame",
    f = "numeric",
    alpha = "numeric",
    power = "numeric",
    data_name = "character",
    verbose = "logical"
  )
)
build_prototype_seq_anova_arguments <- function() {
  set.seed(333)
  alpha <- 10
  beta1 <- .3
  beta2 <- -.5
  beta3 <- -1.1
  A <- c(rep(c(0), 10), rep(c(1), 10), rep(c(2), 10)) # '0' 100 times, '1' 100 times
  # B = rep(c(rep(c(0), 50), rep(c(1), 50)), 2) # '0'x50, '1'x50, '0'x50, '1'x50
  e <- rnorm(30, 0, sd = 1) # Random noise, with standard deviation of 1
  # Generate your data using the regression equation
  # y = alpha + beta1*A + beta2*B + beta3*A*B + e
  y <- alpha + beta1*A  + e

  formula <- y ~ A
  data <- data.frame(y, A)
  build_seq_anova_arguments(formula, data, 0.1, 0.05, 0.95, "test name", TRUE)


}

setValidity(
  Class = "seq_anova_arguments",
  function(object) {
    # correct input arguments
    # if (!is.factor(object@factor)) {
    #   stop("Factor must be a factor.")
    # }
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

# Method [] missing
