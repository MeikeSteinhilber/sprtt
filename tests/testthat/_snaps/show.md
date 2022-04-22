# show: print output ttest?

    Code
      show(seq_ttest(rnorm(20), d = 0.8))
    Output
      
      *****  Sequential One Sample t-test *****
      
      data: rnorm(20)
      test statistic:
       log-likelihood ratio = -5.78262, decision = accept H0
      SPRT thresholds:
       lower log(B) = -2.94444, upper log(A) = 2.94444
      Log-Likelihood of the:
       alternative hypothesis = -5.67562
       null hypothesis = 0.107
      alternative hypothesis: true mean is not equal to 0.
      specified effect size: Cohen's d = 0.8
      degrees of freedom: df = 19
      sample estimates:
      mean of x 
        0.05238 
      Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      show(seq_ttest(x_special_name, d = 0.8, alternative = "less", mu = 2))
    Output
      
      *****  Sequential One Sample t-test *****
      
      data: x_special_name
      test statistic:
       log-likelihood ratio = 12.35816, decision = accept H1
      SPRT thresholds:
       lower log(B) = -2.94444, upper log(A) = 2.94444
      Log-Likelihood of the:
       alternative hypothesis = -17.9164
       null hypothesis = -30.27455
      alternative hypothesis: true mean is less than 2.
      specified effect size: Cohen's d = 0.8
      degrees of freedom: df = 19
      sample estimates:
      mean of x 
       -0.50342 
      Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      show(seq_ttest(x, d = 0.8, alternative = "greater"))
    Output
      
      *****  Sequential One Sample t-test *****
      
      data: x
      test statistic:
       log-likelihood ratio = -9.38542, decision = accept H0
      SPRT thresholds:
       lower log(B) = -2.94444, upper log(A) = 2.94444
      Log-Likelihood of the:
       alternative hypothesis = -10.71105
       null hypothesis = -1.32563
      alternative hypothesis: true mean is greater than 0.
      specified effect size: Cohen's d = 0.8
      degrees of freedom: df = 19
      sample estimates:
      mean of x 
       -0.20286 
      Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      show(seq_ttest(x_special_name, y_secial_name, d = 0.8))
    Output
      
      *****  Sequential  Two Sample t-test *****
      
      data: x_special_name and  y_secial_name
      test statistic:
       log-likelihood ratio = -3.2, decision = accept H0
      SPRT thresholds:
       lower log(B) = -2.94444, upper log(A) = 2.94444
      Log-Likelihood of the:
       alternative hypothesis = 3.45532
       null hypothesis = 6.65532
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's d = 0.8
      degrees of freedom: df = 38
      sample estimates:
      mean of x mean of y 
        0.14016   0.13999 
      Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      show(seq_ttest(x, y, d = 0.8, alternative = "less"))
    Output
      
      *****  Sequential  Two Sample t-test *****
      
      data: x and  y
      test statistic:
       log-likelihood ratio = -5.22476, decision = accept H0
      SPRT thresholds:
       lower log(B) = -2.94444, upper log(A) = 2.94444
      Log-Likelihood of the:
       alternative hypothesis = -6.48626
       null hypothesis = -1.26149
      alternative hypothesis: true difference in means is less than 0.
      specified effect size: Cohen's d = 0.8
      degrees of freedom: df = 38
      sample estimates:
      mean of x mean of y 
        0.11723  -0.14143 
      Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      show(seq_ttest(x ~ y, d = 0.8))
    Output
      
      *****  Sequential  Two Sample t-test *****
      
      data: x ~ y
      test statistic:
       log-likelihood ratio = -1.59606, decision = continue sampling
      SPRT thresholds:
       lower log(B) = -2.94444, upper log(A) = 2.94444
      Log-Likelihood of the:
       alternative hypothesis = 0.4989
       null hypothesis = 2.09495
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's d = 0.8
      degrees of freedom: df = 18
      sample estimates:
      mean of x mean of y 
        0.18073   0.16120 
      Note: to get access to the object of the results use the @ or [] instead of the $ operator.

# show: verbose

    Code
      show(calc_seq_ttest(build_prototype_seq_ttest_arguments()))
    Output
      
      *****  Sequential  Two Sample t-test *****
      
      data: x and y
      test statistic:
       log-likelihood ratio = 2.19276, decision = continue sampling
      SPRT thresholds:
       lower log(B) = -1.55814, upper log(A) = 2.77259
      Log-Likelihood of the:
       alternative hypothesis = -3.20056
       null hypothesis = -5.39332
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's d = 0.8
      degrees of freedom: df = 18
      sample estimates:
      mean of x mean of y 
       -0.13828   1.05060 
      Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      show(calc_seq_ttest(build_prototype_seq_ttest_arguments(), verbose = FALSE))
    Output
      
      *****  Sequential  Two Sample t-test *****
      
      data: x and y
      test statistic:
       log-likelihood ratio = 2.19276, decision = continue sampling
      SPRT thresholds:
       lower log(B) = -1.55814, upper log(A) = 2.77259

# show: print output anova?

    Code
      show(seq_anova(y ~ x, f = 0.25, data = data))
    Output
      
      *****  Sequential ANOVA *****
      
      data: y ~ x
      test statistic:
       log-likelihood ratio = 6.35301, decision = accept H1
      SPRT thresholds:
       lower log(B) = -2.94444, upper log(A) = 2.94444
      Log-Likelihood of the:
       alternative hypothesis = -3.23291
       null hypothesis = -9.58592
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's f = 0.25
      degrees of freedom: df1 = 2, df2 = 147
      SS effect = 17.65564, SS residual = 128.5778
      Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      show(seq_anova(happiness ~ job_satisfaction, f = 0.25, data = data))
    Output
      
      *****  Sequential ANOVA *****
      
      data: happiness ~ job_satisfaction
      test statistic:
       log-likelihood ratio = -1.14021, decision = continue sampling
      SPRT thresholds:
       lower log(B) = -2.94444, upper log(A) = 2.94444
      Log-Likelihood of the:
       alternative hypothesis = -2.61739
       null hypothesis = -1.47718
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's f = 0.25
      degrees of freedom: df1 = 2, df2 = 147
      SS effect = 2.847138, SS residual = 142.1739
      Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      show(seq_anova(y ~ x, f = 0.1, data = data))
    Output
      
      *****  Sequential ANOVA *****
      
      data: y ~ x
      test statistic:
       log-likelihood ratio = 0.12262, decision = continue sampling
      SPRT thresholds:
       lower log(B) = -2.94444, upper log(A) = 2.94444
      Log-Likelihood of the:
       alternative hypothesis = -1.16688
       null hypothesis = -1.28951
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's f = 0.1
      degrees of freedom: df1 = 3, df2 = 76
      SS effect = 4.625079, SS residual = 80.04807
      Note: to get access to the object of the results use the @ or [] instead of the $ operator.

---

    Code
      show(seq_anova(y ~ x, f = 0.25, data = data))
    Output
      
      *****  Sequential ANOVA *****
      
      data: y ~ x
      test statistic:
       log-likelihood ratio = 9.49323, decision = accept H1
      SPRT thresholds:
       lower log(B) = -2.94444, upper log(A) = 2.94444
      Log-Likelihood of the:
       alternative hypothesis = -6.89213
       null hypothesis = -16.38537
      alternative hypothesis: true difference in means is not equal to 0.
      specified effect size: Cohen's f = 0.25
      degrees of freedom: df1 = 1, df2 = 118
      SS effect = 40.02376, SS residual = 153.9212
      Note: to get access to the object of the results use the @ or [] instead of the $ operator.

