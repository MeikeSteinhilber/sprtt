#* @testing seq_ttest
#*

# MARTIN Skript ----------------------------------------------------------

.sprt.lr <- function(x, y, mu, d, type, alt){
  ttest <- switch(type,
                  one.sample = t.test(x, mu = mu),
                  two.sample = t.test(x, y, mu = mu,
                                      var.equal = T),
                  paired = t.test(x, y, mu = mu,
                                  paired = T))
  # print(ttest)
  ncp <- ifelse(type == "two.sample",
                d/sqrt(1/length(x) + 1/length(y)),
                d * sqrt(length(x)))

  tval <- ifelse(alt == "less",
                 -1 * as.vector(ttest$statistic),
                 as.vector(ttest$statistic))

  dof <- as.vector(ttest$parameter)

  # print(paste("ncp", ncp))
  # print(paste("tval", tval))
  # print(paste("dof", dof))

  if(alt=="two.sided"){
    lr <- df(tval^2, df1 = 1, df2 = dof, ncp = ncp^2)/df(tval^2, df1 = 1, df2 = dof)
    # l1 <- df(tval^2, df1 = 1, df2 = dof, ncp = ncp^2)
    # l2 <- df(tval^2, df1 = 1, df2 = dof)
    # # print(l1/l2)
  } else{
    lr <- dt(tval, dof, ncp = ncp)/dt(tval, dof)
  }
  lr
  # print(lr)
}


.sprt.formula <- function(formula, data = NULL,
                          mu = 0, d, alpha = 0.05, power = 0.95,
                          alternative = "two.sided", paired = FALSE){

  ##### CHECK INPUT
  match.arg(alternative, c("two.sided", "less", "greater"))
  if(!(alpha > 0 && alpha < 1))
    stop("Invalid argument <alpha>: Probabilities must be in ]0;1[.")
  if(!(power > 0 && power < 1))
    stop("Invalid argument <power>: Probabilities must be in ]0;1[.")
  if(d <= 0)
    stop("Invalid argument <d>: Must be greater than 0.")
  if(!is.numeric(mu))
    stop("Invalid argument <mu>: Must be numeric.")
  if(!is.logical(paired))
    stop("Invalid argument <paired>: Must be logical.")

  if ((length(formula) != 3L) || (length(formula[[3]]) != 1L))
    stop("'formula' is incorrect. Please specify as 'x~y'.")
  temp <- model.frame(formula, data)
  x <- temp[,1]
  y <- temp[,2]

  whichNA <- is.na(x) | is.na(y)
  x <- x[!whichNA]
  y <- y[!whichNA]

  if(!is.numeric(x))
    stop(paste("Dependent variable",  names(temp)[1], "must be numeric."))
  if(length(unique(y))!=2)
    stop(paste("Grouping factor", names(temp)[2], "must contain exactly two levels."))
  if(paired){
    if(!(table(y)[[1]]==table(y)[[2]]))
      stop("Unequal number of observations per group. Independent samples?")
  }else{
    if(length(x)<3)
      stop("SPRT for two independent samples requires at least 3 observations.")
  }

  sd.check <- tapply(x, INDEX=y, FUN=sd)
  sd.check <- ifelse(is.na(sd.check), 0, sd.check)
  if(max(sd.check) == 0)
    stop("Can't perform SPRT on constant data.")

  ##### RETURN ARGUMENTS
  y <- as.factor(y)
  x.1 <- x[y == levels(y)[1]]
  x.2 <- x[y == levels(y)[2]]
  data.name <- paste(names(temp)[1], "by", names(temp)[2])
  method <- ifelse(paired, "Paired SPRT t-test", "Two-Sample SPRT t-test")
  null.value <- mu
  attr(null.value, "names") <- "difference in means"
  if(paired){
    estimate <- mean(x.1 - x.2)
    attr(estimate, "names") <- "mean of the differences"
  }else{
    estimate <- c(mean(x.1), mean(x.2))
    attr(estimate, "names") <- c("mean in group 1", "mean in group 2")
  }
  arg.list <- list(x = x.1, y = x.2,
                   mu = mu, d = d, alpha = alpha, power = power,
                   type = ifelse(paired, "paired", "two.sample"),
                   alt = alternative)
  printarg.list <- list(estimate = estimate,
                        null.value = null.value,
                        alternative = alternative,
                        effect.size = d,
                        method = method,
                        data.name = data.name)

  result <- do.call(.sprt.result, arg.list)
  output <- c(result, printarg.list)
  class(output) <- "sprt"
  return(output)
}


.sprt.default <- function(x, y = NULL,
                          mu = 0, d, alpha = 0.05, power = 0.95,
                          alternative = "two.sided", paired = FALSE){

  ##### CHECK INPUT
  match.arg(alternative, c("two.sided", "less", "greater"))
  if(!(alpha > 0 && alpha < 1))
    stop("Invalid argument <alpha>: Probabilities must be in ]0;1[.")
  if(!(power > 0 && power < 1))
    stop("Invalid argument <power>: Probabilities must be in ]0;1[.")
  if(d<=0)
    stop("Invalid argument <d>: Must be greater than 0.")
  if(!is.numeric(mu))
    stop("Invalid argument <mu>: Must be numeric.")

  if(!is.null(y)){
    x.name <- deparse(substitute(x))
    y.name <- deparse(substitute(y))
    data.name <- paste(x.name, "and", y.name)

    if(!(is.atomic(x) && is.null(dim(x))))
      warning(paste(x.name, "is not a vector. This might have caused problems."), call. = F)
    if(!(is.atomic(y) && is.null(dim(y))))
      warning(paste(y.name, "is not a vector. This might have caused problems."), call. = F)
    if(is.factor(y))
      stop("Is y a grouping factor? Use formula interface x ~ y.")
    if(!is.numeric(x))
      stop(paste("Invalid argument:",  x.name, "must be numeric."))
    if(!is.numeric(y))
      stop(paste("Invalid argument:",  y.name, "must be numeric."))
    if(!paired && (length(x) + length(y) < 3))
      stop("SPRT for two independent samples requires at least 3 observations.")

    sd.check <- c(sd(x), sd(y))
    sd.check <- ifelse(is.na(sd.check), 0, sd.check)
    if(!(max(sd.check) > 0))
      stop("Can't perform SPRT on constant data.")
    if(!is.logical(paired))
      stop("Invalid argument <paired>: Must be logical.")

    type <- ifelse(paired, "paired", "two.sample")
    method <- ifelse(paired, "Paired SPRT t-test", "Two-Sample SPRT t-test")
    null.value <- mu
    attr(null.value, "names") <- "difference in means"
    if(paired){
      if(length(x) != length(y))
        stop("Unequal number of observations per group. Independent samples?")
      whichNA <- is.na(x) | is.na(y)
      x <- x[!whichNA]
      y <- y[!whichNA]
      estimate <- mean(x - y)
      attr(estimate, "names") <- "mean of the differences"
    }else{
      x <- x[!is.na(x)]
      y <- y[!is.na(y)]
      estimate <- c(mean(x), mean(y))
      attr(estimate, "names") <- c(paste("mean of", x.name), paste("mean of", y.name))
    }
  }else{
    data.name <- deparse(substitute(x))

    x <- x[!is.na(x)]
    if(!is.numeric(x))
      stop(paste("Invalid argument:",  data.name, "must be numeric."))
    sd.check <- ifelse(is.na(sd(x)), 0, sd(x))
    if(!(sd.check > 0))
      stop("Can't perform SPRT on constant data.")

    type <- "one.sample"
    method <- "One-Sample SPRT t-test"
    null.value <- mu
    attr(null.value, "names") <- "mean"
    estimate <- mean(x)
    attr(estimate, "names") <- "mean of x"
  }

  ##### RETURN ARGUMENTS

  arg.list <- list(x = x, y = y,
                   mu = mu, d = d, alpha = alpha, power = power,
                   type = type,
                   alt = alternative)
  printarg.list <- list(estimate = estimate,
                        null.value = null.value,
                        alternative = alternative,
                        effect.size = d,
                        method = method,
                        data.name = data.name)
  result <- do.call(.sprt.result, arg.list)
  output <- c(result, printarg.list)
  class(output) <- "sprt"
  return(output)
}


.sprt.result <- function(x, y, mu, d, alpha, power, type, alt){
  A <- power/alpha
  B <- (1 - power)/(1 - alpha)
  lr <- .sprt.lr(x, y, mu, d, type, alt)
  if(lr >= A){
    decision <- "accept H1"
  }else if(lr <= B){
    decision <- "accept H0"
  }else{
    decision <- "continue sampling"
  }
  attr(lr, "names") <- "likelihood ratio"
  parameters <- c(alpha, power)
  attr(parameters, "names") <- c("Type I error", "Power")
  thresholds <- c(B, A)
  attr(thresholds, "names") <- c("lower", "upper")
  return(list(statistic = lr,
              decision = decision,
              parameters = parameters,
              thresholds = thresholds))
}


print.sprt <- function(x){
  cat("    ", x$method, "\n")
  cat("\ndata:", x$data.name, "\n")
  cat(names(x$statistic), " = ", round(x$statistic, digits = 5), ", decision = ", x$decision, sep="")
  cat("\nSPRT thresholds:\n")
  print(round(x$thresholds, digits = 5))
  cat("alternative hypothesis: true", names(x$null.value), "is",
      ifelse(x$alternative=="two.sided", "not equal to", paste(x$alternative, "than")), x$null.value)
  cat("\neffect size: Cohen's d =", x$effect.size, "\n")
  print(x$parameters)
  cat("sample estimates:\n")
  print(round(x$estimate, digits = 5))
}



sprt.t.test <- function(...) UseMethod(".sprt")
.sprt.result <- function(x, y, mu, d, alpha, power, type, alt){
  A <- power/alpha
  B <- (1 - power)/(1 - alpha)
  lr <- .sprt.lr(x, y, mu, d, type, alt)
  if(lr >= A){
    decision <- "accept H1"
  }else if(lr <= B){
    decision <- "accept H0"
  }else{
    decision <- "continue sampling"
  }
  attr(lr, "names") <- "likelihood ratio"
  parameters <- c(alpha, power)
  attr(parameters, "names") <- c("Type I error", "Power")
  thresholds <- c(B, A)
  attr(thresholds, "names") <- c("lower", "upper")
  return(list(statistic = lr,
              decision = decision,
              parameters = parameters,
              thresholds = thresholds))
}


print.sprt <- function(x){
  cat("    ", x$method, "\n")
  cat("\ndata:", x$data.name, "\n")
  cat(names(x$statistic), " = ", round(x$statistic, digits = 5), ", decision = ", x$decision, sep="")
  cat("\nSPRT thresholds:\n")
  print(round(x$thresholds, digits = 5))
  cat("alternative hypothesis: true", names(x$null.value), "is",
      ifelse(x$alternative=="two.sided", "not equal to", paste(x$alternative, "than")), x$null.value)
  cat("\neffect size: Cohen's d =", x$effect.size, "\n")
  print(x$parameters)
  cat("sample estimates:\n")
  print(round(x$estimate, digits = 5))
}



sprt.t.test <- function(...) UseMethod(".sprt")

# x <- rnorm(50)
# sprt.t.test(x, d = 0.3)
#-----------------------------------------------------------------


context("seq_ttest: test main function")

test_that("seq_ttest: comparison results with original script from m. schnuerch", {

  x <- rnorm(50)
  d <- 0.8
  results_original <- sprt.t.test(x = x, d = d, power = 0.8)
  results_sprtt <- seq_ttest(x, d = d, power = 0.8)
  expect_equal(results_sprtt@likelihood_ratio,
               results_original$statistic[[1]])
  expect_equal(results_sprtt@decision,
               results_original$decision)


  x <- rnorm(20)
  y <- as.factor(c(rep(1,10), rep(2,10)))
  d <- 0.95
  results_original <- sprt.t.test(x ~ y, d = d)
  results_sprtt <- seq_ttest(x ~ y, d = d)
  expect_equal(results_sprtt@likelihood_ratio,
               results_original$statistic[[1]])
  expect_equal(results_sprtt@decision,
               results_original$decision)
  # same data, but different input
  x_1 <- x[1:(length(x) * 0.5)]
  x_2 <- x[(length(x) * 0.5 + 1):length(x)]
  results_sprtt2 <- seq_ttest(x_1, x_2, d = d)
  expect_equal(results_sprtt@likelihood_ratio_log,
               results_sprtt2@likelihood_ratio_log)
  expect_equal(results_sprtt@decision,
              results_sprtt2@decision)

  x <- rnorm(20)
  y <- as.factor(c(rep(1,10), rep(2,10)))
  d <- 0.95
  results_numeric <- seq_ttest(x, d = d)
  results_formula <- seq_ttest(x ~ 1, d = d)
  expect_equal(results_formula@likelihood_ratio,
               results_numeric@likelihood_ratio)
  expect_equal(results_sprtt@decision,
               results_original$decision)

  x_1 <- rnorm(5)
  x_2 <- rnorm(5)
  x <- c(x_1, x_2)
  y <- as.factor(c(rep(1,5),rep(2,5)))
  results_original <- sprt.t.test(x ~ y, d = d)
  results_sprtt <- seq_ttest(x ~ y, d = d)
  expect_equal(results_sprtt@likelihood_ratio,
               results_original$statistic[[1]])
  expect_equal(results_sprtt@decision,
               results_original$decision)


  x_1 <- rnorm(10)
  x_2 <- rnorm(10)
  x <- c(x_1, x_2)
  y <- as.factor(c(rep(1,10),rep(2,10)))
  results_original <- sprt.t.test(x_1, x_2, d = d)
  results_sprtt <- seq_ttest(x_1, x_2, d = d)
  expect_equal(results_sprtt@likelihood_ratio,
               results_original$statistic[[1]])
  expect_equal(results_sprtt@decision,
               results_original$decision)
  # same data, but different input
  results_sprtt <- seq_ttest(x_1, x_2, d = 0.5, paired = TRUE)
  results_sprtt2 <- seq_ttest(x ~ y, d = 0.5, paired = TRUE)
  expect_equal(results_sprtt@likelihood_ratio_log,
               results_sprtt2@likelihood_ratio_log)
  expect_equal(results_sprtt@decision,
               results_sprtt2@decision)

  d <- 0.7
  x <- rnorm(30)
  y <- rnorm(30)
  paired = TRUE
  t_test <- t.test(x, y, paired = paired)
  results_original <- sprt.t.test(x, y, d = d, paired = paired, alt = "two.sided")
  results_sprtt <- seq_ttest(x, y, d = d, paired = paired, alt = "two.sided")
  expect_equal(results_sprtt@likelihood_ratio,
               results_original$statistic[[1]])
  expect_equal(results_sprtt@decision,
               results_original$decision)

  results_original <- sprt.t.test(x, y, d = d, paired = paired, alt = "less")
  results_sprtt <- seq_ttest(x, y, d = d, paired = paired, alt = "less")
  expect_equal(results_sprtt@likelihood_ratio,
               results_original$statistic[[1]])
  expect_equal(results_sprtt@decision,
               results_original$decision)

  results_original <- sprt.t.test(x, y, d = d, paired = paired, alt = "greater")
  results_sprtt <- seq_ttest(x, y, d = d, paired = paired, alt = "greater")
  expect_equal(results_sprtt@likelihood_ratio,
               results_original$statistic[[1]])
  expect_equal(results_sprtt@decision,
               results_original$decision)

})


# test_that("", {
#
#
# })

