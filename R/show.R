setMethod("show",
          signature = "seq_ttest_results",
          function(object){
            cat("    ", "Sequential", object@ttest_method, "\n")
            cat("\ndata:", object@data_name)
            cat("\ntest statistic:\n")
            cat(" likelihood ratio", " = ", round(object@likelihood_ratio, digits = 5),
                ", decision = ", object@decision, sep = "")

            cat("\nSPRT thresholds:\n")
            cat(paste(" lower (B) =", round(object@B_boundary, digits = 5),
                      "upper (A) =", round(object@A_boundary, digits = 5)))

            cat("\nLikelihood of the:")
            cat("\n alternative hypothesis =", round(object@likelihood_1, 5))
            cat("\n null hypothesis =", round(object@likelihood_2, 5))

            cat("\n alternative hypothesis: true",
                if(object@one_sample == TRUE){
                  if(object@alternative == "two.sided"){
                    paste("mean is not equal to", object@mu, ".")
                  } else{
                    paste("mean is",object@alternative , "than", object@mu, ".")
                  }
                } else{
                  if(object@alternative == "two.sided"){
                    paste("difference in means is not equal to 0.")
                  } else{
                    paste("difference in means is", object@alternative, "than 0.")
                  }
                })

            cat("\nspecified effect size: Cohen's d =", object@d)
            cat("\ndegrees of freedome: df =", object@df)
            cat("\nsample estimates:")
            cat("\n mean of group one =", round(object@mean_x, 5))
            if(!is.null(object@mean_y)) {
              cat("\n mean of group two =", round(object@mean_y, 5))
              }
          })

