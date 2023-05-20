# snaphot: effect_size

    Code
      effect_sizes(formula, df_no_effect)
    Output
      $cohens_f
      [1] 0.09300713
      
      $ci_cohens_f_lower
      [1] NA
      
      $ci_cohens_f_upper
      [1] 0.2103107
      
      $cohens_f_adj
      [1] 0
      
      $cohens_f_median
      [1] 0
      
      $eta_squared
      [1] 0.008576139
      
      $partial_eta_squared
      [1] 0.008576139
      
      $adjusted_eta_squared
      [1] -0.03055901
      
      $ci_ncp_lower
      [1] NA
      
      $ci_ncp_upper
      [1] 3.538449
      

---

    Code
      effect_sizes(formula, df_no_effect_extreme)
    Output
      $cohens_f
      [1] 0.01091243
      
      $ci_cohens_f_lower
      [1] 0.0008463532
      
      $ci_cohens_f_upper
      [1] 0.01691753
      
      $cohens_f_adj
      [1] 0.009031727
      
      $cohens_f_median
      [1] 0.009671856
      
      $eta_squared
      [1] 0.0001190669
      
      $partial_eta_squared
      [1] 0.0001190669
      
      $adjusted_eta_squared
      [1] 8.156944e-05
      
      $ci_ncp_lower
      [1] 0.0573051
      
      $ci_ncp_upper
      [1] 22.89622
      

---

    Code
      seq_anova(formula, 1, data = df_no_effect_extreme)
    Warning <simpleWarning>
      At least one likelihood is equal to 0.
                  The test works with the logarithm of the likelihoods.
    Output
      
      *****  Sequential ANOVA *****
      
      formula: formula
      test statistic:
       log-likelihood ratio = -39132.15, decision = accept H0
      SPRT thresholds:
       lower log(B) = -2.944, upper log(A) = 2.944
      Log-Likelihood of the:
       alternative hypothesis = -39135.61
       null hypothesis = -3.456
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's f = 1
      empirical Cohen's f = 0.01091243, 95% CI[0.0008463532, 0.01691753]
      Cohen's f adjusted = 0.009
      degrees of freedom: df1 = 3, df2 = 79996
      SS effect = 9.516819, SS residual = 79918.85, SS total = 79928.37
      *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      seq_anova(formula, 0.01, data = df_0.01_effect)
    Output
      
      *****  Sequential ANOVA *****
      
      formula: formula
      test statistic:
       log-likelihood ratio = 0.14, decision = continue sampling
      SPRT thresholds:
       lower log(B) = -2.944, upper log(A) = 2.944
      Log-Likelihood of the:
       alternative hypothesis = -2.444
       null hypothesis = -2.583
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's f = 0.01
      empirical Cohen's f = 0.06150955, 95% CI[NA, 0.09885597]
      Cohen's f adjusted = 0.048
      degrees of freedom: df1 = 3, df2 = 1996
      SS effect = 7.615723, SS residual = 2012.918, SS total = 2020.533
      *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      effect_sizes(formula, df_0.01_effect)
    Output
      $cohens_f
      [1] 0.06150955
      
      $ci_cohens_f_lower
      [1] NA
      
      $ci_cohens_f_upper
      [1] 0.09885597
      
      $cohens_f_adj
      [1] 0.04766629
      
      $cohens_f_median
      [1] 0.05240646
      
      $eta_squared
      [1] 0.003769165
      
      $partial_eta_squared
      [1] 0.003769165
      
      $adjusted_eta_squared
      [1] 0.002271824
      
      $ci_ncp_lower
      [1] NA
      
      $ci_ncp_upper
      [1] 19.54501
      

---

    Code
      effect_sizes(formula, df_0.10_effect)
    Output
      $cohens_f
      [1] 0.1664511
      
      $ci_cohens_f_lower
      [1] 0.08575547
      
      $ci_cohens_f_upper
      [1] 0.2293562
      
      $cohens_f_adj
      [1] 0.1541045
      
      $cohens_f_median
      [1] 0.1582059
      
      $eta_squared
      [1] 0.02695905
      
      $partial_eta_squared
      [1] 0.02695905
      
      $adjusted_eta_squared
      [1] 0.02329181
      
      $ci_ncp_lower
      [1] 5.883201
      
      $ci_ncp_upper
      [1] 42.0834
      

---

    Code
      effect_sizes(formula, df_0.25_effect)
    Output
      $cohens_f
      [1] 0.3519056
      
      $ci_cohens_f_lower
      [1] 0.1689627
      
      $ci_cohens_f_upper
      [1] 0.5048459
      
      $cohens_f_adj
      [1] 0.3261538
      
      $cohens_f_median
      [1] 0.3379362
      
      $eta_squared
      [1] 0.1101917
      
      $partial_eta_squared
      [1] 0.1101917
      
      $adjusted_eta_squared
      [1] 0.09808547
      
      $ci_ncp_lower
      [1] 4.282261
      
      $ci_ncp_upper
      [1] 38.23041
      

---

    Code
      effect_sizes(formula, df_0.40_effect)
    Output
      $cohens_f
      [1] 0.9936748
      
      $ci_cohens_f_lower
      [1] 0.5563773
      
      $ci_cohens_f_upper
      [1] 1.251326
      
      $cohens_f_adj
      [1] 0.8770148
      
      $cohens_f_median
      [1] 0.9040573
      
      $eta_squared
      [1] 0.4968274
      
      $partial_eta_squared
      [1] 0.4968274
      
      $adjusted_eta_squared
      [1] 0.4521009
      
      $ci_ncp_lower
      [1] 15.47779
      
      $ci_ncp_upper
      [1] 78.29081
      

---

    Code
      effect_sizes(formula, df_2_effect)
    Output
      $cohens_f
      [1] 3.436175
      
      $ci_cohens_f_lower
      [1] 2.109823
      
      $ci_cohens_f_upper
      [1] 4.395641
      
      $cohens_f_adj
      [1] 3.065263
      
      $cohens_f_median
      [1] 3.201591
      
      $eta_squared
      [1] 0.9219195
      
      $partial_eta_squared
      [1] 0.9219195
      
      $adjusted_eta_squared
      [1] 0.9175817
      
      $ci_ncp_lower
      [1] 89.02703
      
      $ci_ncp_upper
      [1] 386.4332
      

---

    Code
      effect_sizes(formula, df_no_effect)
    Output
      $cohens_f
      [1] 0.09300713
      
      $ci_cohens_f_lower
      [1] NA
      
      $ci_cohens_f_upper
      [1] 0.2103107
      
      $cohens_f_adj
      [1] 0
      
      $cohens_f_median
      [1] 0
      
      $eta_squared
      [1] 0.008576139
      
      $partial_eta_squared
      [1] 0.008576139
      
      $adjusted_eta_squared
      [1] -0.03055901
      
      $ci_ncp_lower
      [1] NA
      
      $ci_ncp_upper
      [1] 3.538449
      

---

    Code
      effect_sizes(formula, df_0.01_effect)
    Output
      $cohens_f
      [1] 0.06150955
      
      $ci_cohens_f_lower
      [1] NA
      
      $ci_cohens_f_upper
      [1] 0.09885597
      
      $cohens_f_adj
      [1] 0.04766629
      
      $cohens_f_median
      [1] 0.05240646
      
      $eta_squared
      [1] 0.003769165
      
      $partial_eta_squared
      [1] 0.003769165
      
      $adjusted_eta_squared
      [1] 0.002271824
      
      $ci_ncp_lower
      [1] NA
      
      $ci_ncp_upper
      [1] 19.54501
      

---

    Code
      effect_sizes(formula, df_0.10_effect)
    Output
      $cohens_f
      [1] 0.1664511
      
      $ci_cohens_f_lower
      [1] 0.08575547
      
      $ci_cohens_f_upper
      [1] 0.2293562
      
      $cohens_f_adj
      [1] 0.1541045
      
      $cohens_f_median
      [1] 0.1582059
      
      $eta_squared
      [1] 0.02695905
      
      $partial_eta_squared
      [1] 0.02695905
      
      $adjusted_eta_squared
      [1] 0.02329181
      
      $ci_ncp_lower
      [1] 5.883201
      
      $ci_ncp_upper
      [1] 42.0834
      

---

    Code
      effect_sizes(formula, df_0.25_effect)
    Output
      $cohens_f
      [1] 0.3519056
      
      $ci_cohens_f_lower
      [1] 0.1689627
      
      $ci_cohens_f_upper
      [1] 0.5048459
      
      $cohens_f_adj
      [1] 0.3261538
      
      $cohens_f_median
      [1] 0.3379362
      
      $eta_squared
      [1] 0.1101917
      
      $partial_eta_squared
      [1] 0.1101917
      
      $adjusted_eta_squared
      [1] 0.09808547
      
      $ci_ncp_lower
      [1] 4.282261
      
      $ci_ncp_upper
      [1] 38.23041
      

---

    Code
      effect_sizes(formula, df_0.40_effect)
    Output
      $cohens_f
      [1] 0.9936748
      
      $ci_cohens_f_lower
      [1] 0.5563773
      
      $ci_cohens_f_upper
      [1] 1.251326
      
      $cohens_f_adj
      [1] 0.8770148
      
      $cohens_f_median
      [1] 0.9040573
      
      $eta_squared
      [1] 0.4968274
      
      $partial_eta_squared
      [1] 0.4968274
      
      $adjusted_eta_squared
      [1] 0.4521009
      
      $ci_ncp_lower
      [1] 15.47779
      
      $ci_ncp_upper
      [1] 78.29081
      

---

    Code
      effect_sizes(formula, df_2_effect)
    Output
      $cohens_f
      [1] 3.436175
      
      $ci_cohens_f_lower
      [1] 2.109823
      
      $ci_cohens_f_upper
      [1] 4.395641
      
      $cohens_f_adj
      [1] 3.065263
      
      $cohens_f_median
      [1] 3.201591
      
      $eta_squared
      [1] 0.9219195
      
      $partial_eta_squared
      [1] 0.9219195
      
      $adjusted_eta_squared
      [1] 0.9175817
      
      $ci_ncp_lower
      [1] 89.02703
      
      $ci_ncp_upper
      [1] 386.4332
      

