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
       log-likelihood ratio = 25.766, decision = accept H1
      SPRT thresholds:
       lower log(B) = -2.944, upper log(A) = 2.944
      Log-Likelihood of the:
       alternative hypothesis = -15.634
       null hypothesis = -41.399
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's f = 0.25
      empirical Cohen's f = 0.5684415, 95% CI[0.4381841, 0.6727351]
      Cohen's f adjusted = 0.551
      degrees of freedom: df1 = 4, df2 = 325
      SS effect = 101.4047, SS residual = 313.8243, SS total = 415.229
      *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      show(seq_anova(happiness ~ job_satisfaction, f = 0.25, data = df_job))
    Output
      
      *****  Sequential ANOVA *****
      
      formula: happiness ~ job_satisfaction
      test statistic:
       log-likelihood ratio = 6.301, decision = accept H1
      SPRT thresholds:
       lower log(B) = -2.944, upper log(A) = 2.944
      Log-Likelihood of the:
       alternative hypothesis = -11.577
       null hypothesis = -17.878
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's f = 0.25
      empirical Cohen's f = 0.9490388, 95% CI[0.5851251, 1.265912]
      Cohen's f adjusted = 0.897
      degrees of freedom: df1 = 1, df2 = 46
      SS effect = 38.46891, SS residual = 42.71121, SS total = 81.18012
      *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      show(seq_anova(y ~ x, f = 0.1, data = data))
    Output
      
      *****  Sequential ANOVA *****
      
      formula: y ~ x
      test statistic:
       log-likelihood ratio = 0.301, decision = continue sampling
      SPRT thresholds:
       lower log(B) = -2.944, upper log(A) = 2.944
      Log-Likelihood of the:
       alternative hypothesis = -1.701
       null hypothesis = -2.003
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's f = 0.1
      empirical Cohen's f = 0.2860107, 95% CI[NA, 0.4669503]
      Cohen's f adjusted = 0.195
      degrees of freedom: df1 = 3, df2 = 76
      SS effect = 8.419127, SS residual = 102.9206, SS total = 111.3398
      *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      show(seq_anova(y ~ x, f = 0.25, alpha = 0.3, power = 0.95, data = data))
    Output
      
      *****  Sequential ANOVA *****
      
      formula: y ~ x
      test statistic:
       log-likelihood ratio = 12.131, decision = accept H1
      SPRT thresholds:
       lower log(B) = -2.639, upper log(A) = 1.153
      Log-Likelihood of the:
       alternative hypothesis = -11.005
       null hypothesis = -23.137
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's f = 0.25
      empirical Cohen's f = 0.6372944, 95% CI[0.4346269, 0.8270501]
      Cohen's f adjusted = 0.62
      degrees of freedom: df1 = 1, df2 = 118
      SS effect = 53.44752, SS residual = 131.5974, SS total = 185.0449
      *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      show(seq_anova(y ~ x, f = 0.25, data = data, verbose = FALSE))
    Output
      
      *****  Sequential ANOVA *****
      
      formula: y ~ x
      test statistic:
       log-likelihood ratio = 14.19, decision = accept H1
      SPRT thresholds:
       lower log(B) = -2.944, upper log(A) = 2.944

