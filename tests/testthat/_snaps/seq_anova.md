# seq_anova: snapshots

    Code
      seq_anova(y ~ x, f = 0.4, data = data)
    Output
      
      *****  Sequential ANOVA *****
      
      formula: y ~ x
      test statistic:
       log-likelihood ratio = 21.049, decision = accept H1
      SPRT thresholds:
       lower log(B) = -2.944, upper log(A) = 2.944
      Log-Likelihood of the:
       alternative hypothesis = -9.891
       null hypothesis = -30.94
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's f = 0.4
      empirical Cohen's f = 0.7845869, 95% CI[0.5717185, 0.9534814]
      Cohen's f adjusted = 0.754
      degrees of freedom: df1 = 3, df2 = 136
      SS effect = 726.7487, SS residual = 1180.598, SS total = 1907.347
      *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      seq_anova(age ~ sex, f = 0.4, data = df_age)
    Output
      
      *****  Sequential ANOVA *****
      
      formula: age ~ sex
      test statistic:
       log-likelihood ratio = 14.492, decision = accept H1
      SPRT thresholds:
       lower log(B) = -2.944, upper log(A) = 2.944
      Log-Likelihood of the:
       alternative hypothesis = -4.201
       null hypothesis = -18.693
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's f = 0.4
      empirical Cohen's f = 0.5908057, 95% CI[0.386451, 0.75029]
      Cohen's f adjusted = 0.559
      degrees of freedom: df1 = 3, df2 = 136
      SS effect = 447.3363, SS residual = 1281.577, SS total = 1728.914
      *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

