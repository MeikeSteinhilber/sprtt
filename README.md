
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

- `plot_anova()` plots results of sequential ANOVAs

- `plan_sample_size()` creates comprehensive HTML reports with sample
  size recommendations based on pre-computed SPRT simulations

- `draw_sample_normal()`, `draw_sample_mixture()` simulation of data
  sets

- three data sets (`df_income`, `df_stress`, `df_cancer`) to run the
  examples in the t-test documentation

## Installation

### Release version from CRAN

This is the recommended version for a normal user.

``` r
# installs the package
install.packages("sprtt")
```

### Development version from GitHub

To get a bug fix or to use a feature from the development version, you
can install the latest version from GitHub.

``` r
# the installation requires the "devtools" package
# install.packages("devtools")
# stable GitHub version
devtools::install_github("MeikeSteinhilber/sprtt")

# development version, may not be stable
devtools::install_github("MeikeSteinhilber/sprtt", ref="develop")
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
#> Note: Sample size planning functions require simulation data (~70 MB).
#> Data will download automatically on first use.
#> See ?download_sample_size_data for more information.

# t-TEST ----------------------------------------------------------------------
# one sample: numeric input ---------------------------------------------------
treatment_group <- rnorm(20, mean = 0, sd = 1)
results <- seq_ttest(treatment_group, mu = 1, d = 0.6)

# get access to the slots -----------------------------------------------------
# @ Operator
results@likelihood_ratio
#> [1] 323.9051

# [] Operator
results["likelihood_ratio"]
#> [1] 323.9051

# ANOVA -----------------------------------------------------------------------
# simulate data ---------------------------------------------------------------
set.seed(333)
data <- sprtt::draw_sample_normal(k_groups = 3,
                                  f = 0.25,
                                  sd = c(1, 1, 1),
                                  max_n = 22)

# calculate sequential ANOVA --------------------------------------------------
results <- sprtt::seq_anova(y ~ x, f = 0.25, data = data, plot = TRUE)
# test decision
results@decision
#> [1] "accept H1"
# test results
results
#> 
#> *****  Sequential ANOVA *****
#> 
#> formula: y ~ x
#> test statistic:
#>  log-likelihood ratio = 3.153, decision = accept H1
#> SPRT thresholds:
#>  lower log(B) = -2.944, upper log(A) = 2.944
#> Log-Likelihood of the:
#>  alternative hypothesis = -3.293
#>  null hypothesis = -6.447
#> alternative hypothesis: true difference in means is not equal to 0.
#> specified effect size: Cohen's f = 0.25
#> empirical Cohen's f = 0.4684039, 95% CI[0.1741801, 0.6969498]
#> Cohen's f adjusted = 0.415
#> degrees of freedom: df1 = 2, df2 = 63
#> SS effect = 12.63455, SS residual = 57.58624, SS total = 70.22079
#> *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

# plot results -----------------------------------------------------------------
sprtt::plot_anova(results, position_lr_x = 60)
```

<img src="man/figures/figure-gfm/unnamed-chunk-3-1.png" width="100%" />

### Sample Size Planning

The sample size planning function requires simulation data (~70 MB). On
first use, this data will be downloaded and chached automatically:

``` r
sprtt::plan_sample_size(f_expected = 0.25, k_groups = 3, power = 0.9, decision_rate = 0.9)
```

The package contains functions to help managing the cached data, if
necessary.

**Managing cached data**

``` r
# Check cache status
cache_info()

# Force re-download (if data was updated)
download_sample_size_data(force = TRUE)

# Clear cache
cache_clear()
```

If you need to use the package offline, download the data while
connected beforehand.
