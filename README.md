
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

The `sprtt` package is the implementation of **s**equential
**p**robability **r**atio **t**ests using the associated **t**-statistic
(**sprtt**).

The package contains:

-   `seq_ttest()` calculates the sequential test statistic and

-   two data sets (`df_income`, `df_stress`) to run the examples in the
    documentation

## Installation

### Release version from CRAN

This is the recommended version for a normal user.

``` r
# installs the package
install.packages("sprtt")
```

### Development version from GitHub

To get a bug fix or to use a feature from the development version, you
can install the development version from GitHub.

``` r
# the installation requires the "devtools" package
# install.packages("devtools")
devtools::install_github("MeikeSteinhilber/sprtt")
```

## Documentation

Detailed documentation can be found on [this
page](https://meikesteinhilber.github.io/sprtt/index.html). There are
several articles covering the usage of the package, the theoretical
background of the test, and also an extended use case.

Short examples can be found in the following paragraph.

### Quick Examples

> **Note**
>
> In the R code sections:
>
> `# comment`: is a comment
>
> `function()`: is R code
>
> `#> results of function()`: is console output

``` r
 #load library -----------------------------------------------------------------
 library(sprtt)

 # one sample: numeric input ---------------------------------------------------
 x <- rnorm(20, mean = 0, sd = 1)
 results <- seq_ttest(x, mu = 1, d = 0.8)

 # get access to the slots -----------------------------------------------------
 # @ Operator
 results@likelihood_ratio
#> [1] 795.9842

 # [] Operator
 results["likelihood_ratio"]
#> [1] 795.9842

 # two sample: numeric input----------------------------------------------------
 x <- stats::rnorm(20, mean = 0, sd = 1)
 y <- stats::rnorm(20, mean = 1, sd = 1)
 seq_ttest(x, y, d = 0.8)
#> 
#> *****  Sequential  Two Sample t-test *****
#> 
#> data: x and  y
#> test statistic:
#>  log-likelihood ratio = 1.8588, decision = continue sampling
#> SPRT thresholds:
#>  lower log(B) = -2.94444, upper log(A) = 2.94444
#> Log-Likelihood of the:
#>  alternative hypothesis = -2.51464
#>  null hypothesis = -4.37343
#> alternative hypothesis: true difference in means is not equal to 0.
#> specified effect size: Cohen's d = 0.8
#> degrees of freedome: df = 38
#> sample estimates:
#> mean of x mean of y 
#>   0.25436   1.08813 
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
#>  log-likelihood ratio = -1.28341, decision = continue sampling
#> SPRT thresholds:
#>  lower log(B) = -2.94444, upper log(A) = 2.94444
#> Log-Likelihood of the:
#>  alternative hypothesis = -1.54388
#>  null hypothesis = -0.26047
#> alternative hypothesis: true difference in means is not equal to 0.
#> specified effect size: Cohen's d = 0.8
#> degrees of freedome: df = 18
#> sample estimates:
#> mean of x mean of y 
#>   0.14398  -0.08230 
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
#>  log-likelihood ratio = -1.21361, decision = continue sampling
#> SPRT thresholds:
#>  lower log(B) = -2.94444, upper log(A) = 2.94444
#> Log-Likelihood of the:
#>  alternative hypothesis = -1.61302
#>  null hypothesis = -0.39941
#> alternative hypothesis: true difference in means is not equal to 0.
#> specified effect size: Cohen's d = 0.8
#> degrees of freedome: df = 18
#> sample estimates:
#> mean of x mean of y 
#>   0.30040  -0.21008 
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
