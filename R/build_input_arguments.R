build_input_arguments <-  function(input1,
                                   y = NULL,
                                   data = NULL,
                                   mu,
                                   d,
                                   alpha,
                                   power,
                                   alternative,
                                   paired) {
  # formula input ----
  if (class(input1) == "formula")
  {
    formula = input1
    formula_list <- as.list(formula)

    if ((length(formula) != 3L) || (length(formula[[3]]) != 1L))
      stop("'formula' is incorrect. Please specify as 'x~y'.")

    if (!is.null(data)) {
      temp <- model.frame(formula, data)
      x <- temp[, 1]

      if (formula_list[[3]] == 1) {
        y = 1
      } else {
        y <- temp[, 2]
      }
    }

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

  }#ENDif_formula

  # x, y input ----
  if (class(input1) != "formula")
  {
    x <- input1
  }

  if(!is.null(y)){whichNA <- is.na(x) | is.na(y)
  x <- x[!whichNA]
  y <- y[!whichNA]
  }else {
    x <- na.omit(x)
    }


  if (is.null(y) || (y == 1)) {
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
