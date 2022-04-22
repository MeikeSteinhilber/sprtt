# t-Test -----------------------------------------------------------------------
setMethod(
  "show",
  signature = "seq_ttest_results",
  function(object){
    cat("\n*****  Sequential ", object@ttest_method, " *****\n", sep = "")
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

    if (object@verbose == TRUE) {
      cat("\nLog-Likelihood of the:")
      cat("\n alternative hypothesis =", round(object@likelihood_1_log, 5))
      cat("\n null hypothesis =", round(object@likelihood_0_log, 5))

      cat("\nalternative hypothesis: true",
          if (object@one_sample == TRUE) {
            if (object@alternative == "two.sided") {
              paste0("mean is not equal to ", object@mu, ".")
            } else{
              paste0("mean is ",object@alternative , " than ", object@mu, ".")
            }
          } else{
            if (object@alternative == "two.sided") {
              paste0("difference in means is not equal to ",object@mu, ".")
            } else{
              paste0("difference in means is ", object@alternative, " than ", object@mu, ".")
            }
          })

      cat("\nspecified effect size: Cohen's d =", object@d)
      cat("\ndegrees of freedom: df =", object@df)
      cat("\nsample estimates:\n")
      print(round(object@mean_estimate[[1]], 5))
      cat('Note: to get access to the object of the results use the @ or [] instead of the $ operator.\n')
    }
})

# ANOVA ------------------------------------------------------------------------
setMethod(
  "show",
  signature = "seq_anova_results",
  function(object){
    # cat("\n*****  Sequential ", object@anova_method, " *****\n", sep = "")
    cat("\n*****  Sequential ANOVA *****\n", sep = "")
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

    if (object@verbose == TRUE) {
      cat("\nLog-Likelihood of the:")
      cat("\n alternative hypothesis =", round(object@likelihood_1_log, 5))
      cat("\n null hypothesis =", round(object@likelihood_0_log, 5))

      cat("\nalternative hypothesis: true difference in means is not equal to 0.")

      cat("\nspecified effect size: Cohen's f =", object@f)
      cat("\ndegrees of freedom: df1 = ", object@df_1,
          ", df2 = ", object@df_2,
          sep = "")
      cat("\nSS effect = ", object@ss_effect,
          ", SS residual = ", object@ss_residual,
          sep = "")
      # cat("\nsample estimates:\n")
      # print(round(object@mean_estimate[[1]], 5))
      cat('\nNote: to get access to the object of the results use the @ or [] instead of the $ operator.\n')
    }
  })
