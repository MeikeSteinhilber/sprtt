setMethod(
  "show",
  signature = "seq_ttest_results",
  function(object){
    cat("    ", "Sequential", object@ttest_method, "\n")
    cat("\ndata:", object@data_name)
    cat("\ntest statistic:\n")
    cat(" log-likelihood ratio",
        " = ",
        round(object@likelihood_ratio_log, digits = 5),
        ", decision = ",
        object@decision,
        sep = ""
        )

    cat("\nSPRT thresholds:\n")
    cat(" lower log(B) = ", round(object@B_boundary_log, digits = 5),
        ", ",
        "upper log(A) = ", round(object@A_boundary_log, digits = 5),
        sep = ""
        )

    cat("\nLog-Likelihood of the:")
    cat("\n alternative hypothesis =", round(object@likelihood_1_log, 5))
    cat("\n null hypothesis =", round(object@likelihood_2_log, 5))

    cat("\nalternative hypothesis: true",
        if (object@one_sample == TRUE) {
          if (object@alternative == "two.sided") {
            paste("mean is not equal to", object@mu, ".")
          } else{
            paste("mean is",object@alternative , "than", object@mu, ".")
          }
        } else{
          if (object@alternative == "two.sided") {
            paste("difference in means is not equal to 0.")
          } else{
            paste("difference in means is", object@alternative, "than 0.")
          }
        })

    cat("\nspecified effect size: Cohen's d =", object@d)
    cat("\ndegrees of freedome: df =", object@df)
    cat("\nsample estimates:")
    cat("\n mean of group one =", round(object@mean_x, 5))
    if (!is.null(object@mean_y)) {
      cat("\n mean of group two =", round(object@mean_y, 5))
    }
    cat('\nNote: to get access to the object of the results use the @ or [] instead of the $ operator.\n')
})

