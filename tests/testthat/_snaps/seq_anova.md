# seq_anova: snapshots

    Code
      seq_anova(y ~ x, f = 0.4, data = data)
    Output
      
      *****  Sequential ANOVA *****
      
      formula: y ~ x
      test statistic:
       log-likelihood ratio = 8.483, decision = accept H1
      SPRT thresholds:
       lower log(B) = -2.944, upper log(A) = 2.944
      Log-Likelihood of the:
       alternative hypothesis = -2.219
       null hypothesis = -10.702
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's f = 0.4
      empirical Cohen's f = 0.444537, 95% CI[0.2414272, 0.5972637]
      Cohen's f adjusted = 0.41
      degrees of freedom: df1 = 3, df2 = 136
      SS effect = 233.3018, SS residual = 1180.598, SS total = 1413.9
      *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      seq_anova(age ~ sex, f = 0.4, data = df_age)
    Output
      
      *****  Sequential ANOVA *****
      
      formula: age ~ sex
      test statistic:
       log-likelihood ratio = 3.114, decision = accept H1
      SPRT thresholds:
       lower log(B) = -2.944, upper log(A) = 2.944
      Log-Likelihood of the:
       alternative hypothesis = -2.466
       null hypothesis = -5.58
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's f = 0.4
      empirical Cohen's f = 0.3281472, 95% CI[0.1159147, 0.474829]
      Cohen's f adjusted = 0.286
      degrees of freedom: df1 = 3, df2 = 136
      SS effect = 138.001, SS residual = 1281.577, SS total = 1419.578
      *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

