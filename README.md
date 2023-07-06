
<!-- ATTENTION! see below -->

# sprtt

<!-- badges: start -->

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/sprtt?color=green)](https://cran.r-project.org/package=sprtt)
[![total](https://cranlogs.r-pkg.org/badges/grand-total/sprtt)](https://cran.r-project.org/package=sprtt)
[![monthly](https://cranlogs.r-pkg.org/badges/sprtt)](https://cran.r-project.org/package=sprtt)
[![codecov](https://codecov.io/gh/MeikeSteinhilber/sprtt/branch/main/graph/badge.svg?token=IQHTDTRBAW)](https://app.codecov.io/gh/MeikeSteinhilber/sprtt)
[![pkgdown](https://github.com/MeikeSteinhilber/sprtt/actions/workflows/pkgdown-pak.yaml/badge.svg)](https://github.com/MeikeSteinhilber/sprtt/actions/workflows/pkgdown-pak.yaml)
[![R-CMD-check](https://github.com/MeikeSteinhilber/sprtt/actions/workflows/R-CMD-check-windows-macOs.yaml/badge.svg)](https://github.com/MeikeSteinhilber/sprtt/actions/workflows/R-CMD-check-windows-macOs.yaml)

<!-- badges: end -->

## Overview

The `sprtt` package is a **s**equential **p**robability **r**atio
**t**ests **t**oolbox (**sprtt**).

The package contains:

- `seq_ttest()`, `seq_anova()` calculates sequential t-test and
  sequential one-way ANOVAs

- three data sets (`df_income`, `df_stress`, `df_cancer`) to run the
  examples in the t-test documentation

- `plot_anova()` plots results of sequential ANOVAs

- `draw_sample_normal()`, `draw_sample_mixture()` simulation of data
  sets

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

Detailed documentation can be found on the [home
page](https://meikesteinhilber.github.io/sprtt/index.html). There are
several articles covering the
[usage](https://meikesteinhilber.github.io/sprtt/articles/usage-sprtt.html)
of the package, the [theoretical
background](https://meikesteinhilber.github.io/sprtt/articles/sequential_testing.html)
of the test, and also an extended [use
case](https://meikesteinhilber.github.io/sprtt/articles/use-case.html).

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

<!--
&#10;ATTENTION!
&#10;in the .md file must be changed by hand. Otherwise the picture is not found on the website and CRAN.
<img src="man/figures/figure-gfm/unnamed-chunk-3-1.png" width="100%" />
-->

``` r
# set seed --------------------------------------------------------------------
set.seed(333)

# load library ----------------------------------------------------------------
library(sprtt)

# t-TEST ----------------------------------------------------------------------
# one sample: numeric input ---------------------------------------------------
treatment_group <- rnorm(20, mean = 0, sd = 1)
results <- seq_ttest(treatment_group, mu = 1, d = 0.8)

# get access to the slots -----------------------------------------------------
# @ Operator
results@likelihood_ratio
#> [1] 965.0728

# [] Operator
results["likelihood_ratio"]
#> [1] 965.0728

# ANOVA -----------------------------------------------------------------------
# simulate data ---------------------------------------------------------------
set.seed(333)
data <- sprtt::draw_sample_normal(k_groups = 3,
                                  f = 0.25,
                                  sd = c(1, 1, 1),
                                  max_n = 25)

# calculate sequential ANOVA --------------------------------------------------
results <- sprtt::seq_anova(y ~ x, f = 0.25, data = data, plot = TRUE)
# test decision
results@decision
#> [1] "continue sampling"
# test results
results
#> 
#> *****  Sequential ANOVA *****
#> 
#> formula: y ~ x
#> test statistic:
#>  log-likelihood ratio = 2.892, decision = continue sampling
#> SPRT thresholds:
#>  lower log(B) = -2.944, upper log(A) = 2.944
#> Log-Likelihood of the:
#>  alternative hypothesis = -2.715
#>  null hypothesis = -5.607
#> alternative hypothesis: true difference in means is not equal to 0.
#> specified effect size: Cohen's f = 0.25
#> empirical Cohen's f = 0.4045074, 95% CI[0.129478, 0.6171581]
#> Cohen's f adjusted = 0.355
#> degrees of freedom: df1 = 2, df2 = 72
#> SS effect = 10.74731, SS residual = 65.68208, SS total = 76.42939
#> *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

# plot results -----------------------------------------------------------------
sprtt::plot_anova(results)
```

<img src="man/figures/figure-gfm/unnamed-chunk-3-1.png" width="100%" />
