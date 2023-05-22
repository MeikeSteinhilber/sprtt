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
       log-likelihood ratio = -0.02, decision = continue sampling
      SPRT thresholds:
       lower log(B) = -2.944, upper log(A) = 2.944
      Log-Likelihood of the:
       alternative hypothesis = -0.618
       null hypothesis = -0.599
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's f = 0.01
      empirical Cohen's f = 0.03505691, 95% CI[NA, 0.06839278]
      Cohen's f adjusted = 0
      degrees of freedom: df1 = 3, df2 = 1996
      SS effect = 2.382222, SS residual = 1938.363, SS total = 1940.745
      *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      effect_sizes(formula, df_0.01_effect)
    Output
      $cohens_f
      [1] 0.03505691
      
      $ci_cohens_f_lower
      [1] NA
      
      $ci_cohens_f_upper
      [1] 0.06839278
      
      $cohens_f_adj
      [1] 0
      
      $cohens_f_median
      [1] 0.00736012
      
      $eta_squared
      [1] 0.001227478
      
      $partial_eta_squared
      [1] 0.001227478
      
      $adjusted_eta_squared
      [1] -0.0002736831
      
      $ci_ncp_lower
      [1] NA
      
      $ci_ncp_upper
      [1] 9.355144
      

---

    Code
      effect_sizes(formula, df_0.10_effect)
    Output
      $cohens_f
      [1] 0.1684673
      
      $ci_cohens_f_lower
      [1] 0.08794376
      
      $ci_cohens_f_upper
      [1] 0.231446
      
      $cohens_f_adj
      [1] 0.1562638
      
      $cohens_f_median
      [1] 0.1603155
      
      $eta_squared
      [1] 0.02759796
      
      $partial_eta_squared
      [1] 0.02759796
      
      $adjusted_eta_squared
      [1] 0.02393312
      
      $ci_ncp_lower
      [1] 6.187283
      
      $ci_ncp_upper
      [1] 42.8538
      

---

    Code
      effect_sizes(formula, df_0.25_effect)
    Output
      $cohens_f
      [1] 0.5876266
      
      $ci_cohens_f_lower
      [1] 0.4005198
      
      $ci_cohens_f_upper
      [1] 0.7491918
      
      $cohens_f_adj
      [1] 0.5660932
      
      $cohens_f_median
      [1] 0.5748888
      
      $eta_squared
      [1] 0.2566742
      
      $partial_eta_squared
      [1] 0.2566742
      
      $adjusted_eta_squared
      [1] 0.2465609
      
      $ci_ncp_lower
      [1] 24.06241
      
      $ci_ncp_upper
      [1] 84.19325
      

---

    Code
      effect_sizes(formula, df_0.40_effect)
    Output
      $cohens_f
      [1] 1.234514
      
      $ci_cohens_f_lower
      [1] 0.7656959
      
      $ci_cohens_f_upper
      [1] 1.513616
      
      $cohens_f_adj
      [1] 1.109352
      
      $cohens_f_median
      [1] 1.13752
      
      $eta_squared
      [1] 0.6038075
      
      $partial_eta_squared
      [1] 0.6038075
      
      $adjusted_eta_squared
      [1] 0.5685904
      
      $ci_ncp_lower
      [1] 29.31451
      
      $ci_ncp_upper
      [1] 114.5517
      

---

    Code
      effect_sizes(formula, df_2_effect)
    Output
      $cohens_f
      [1] 2.676148
      
      $ci_cohens_f_lower
      [1] 1.598912
      
      $ci_cohens_f_upper
      [1] 3.462505
      
      $cohens_f_adj
      [1] 2.383152
      
      $cohens_f_median
      [1] 2.494348
      
      $eta_squared
      [1] 0.8774775
      
      $partial_eta_squared
      [1] 0.8774775
      
      $adjusted_eta_squared
      [1] 0.8706707
      
      $ci_ncp_lower
      [1] 51.1304
      
      $ci_ncp_upper
      [1] 239.7788
      

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
      [1] 0.03505691
      
      $ci_cohens_f_lower
      [1] NA
      
      $ci_cohens_f_upper
      [1] 0.06839278
      
      $cohens_f_adj
      [1] 0
      
      $cohens_f_median
      [1] 0.00736012
      
      $eta_squared
      [1] 0.001227478
      
      $partial_eta_squared
      [1] 0.001227478
      
      $adjusted_eta_squared
      [1] -0.0002736831
      
      $ci_ncp_lower
      [1] NA
      
      $ci_ncp_upper
      [1] 9.355144
      

---

    Code
      effect_sizes(formula, df_0.10_effect)
    Output
      $cohens_f
      [1] 0.1684673
      
      $ci_cohens_f_lower
      [1] 0.08794376
      
      $ci_cohens_f_upper
      [1] 0.231446
      
      $cohens_f_adj
      [1] 0.1562638
      
      $cohens_f_median
      [1] 0.1603155
      
      $eta_squared
      [1] 0.02759796
      
      $partial_eta_squared
      [1] 0.02759796
      
      $adjusted_eta_squared
      [1] 0.02393312
      
      $ci_ncp_lower
      [1] 6.187283
      
      $ci_ncp_upper
      [1] 42.8538
      

---

    Code
      effect_sizes(formula, df_0.25_effect)
    Output
      $cohens_f
      [1] 0.5876266
      
      $ci_cohens_f_lower
      [1] 0.4005198
      
      $ci_cohens_f_upper
      [1] 0.7491918
      
      $cohens_f_adj
      [1] 0.5660932
      
      $cohens_f_median
      [1] 0.5748888
      
      $eta_squared
      [1] 0.2566742
      
      $partial_eta_squared
      [1] 0.2566742
      
      $adjusted_eta_squared
      [1] 0.2465609
      
      $ci_ncp_lower
      [1] 24.06241
      
      $ci_ncp_upper
      [1] 84.19325
      

---

    Code
      effect_sizes(formula, df_0.40_effect)
    Output
      $cohens_f
      [1] 1.234514
      
      $ci_cohens_f_lower
      [1] 0.7656959
      
      $ci_cohens_f_upper
      [1] 1.513616
      
      $cohens_f_adj
      [1] 1.109352
      
      $cohens_f_median
      [1] 1.13752
      
      $eta_squared
      [1] 0.6038075
      
      $partial_eta_squared
      [1] 0.6038075
      
      $adjusted_eta_squared
      [1] 0.5685904
      
      $ci_ncp_lower
      [1] 29.31451
      
      $ci_ncp_upper
      [1] 114.5517
      

---

    Code
      effect_sizes(formula, df_2_effect)
    Output
      $cohens_f
      [1] 2.676148
      
      $ci_cohens_f_lower
      [1] 1.598912
      
      $ci_cohens_f_upper
      [1] 3.462505
      
      $cohens_f_adj
      [1] 2.383152
      
      $cohens_f_median
      [1] 2.494348
      
      $eta_squared
      [1] 0.8774775
      
      $partial_eta_squared
      [1] 0.8774775
      
      $adjusted_eta_squared
      [1] 0.8706707
      
      $ci_ncp_lower
      [1] 51.1304
      
      $ci_ncp_upper
      [1] 239.7788
      

