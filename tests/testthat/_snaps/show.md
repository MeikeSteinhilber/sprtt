# show: print output ttest?

    Code
      show(seq_ttest(rnorm(20), d = 0.8))
    Output
      
      *****  Sequential One Sample t-test *****
      
      formula: rnorm(20)
      test statistic:
       log-likelihood ratio = -5.783, decision = accept H0
      SPRT thresholds:
       lower log(B) = -2.944, upper log(A) = 2.944
      Log-Likelihood of the:
       alternative hypothesis = -5.676
       null hypothesis = 0.107
      alternative hypothesis: true mean is not equal to 0.
      specified effect size: Cohen's d = 0.8
      degrees of freedom: df = 19
      sample estimates:
      mean of x 
        0.05238 
      *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      show(seq_ttest(x_special_name, d = 0.8, alternative = "less", mu = 2))
    Output
      
      *****  Sequential One Sample t-test *****
      
      formula: x_special_name
      test statistic:
       log-likelihood ratio = 12.358, decision = accept H1
      SPRT thresholds:
       lower log(B) = -2.944, upper log(A) = 2.944
      Log-Likelihood of the:
       alternative hypothesis = -17.916
       null hypothesis = -30.275
      alternative hypothesis: true mean is less than 2.
      specified effect size: Cohen's d = 0.8
      degrees of freedom: df = 19
      sample estimates:
      mean of x 
       -0.50342 
      *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      show(seq_ttest(x, d = 0.8, alternative = "greater"))
    Output
      
      *****  Sequential One Sample t-test *****
      
      formula: x
      test statistic:
       log-likelihood ratio = -9.385, decision = accept H0
      SPRT thresholds:
       lower log(B) = -2.944, upper log(A) = 2.944
      Log-Likelihood of the:
       alternative hypothesis = -10.711
       null hypothesis = -1.326
      alternative hypothesis: true mean is greater than 0.
      specified effect size: Cohen's d = 0.8
      degrees of freedom: df = 19
      sample estimates:
      mean of x 
       -0.20286 
      *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      show(seq_ttest(x_special_name, y_secial_name, d = 0.8))
    Output
      
      *****  Sequential  Two Sample t-test *****
      
      formula: x_special_name and  y_secial_name
      test statistic:
       log-likelihood ratio = -3.2, decision = accept H0
      SPRT thresholds:
       lower log(B) = -2.944, upper log(A) = 2.944
      Log-Likelihood of the:
       alternative hypothesis = 3.455
       null hypothesis = 6.655
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's d = 0.8
      degrees of freedom: df = 38
      sample estimates:
      mean of x mean of y 
        0.14016   0.13999 
      *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      show(seq_ttest(x, y, d = 0.8, alternative = "less"))
    Output
      
      *****  Sequential  Two Sample t-test *****
      
      formula: x and  y
      test statistic:
       log-likelihood ratio = -5.225, decision = accept H0
      SPRT thresholds:
       lower log(B) = -2.944, upper log(A) = 2.944
      Log-Likelihood of the:
       alternative hypothesis = -6.486
       null hypothesis = -1.261
      alternative hypothesis: true difference in means is less than 0.
      specified effect size: Cohen's d = 0.8
      degrees of freedom: df = 38
      sample estimates:
      mean of x mean of y 
        0.11723  -0.14143 
      *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      show(seq_ttest(x ~ y, d = 0.8))
    Output
      
      *****  Sequential  Two Sample t-test *****
      
      formula: x ~ y
      test statistic:
       log-likelihood ratio = -1.596, decision = continue sampling
      SPRT thresholds:
       lower log(B) = -2.944, upper log(A) = 2.944
      Log-Likelihood of the:
       alternative hypothesis = 0.499
       null hypothesis = 2.095
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's d = 0.8
      degrees of freedom: df = 18
      sample estimates:
      mean of x mean of y 
        0.18073   0.16120 
      *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

# show: verbose

    Code
      show(calc_seq_ttest(build_prototype_seq_ttest_arguments()))
    Output
      
      *****  Sequential  Two Sample t-test *****
      
      formula: x and y
      test statistic:
       log-likelihood ratio = 2.193, decision = continue sampling
      SPRT thresholds:
       lower log(B) = -1.558, upper log(A) = 2.773
      Log-Likelihood of the:
       alternative hypothesis = -3.201
       null hypothesis = -5.393
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's d = 0.8
      degrees of freedom: df = 18
      sample estimates:
      mean of x mean of y 
       -0.13828   1.05060 
      *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      show(calc_seq_ttest(build_prototype_seq_ttest_arguments(), verbose = FALSE))
    Output
      
      *****  Sequential  Two Sample t-test *****
      
      formula: x and y
      test statistic:
       log-likelihood ratio = 2.193, decision = continue sampling
      SPRT thresholds:
       lower log(B) = -1.558, upper log(A) = 2.773

# show: print output anova?

    Code
      show(seq_anova(y ~ x, f = 0.25, data = data))
    Output
      
      *****  Sequential ANOVA *****
      
      formula: y ~ x
      test statistic:
       log-likelihood ratio = 5.579, decision = accept H1
      SPRT thresholds:
       lower log(B) = -2.944, upper log(A) = 2.944
      Log-Likelihood of the:
       alternative hypothesis = -1.768
       null hypothesis = -7.348
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's f = 0.25
      empirical Cohen's f = 0.255582, 95% CI[0.1175887, 0.3478401]
      Cohen's f adjusted = 0.228
      degrees of freedom: df1 = 4, df2 = 325
      SS effect = 20.49968, SS residual = 313.8243, SS total = 334.324
      *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      show(seq_anova(happiness ~ job_satisfaction, f = 0.25, data = df_job))
    Output
      
      *****  Sequential ANOVA *****
      
      formula: happiness ~ job_satisfaction
      test statistic:
       log-likelihood ratio = 4.66, decision = accept H1
      SPRT thresholds:
       lower log(B) = -2.944, upper log(A) = 2.944
      Log-Likelihood of the:
       alternative hypothesis = -6.628
       null hypothesis = -11.288
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's f = 0.25
      empirical Cohen's f = 0.6758475, 95% CI[0.3452897, 0.9720489]
      Cohen's f adjusted = 0.631
      degrees of freedom: df1 = 1, df2 = 46
      SS effect = 19.50919, SS residual = 42.71121, SS total = 62.2204
      *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      show(seq_anova(y ~ x, f = 0.1, data = data))
    Output
      
      *****  Sequential ANOVA *****
      
      formula: y ~ x
      test statistic:
       log-likelihood ratio = -0.036, decision = continue sampling
      SPRT thresholds:
       lower log(B) = -2.944, upper log(A) = 2.944
      Log-Likelihood of the:
       alternative hypothesis = -0.799
       null hypothesis = -0.763
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's f = 0.1
      empirical Cohen's f = 0.1958652, 95% CI[NA, 0.3634934]
      Cohen's f adjusted = 0
      degrees of freedom: df1 = 3, df2 = 76
      SS effect = 3.948363, SS residual = 102.9206, SS total = 106.869
      *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      show(seq_anova(y ~ x, f = 0.25, alpha = 0.3, power = 0.95, data = data))
    Output
      
      *****  Sequential ANOVA *****
      
      formula: y ~ x
      test statistic:
       log-likelihood ratio = 7.792, decision = accept H1
      SPRT thresholds:
       lower log(B) = -2.639, upper log(A) = 1.153
      Log-Likelihood of the:
       alternative hypothesis = -5.07
       null hypothesis = -12.862
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's f = 0.25
      empirical Cohen's f = 0.4366689, 95% CI[0.2449371, 0.6194111]
      Cohen's f adjusted = 0.42
      degrees of freedom: df1 = 1, df2 = 118
      SS effect = 25.09296, SS residual = 131.5974, SS total = 156.6904
      *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      show(seq_anova(y ~ x, f = 0.25, data = data, verbose = FALSE))
    Output
      
      *****  Sequential ANOVA *****
      
      formula: y ~ x
      test statistic:
       log-likelihood ratio = 10.2, decision = accept H1
      SPRT thresholds:
       lower log(B) = -2.944, upper log(A) = 2.944

