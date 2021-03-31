
<a href='https://meikesteinhilber.github.io/sprtt/'><img src="man/figures/logo.png" align="right" height="139"/></a>
<br> <br>

# sprtt

<!-- badges: start -->

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/sprtt?color=red)](https://cran.r-project.org/package=sprtt)
[![codecov](https://codecov.io/gh/MeikeSteinhilber/sprtt/branch/main/graph/badge.svg?token=IQHTDTRBAW)](https://codecov.io/gh/MeikeSteinhilber/sprtt)
[![pkgdown](https://github.com/MeikeSteinhilber/sprtt/actions/workflows/pkgdown-pak.yaml/badge.svg)](https://github.com/MeikeSteinhilber/sprtt/actions/workflows/pkgdown-pak.yaml)
[![R-CMD-check-windows-macOs](https://github.com/MeikeSteinhilber/sprtt/workflows/R-CMD-check-windows-macOs/badge.svg)](https://github.com/MeikeSteinhilber/sprtt/actions)
[![R-CMD-check-ubuntu20.04](https://github.com/MeikeSteinhilber/sprtt/workflows/R-CMD-check-ubuntu20.04/badge.svg)](https://github.com/MeikeSteinhilber/sprtt/actions)
[![R-CMD-check-ubuntu16.04](https://github.com/MeikeSteinhilber/sprtt/workflows/R-CMD-check-ubuntu16.04/badge.svg)](https://github.com/MeikeSteinhilber/sprtt/actions)

<!-- badges: end -->

## Overview

`sprtt`provides Sequential Probability Ratio Tests (SPRT) using the
associated t-statistic:

-   `seq_ttest()` calculates the sequential test statistic.

## Installation

``` r
# Code for installation
```

### Development version

To get a bug fix or to use a feature from the development version, you
can install the development version of `sprtt`from GitHub.

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
#> [1] 162.0432

 # [] Operator
 results["likelihood_ratio"]
#> [1] 162.0432

 # two sample: numeric input----------------------------------------------------
 x <- stats::rnorm(20, mean = 0, sd = 1)
 y <- stats::rnorm(20, mean = 1, sd = 1)
 seq_ttest(x, y, d = 0.8)
#> 
#> *****  Sequential  Two Sample t-test *****
#> 
#> data: x and  y
#> test statistic:
#>  log-likelihood ratio = 3.035, decision = accept H1
#> SPRT thresholds:
#>  lower log(B) = -2.94444, upper log(A) = 2.94444
#> Log-Likelihood of the:
#>  alternative hypothesis = -2.78556
#>  null hypothesis = -5.82056
#> alternative hypothesis: true difference in means is not equal to 0.
#> specified effect size: Cohen's d = 0.8
#> degrees of freedome: df = 38
#> sample estimates:
#> mean of x mean of y 
#>  -0.11572   0.83691 
#> Note: to get access to the object of the results use the @ or []
#>           instead of the $ operator.

 # two sample: formula input ---------------------------------------------------
 x <- stats::rnorm(20, mean = 0, sd = 1)
 y <- as.factor(c(rep(1, 10), rep(2, 10)))
 seq_ttest(x ~ y, d = 0.8)
#> 
#> *****  Sequential  Two Sample t-test *****
#> 
#> data: x ~ y
#> test statistic:
#>  log-likelihood ratio = -1.05718, decision = continue sampling
#> SPRT thresholds:
#>  lower log(B) = -2.94444, upper log(A) = 2.94444
#> Log-Likelihood of the:
#>  alternative hypothesis = -1.71882
#>  null hypothesis = -0.66164
#> alternative hypothesis: true difference in means is not equal to 0.
#> specified effect size: Cohen's d = 0.8
#> degrees of freedome: df = 18
#> sample estimates:
#> mean of x mean of y 
#>  -0.37373  -0.08429 
#> Note: to get access to the object of the results use the @ or []
#>           instead of the $ operator.

 # NA in the data --------------------------------------------------------------
 x <- c(NA, stats::rnorm(20, mean = 0, sd = 2), NA)
 y <- as.factor(c(rep(1, 11), rep(2, 11)))
 seq_ttest(x ~ y, d = 0.8, na.rm = TRUE)
#> 
#> *****  Sequential  Two Sample t-test *****
#> 
#> data: x ~ y
#> test statistic:
#>  log-likelihood ratio = 2.21959, decision = continue sampling
#> SPRT thresholds:
#>  lower log(B) = -2.94444, upper log(A) = 2.94444
#> Log-Likelihood of the:
#>  alternative hypothesis = -3.22885
#>  null hypothesis = -5.44844
#> alternative hypothesis: true difference in means is not equal to 0.
#> specified effect size: Cohen's d = 0.8
#> degrees of freedome: df = 18
#> sample estimates:
#> mean of x mean of y 
#>   0.57227  -1.64643 
#> Note: to get access to the object of the results use the @ or []
#>           instead of the $ operator.

 # work with dataset (data are in the package included) ------------------------
 seq_ttest(monthly_income ~ sex, data = df_income, d = 0.8)
#> 
#> *****  Sequential  Two Sample t-test *****
#> 
#> data: monthly_income ~ sex
#> test statistic:
#>  log-likelihood ratio = -15.2897, decision = accept H0
#> SPRT thresholds:
#>  lower log(B) = -2.94444, upper log(A) = 2.94444
#> Log-Likelihood of the:
#>  alternative hypothesis = -14.79208
#>  null hypothesis = 0.49762
#> alternative hypothesis: true difference in means is not equal to 0.
#> specified effect size: Cohen's d = 0.8
#> degrees of freedome: df = 198
#> sample estimates:
#> mean of x mean of y 
#>  3002.322  3020.533 
#> Note: to get access to the object of the results use the @ or []
#>           instead of the $ operator.
```
