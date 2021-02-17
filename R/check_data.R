check_data <- function(input1, x, y, paired) {

            x.name <- deparse(substitute(x))
            if (!is.numeric(x))
              stop(paste("Invalid argument:",  x.name, "must be numeric."))

            if (!is.null(y)) {
              y.name <- deparse(substitute(y))
              data.name <- paste(x.name, "and", y.name)
              # if (!(is.atomic(x) && is.null(dim(x)) ))
              #   warning(paste(x.name, "is not a vector. This might have caused problems."),
              #           call. = F)
              # if (!(is.atomic(y) && is.null(dim(y)) ))
              #   warning(paste(y.name, "is not a vector. This might have caused problems."),
              #           call. = F)
              if (is.factor(y))
                stop("Is y a grouping factor? Use formula interface x ~ y.")
              if (!is.numeric(y))
                stop(paste("Invalid argument:",  y.name, "must be numeric."))
              if (!paired && (length(x) + length(y) < 3))
                stop("SPRT for two independent samples requires at least 3 observations.")
              if (!is.logical(paired))
                stop("Invalid argument <paired>: Must be logical.")

            check_constant_data(x, y, paired)
          }}


