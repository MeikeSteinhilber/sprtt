
# sprtt <a href='https://meikesteinhilber.github.io/sprtt/'><img src='man/figures/logo.png' align="right" height="139" /></a>

<!-- badges: start -->

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/sprtt?color=green)](https://cran.r-project.org/package=sprtt)
[![codecov](https://codecov.io/gh/MeikeSteinhilber/sprtt/branch/main/graph/badge.svg?token=IQHTDTRBAW)](https://codecov.io/gh/MeikeSteinhilber/sprtt)
[![lint](https://github.com/MeikeSteinhilber/sprtt/actions/workflows/lint.yaml/badge.svg)](https://github.com/MeikeSteinhilber/sprtt/actions/workflows/lint.yaml)

[![R-CMD-check-windows-macOs](https://github.com/MeikeSteinhilber/sprtt/workflows/R-CMD-check-windows-macOs/badge.svg)](https://github.com/MeikeSteinhilber/sprtt/actions)
[![R-CMD-check-ubuntu20.04](https://github.com/MeikeSteinhilber/sprtt/workflows/R-CMD-check-ubuntu20.04/badge.svg)](https://github.com/MeikeSteinhilber/sprtt/actions)
[![R-CMD-check-ubuntu16.04](https://github.com/MeikeSteinhilber/sprtt/workflows/R-CMD-check-ubuntu16.04/badge.svg)](https://github.com/MeikeSteinhilber/sprtt/actions)
<!-- badges: end -->

## Overview

**sprtt** provides Sequential Probability Ratio Tests (SPRT) using the
associated t-statistic:

-   `seq_ttest()` calculates the sequential test statistic.

## Installation

``` r
# Code for installation
```

### Development version

To get a bug fix or to use a feature from the development version, you
can install the development version of **sprtt** from GitHub.

``` r
# install.packages("devtools")
devtools::install_github("MeikeSteinhilber/sprtt")
```

## Usage

``` r
 #load library -----------------------------------------------------------------
 library(sprtt)

 # one sample: numeric input ---------------------------------------------------
 x <- rnorm(20, mean = 0, sd = 1)
 results <- seq_ttest(x, mu = 1, d = 0.8)

 # get access to the slots -----------------------------------------------------
 # @ Operator
 results@likelihood_ratio
#> [1] 14648.2

 # [] Operator
 results["likelihood_ratio"]
#> [1] 14648.2

 # two sample: numeric input----------------------------------------------------
 x <- stats::rnorm(20, mean = 0, sd = 1)
 y <- stats::rnorm(20, mean = 1, sd = 1)
 seq_ttest(x, y, d = 0.8)
#> 
#> ***** Sequential Two Sample t-test *****
#> 
#> data: x and  y
#> test statistic:
#>  log-likelihood ratio = 6.52221, decision = accept H1
#> SPRT thresholds:
#>  lower log(B) = -2.94444, upper log(A) = 2.94444
#> Log-Likelihood of the:
#>  alternative hypothesis = -5.55553
#>  null hypothesis = -12.07774
#> alternative hypothesis: true difference in means is not equal to 0.
#> specified effect size: Cohen's d = 0.8
#> degrees of freedome: df = 38
#> sample estimates:
#>  mean of group one = -0.1948
#>  mean of group two = 1.40891
#> Note: to get access to the object of the results use the @ or [] instead of the $ operator.

 # two sample: formula input ---------------------------------------------------
 x <- stats::rnorm(20, mean = 0, sd = 1)
 y <- as.factor(c(rep(1, 10), rep(2, 10)))
 seq_ttest(x ~ y, d = 0.8)
#> 
#> ***** Sequential Two Sample t-test *****
#> 
#> data: x ~ y
#> test statistic:
#>  log-likelihood ratio = -1.58059, decision = continue sampling
#> SPRT thresholds:
#>  lower log(B) = -2.94444, upper log(A) = 2.94444
#> Log-Likelihood of the:
#>  alternative hypothesis = -0.28991
#>  null hypothesis = 1.29068
#> alternative hypothesis: true difference in means is not equal to 0.
#> specified effect size: Cohen's d = 0.8
#> degrees of freedome: df = 18
#> sample estimates:
#>  mean of group one = 0.28557
#>  mean of group two = 0.34502
#> Note: to get access to the object of the results use the @ or [] instead of the $ operator.

 # NA in the data --------------------------------------------------------------
 x <- c(NA, stats::rnorm(20, mean = 0, sd = 2), NA)
 y <- as.factor(c(rep(1, 11), rep(2, 11)))
 seq_ttest(x ~ y, d = 0.8, na.rm = TRUE)
#> 
#> ***** Sequential Two Sample t-test *****
#> 
#> data: x ~ y
#> test statistic:
#>  log-likelihood ratio = -1.36188, decision = continue sampling
#> SPRT thresholds:
#>  lower log(B) = -2.94444, upper log(A) = 2.94444
#> Log-Likelihood of the:
#>  alternative hypothesis = -1.43706
#>  null hypothesis = -0.07517
#> alternative hypothesis: true difference in means is not equal to 0.
#> specified effect size: Cohen's d = 0.8
#> degrees of freedome: df = 18
#> sample estimates:
#>  mean of group one = 0.65359
#>  mean of group two = 0.28878
#> Note: to get access to the object of the results use the @ or [] instead of the $ operator.

 # work with dataset (data are in the package included) ------------------------
 seq_ttest(monthly_income ~ sex, data = df_income, d = 0.8)
#> 
#> ***** Sequential Two Sample t-test *****
#> 
#> data: monthly_income ~ sex
#> test statistic:
#>  log-likelihood ratio = -1.32512, decision = continue sampling
#> SPRT thresholds:
#>  lower log(B) = -2.94444, upper log(A) = 2.94444
#> Log-Likelihood of the:
#>  alternative hypothesis = -2.32047
#>  null hypothesis = -0.99535
#> alternative hypothesis: true difference in means is not equal to 0.
#> specified effect size: Cohen's d = 0.8
#> degrees of freedome: df = 28
#> sample estimates:
#>  mean of group one = 3504.267
#>  mean of group two = 3070.667
#> Note: to get access to the object of the results use the @ or [] instead of the $ operator.
```
