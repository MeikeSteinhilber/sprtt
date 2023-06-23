# snaphot: effect_size

    Code
      effect_sizes(formula, df_no_effect)
    Output
      $cohens_f
      [1] 0.02783414
      
      $ci_cohens_f_lower
      [1] NA
      
      $ci_cohens_f_upper
      [1] 0.04623125
      
      $cohens_f_adj
      [1] 0.01997895
      
      $cohens_f_median
      [1] 0.02269439
      
      $eta_squared
      [1] 0.0007741396
      
      $partial_eta_squared
      [1] 0.0007741396
      
      $adjusted_eta_squared
      [1] 0.0003992425
      
      $ci_ncp_lower
      [1] NA
      
      $ci_ncp_upper
      [1] 17.09863
      

---

    Code
      effect_sizes(formula, df_no_effect_extreme)
    Output
      $cohens_f
      [1] 0.007884077
      
      $ci_cohens_f_lower
      [1] NA
      
      $ci_cohens_f_upper
      [1] 0.01359347
      
      $cohens_f_adj
      [1] 0.00496528
      
      $cohens_f_median
      [1] 0.005989646
      
      $eta_squared
      [1] 6.215481e-05
      
      $partial_eta_squared
      [1] 6.215481e-05
      
      $adjusted_eta_squared
      [1] 2.465526e-05
      
      $ci_ncp_lower
      [1] NA
      
      $ci_ncp_upper
      [1] 14.7826
      

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
       log-likelihood ratio = -39375.2, decision = accept H0
      SPRT thresholds:
       lower log(B) = -2.944, upper log(A) = 2.944
      Log-Likelihood of the:
       alternative hypothesis = -39376.7
       null hypothesis = -1.505
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's f = 1
      empirical Cohen's f = 0.007884077, 95% CI[0, 0.01359347]
      Cohen's f adjusted = 0.005
      degrees of freedom: df1 = 3, df2 = 79996
      SS effect = 4.9679, SS residual = 79922.87, SS total = 79927.84
      *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      seq_anova(formula, 0.01, data = df_0.01_effect)
    Output
      
      *****  Sequential ANOVA *****
      
      formula: formula
      test statistic:
       log-likelihood ratio = -0.052, decision = continue sampling
      SPRT thresholds:
       lower log(B) = -2.944, upper log(A) = 2.944
      Log-Likelihood of the:
       alternative hypothesis = -0.412
       null hypothesis = -0.36
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's f = 0.01
      empirical Cohen's f = 0.02693014, 95% CI[NA, 0.05742471]
      Cohen's f adjusted = 0
      degrees of freedom: df1 = 3, df2 = 1996
      SS effect = 1.405763, SS residual = 1938.363, SS total = 1939.768
      *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      effect_sizes(formula, df_0.01_effect)
    Output
      $cohens_f
      [1] 0.02693014
      
      $ci_cohens_f_lower
      [1] NA
      
      $ci_cohens_f_upper
      [1] 0.05742471
      
      $cohens_f_adj
      [1] 0
      
      $cohens_f_median
      [1] 0
      
      $eta_squared
      [1] 0.0007247067
      
      $partial_eta_squared
      [1] 0.0007247067
      
      $adjusted_eta_squared
      [1] -0.00077721
      
      $ci_ncp_lower
      [1] NA
      
      $ci_ncp_upper
      [1] 6.595196
      

---

    Code
      effect_sizes(formula, df_0.10_effect)
    Output
      $cohens_f
      [1] 0.08548456
      
      $ci_cohens_f_lower
      [1] NA
      
      $ci_cohens_f_upper
      [1] 0.1432724
      
      $cohens_f_adj
      [1] 0.05918448
      
      $cohens_f_median
      [1] 0.06829665
      
      $eta_squared
      [1] 0.007254596
      
      $partial_eta_squared
      [1] 0.007254596
      
      $adjusted_eta_squared
      [1] 0.003513093
      
      $ci_ncp_lower
      [1] NA
      
      $ci_ncp_upper
      [1] 16.42159
      

---

    Code
      effect_sizes(formula, df_0.25_effect)
    Output
      $cohens_f
      [1] 0.3951891
      
      $ci_cohens_f_lower
      [1] 0.212692
      
      $ci_cohens_f_upper
      [1] 0.5496487
      
      $cohens_f_adj
      [1] 0.3709923
      
      $cohens_f_median
      [1] 0.3818288
      
      $eta_squared
      [1] 0.1350786
      
      $partial_eta_squared
      [1] 0.1350786
      
      $adjusted_eta_squared
      [1] 0.123311
      
      $ci_ncp_lower
      [1] 6.785684
      
      $ci_ncp_upper
      [1] 45.31705
      

---

    Code
      effect_sizes(formula, df_0.40_effect)
    Output
      $cohens_f
      [1] 0.5759504
      
      $ci_cohens_f_lower
      [1] 0.1342421
      
      $ci_cohens_f_upper
      [1] 0.7988566
      
      $cohens_f_adj
      [1] 0.4530764
      
      $cohens_f_median
      [1] 0.4838036
      
      $eta_squared
      [1] 0.2490908
      
      $partial_eta_squared
      [1] 0.2490908
      
      $adjusted_eta_squared
      [1] 0.1823433
      
      $ci_ncp_lower
      [1] 0.9010465
      
      $ci_ncp_upper
      [1] 31.90859
      

---

    Code
      effect_sizes(formula, df_2_effect)
    Output
      $cohens_f
      [1] 1.710485
      
      $ci_cohens_f_lower
      [1] 0.928781
      
      $ci_cohens_f_upper
      [1] 2.297912
      
      $cohens_f_adj
      [1] 1.513475
      
      $cohens_f_median
      [1] 1.595753
      
      $eta_squared
      [1] 0.7452722
      
      $partial_eta_squared
      [1] 0.7452722
      
      $adjusted_eta_squared
      [1] 0.7311207
      
      $ci_ncp_lower
      [1] 17.25268
      
      $ci_ncp_upper
      [1] 105.608
      

---

    Code
      effect_sizes(formula, df_no_effect)
    Output
      $cohens_f
      [1] 0.02783414
      
      $ci_cohens_f_lower
      [1] NA
      
      $ci_cohens_f_upper
      [1] 0.04623125
      
      $cohens_f_adj
      [1] 0.01997895
      
      $cohens_f_median
      [1] 0.02269439
      
      $eta_squared
      [1] 0.0007741396
      
      $partial_eta_squared
      [1] 0.0007741396
      
      $adjusted_eta_squared
      [1] 0.0003992425
      
      $ci_ncp_lower
      [1] NA
      
      $ci_ncp_upper
      [1] 17.09863
      

---

    Code
      effect_sizes(formula, df_0.01_effect)
    Output
      $cohens_f
      [1] 0.02693014
      
      $ci_cohens_f_lower
      [1] NA
      
      $ci_cohens_f_upper
      [1] 0.05742471
      
      $cohens_f_adj
      [1] 0
      
      $cohens_f_median
      [1] 0
      
      $eta_squared
      [1] 0.0007247067
      
      $partial_eta_squared
      [1] 0.0007247067
      
      $adjusted_eta_squared
      [1] -0.00077721
      
      $ci_ncp_lower
      [1] NA
      
      $ci_ncp_upper
      [1] 6.595196
      

---

    Code
      effect_sizes(formula, df_0.10_effect)
    Output
      $cohens_f
      [1] 0.08548456
      
      $ci_cohens_f_lower
      [1] NA
      
      $ci_cohens_f_upper
      [1] 0.1432724
      
      $cohens_f_adj
      [1] 0.05918448
      
      $cohens_f_median
      [1] 0.06829665
      
      $eta_squared
      [1] 0.007254596
      
      $partial_eta_squared
      [1] 0.007254596
      
      $adjusted_eta_squared
      [1] 0.003513093
      
      $ci_ncp_lower
      [1] NA
      
      $ci_ncp_upper
      [1] 16.42159
      

---

    Code
      effect_sizes(formula, df_0.25_effect)
    Output
      $cohens_f
      [1] 0.3951891
      
      $ci_cohens_f_lower
      [1] 0.212692
      
      $ci_cohens_f_upper
      [1] 0.5496487
      
      $cohens_f_adj
      [1] 0.3709923
      
      $cohens_f_median
      [1] 0.3818288
      
      $eta_squared
      [1] 0.1350786
      
      $partial_eta_squared
      [1] 0.1350786
      
      $adjusted_eta_squared
      [1] 0.123311
      
      $ci_ncp_lower
      [1] 6.785684
      
      $ci_ncp_upper
      [1] 45.31705
      

---

    Code
      effect_sizes(formula, df_0.40_effect)
    Output
      $cohens_f
      [1] 0.5759504
      
      $ci_cohens_f_lower
      [1] 0.1342421
      
      $ci_cohens_f_upper
      [1] 0.7988566
      
      $cohens_f_adj
      [1] 0.4530764
      
      $cohens_f_median
      [1] 0.4838036
      
      $eta_squared
      [1] 0.2490908
      
      $partial_eta_squared
      [1] 0.2490908
      
      $adjusted_eta_squared
      [1] 0.1823433
      
      $ci_ncp_lower
      [1] 0.9010465
      
      $ci_ncp_upper
      [1] 31.90859
      

---

    Code
      effect_sizes(formula, df_2_effect)
    Output
      $cohens_f
      [1] 1.710485
      
      $ci_cohens_f_lower
      [1] 0.928781
      
      $ci_cohens_f_upper
      [1] 2.297912
      
      $cohens_f_adj
      [1] 1.513475
      
      $cohens_f_median
      [1] 1.595753
      
      $eta_squared
      [1] 0.7452722
      
      $partial_eta_squared
      [1] 0.7452722
      
      $adjusted_eta_squared
      [1] 0.7311207
      
      $ci_ncp_lower
      [1] 17.25268
      
      $ci_ncp_upper
      [1] 105.608
      

