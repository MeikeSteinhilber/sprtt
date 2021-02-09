setGeneric("check_data",
           function(input1, x, y, paired)
             standardGeneric("check_data")) #the same name necessary

setMethod("check_data",
          signature(input1 = "numeric"),
          function(input1, x, y, paired) {

            check_constant_data(x, y, paired)

            if (!is.null(y)) {
              x.name <- deparse(substitute(x))
              y.name <- deparse(substitute(y))
              data.name <- paste(x.name, "and", y.name)
              if (!(is.atomic(x) && is.null(dim(x))))
                warning(paste(x.name, "is not a vector. This might have caused problems."),
                        call. = F)
              if (!(is.atomic(y) && is.null(dim(y))))
                warning(paste(y.name, "is not a vector. This might have caused problems."),
                        call. = F)
              if (is.factor(y))
                stop("Is y a grouping factor? Use formula interface x ~ y.")
              if (!is.numeric(x))
                stop(paste("Invalid argument:",  x.name, "must be numeric."))
              if (!is.numeric(y))
                stop(paste("Invalid argument:",  y.name, "must be numeric."))
              if (!paired && (length(x) + length(y) < 3))
                stop("SPRT for two independent samples requires at least 3 observations.")
              if (!is.logical(paired))
                stop("Invalid argument <paired>: Must be logical.")

            }else{
              data.name <- deparse(substitute(x))
              if (!is.numeric(x))
                stop(paste("Invalid argument:",  data.name, "must be numeric."))
            }
          })

setMethod("check_data",
          signature(input1 = "formula"),
          function(input1, x, y, paired) {

            check_constant_data(x, y, paired)

            if (length(unique(y)) != 2 && (length(y) != 1))
              stop(paste("Grouping factor must contain exactly two levels."))
            if (paired) {
              if (!(table(y)[[1]] == table(y)[[2]]))
                stop("Unequal number of observations per group. Independent samples?")
            } else{
              if (length(x) < 3)
                stop("SPRT for two independent samples requires at least 3 observations.")
            }
          })
