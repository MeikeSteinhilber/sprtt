# How to use the sprtt package

## Note

- The data sets used below are included in the `sprtt` package. Thus,
  the data sets are available when the package is loaded.

- In the R code sections:

  - `# comment`: is a comment
  - `function()`: is R code
  - `#> results of function()`: is console output

## Overview

The `sprtt` package is a **s**equential **p**robability **r**atio
**t**ests **t**oolbox (**sprtt**). This vignette demonstrates the usage
of the package using the
[`seq_ttest()`](https://meikesteinhilber.github.io/sprtt/reference/seq_ttest.md)
function and all arguments with short examples. The theoretical
background of the sequential *t*-test will not be covered by this
vignette.

The
[`seq_ttest()`](https://meikesteinhilber.github.io/sprtt/reference/seq_ttest.md)
function has arguments to specify the requested sequential *t*-test. The
table below shows all possible combinations which can be performed with
the package.

|                            | Two-sample test | One-sample test |
|----------------------------|-----------------|-----------------|
| Two-sided                  | x               | x               |
| One-sided                  | x               | x               |
| Paired (repeated measures) | x               |                 |

Other recommended vignettes cover:

- the [theoretical
  background](https://meikesteinhilber.github.io/sprtt/articles/sequential_testing.html)
  and

- an extended [use
  case](https://meikesteinhilber.github.io/sprtt/articles/use-case.html).

## Installation

Prior to using the `sprtt` package it must be installed and loaded. The
latest release version of the package can either be installed from CRAN
or in the latest development version from GitHub. More information for
the installation can be found
[here](https://meikesteinhilber.github.io/sprtt/#installation).

``` r
# load the package
library(sprtt)
#> Note: Sample size planning functions require simulation data (~70 MB).
#> Data will download automatically on first use.
#> See ?download_sample_size_data for more information.
```

## What does the package contain?

The `sprtt` package contains:

- [`seq_ttest()`](https://meikesteinhilber.github.io/sprtt/reference/seq_ttest.md)
  : a function which performs sequential *t*-tests

- `df_income`: a set of data to run the examples given in this vignette

- `df_stress`: a set of data to run the examples given in this vignette

- `df_cancer`: a set of data to run the examples given in this vignette

## How do I use the seq_ttest() function?

The
[`seq_ttest()`](https://meikesteinhilber.github.io/sprtt/reference/seq_ttest.md)
function works similarly to the
[`t.test()`](https://rdrr.io/r/stats/t.test.html) function from the
`stats` package if one is familiar with that already.

Sequential *t*-tests require some specification from the user:

- the variables, which contain the data,

- the error probability `alpha`,

- the `power` (1 - 𝛽),

- the effect size Cohen\`s `d`, which represents the expected effect
  size or the lowest effect size of interest, and

- optional arguments to further specify the test.

However, in some cases, it is not necessary to specify all arguments
because some of them have default values. If these values are the ones
required, they can be skipped.

| Argument    | Default value | Input option                   |
|-------------|:--------------|:-------------------------------|
| x           | \-            | formula or numeric input       |
| y           | NULL          | numeric vector                 |
| data        | NULL          | data frame                     |
| mu          | 0             | numeric value                  |
| d           | \-            | numeric value                  |
| alpha       | 0.05          | numeric value between 0 and 1  |
| power       | 0.95          | numeric value between 0 and 1  |
| alternative | “two.sided”   | “two.sided”, “greater”, “less” |
| paired      | FALSE         | TRUE or FALSE                  |
| na.rm       | TRUE          | TRUE or FALSE                  |
| verbose     | TRUE          | TRUE or FALSE                  |

There are two different ways how the data can be transferred into the
function. The `x` argument takes either `formula` or `numeric` input.
Which input option is recommended depends on the structure of the data.

### x argument: formula input

The `formula` input is used when both groups are merged in one variable
and there is a second variable that indicates group membership. This
input option uses the `x` argument and the `data` argument if the
variables are stored in a data frame.

#### *Two-sample test*

``` r
# show data frame --------------------------------------------------------------
head(df_income)
#>   monthly_income    sex
#> 1       4091.001 female
#> 2       3274.591   male
#> 3       2696.436 female
#> 4       3826.413   male
#> 5       3522.478 female
#> 6       2563.597   male

# sequential t-test: data argument ---------------------------------------------
seq_ttest(monthly_income ~ sex,     # x argument 
          data = df_income,
          d = 0.2)
#> 
#> *****  Sequential  Two Sample t-test *****
#> 
#> formula: monthly_income ~ sex
#> test statistic:
#>  log-likelihood ratio = -0.594, decision = continue sampling
#> SPRT thresholds:
#>  lower log(B) = -2.944, upper log(A) = 2.944
#> Log-Likelihood of the:
#>  alternative hypothesis = 0.827
#>  null hypothesis = 1.421
#> alternative hypothesis: true difference in means is not equal to 0.
#> specified effect size: Cohen's d = 0.2
#> degrees of freedom: df = 118
#> sample estimates:
#> mean of x mean of y 
#>  3072.086  3080.715 
#> *Note: to get access to the object of the results use the @ or [] instead of the $ operator.
```

#### *One-sample test*

To perform a one-sample test, the right side of the formula has to be 1.
The `mu` argument is also required, which specifies the mean value that
one wants to test against.

``` r
# show data frame --------------------------------------------------------------
head(df_income)
#>   monthly_income    sex
#> 1       4091.001 female
#> 2       3274.591   male
#> 3       2696.436 female
#> 4       3826.413   male
#> 5       3522.478 female
#> 6       2563.597   male

# sequential t-test: data argument ---------------------------------------------
seq_ttest(monthly_income ~ 1,     # x argument 
          mu = 3000,
          d = 0.5,
          data = df_income)
#> 
#> *****  Sequential One Sample t-test *****
#> 
#> formula: monthly_income ~ 1
#> test statistic:
#>  log-likelihood ratio = -6.288, decision = accept H0
#> SPRT thresholds:
#>  lower log(B) = -2.944, upper log(A) = 2.944
#> Log-Likelihood of the:
#>  alternative hypothesis = -9.182
#>  null hypothesis = -2.894
#> alternative hypothesis: true mean is not equal to 3000.
#> specified effect size: Cohen's d = 0.5
#> degrees of freedom: df = 119
#> sample estimates:
#> mean of x 
#>    3076.4 
#> *Note: to get access to the object of the results use the @ or [] instead of the $ operator.
```

### x argument: numeric input

The `numeric` input is used when each group has its own variable. The
variables can either be put in the global environment directly or be
stored in a data frame.

#### *Two-sample test*

If one wants to perform a two-sample test, the `y` argument is required
in addition to `x`. If the data are stored in a data frame, the `$`
operator is essential to get access to the variables.

``` r
# show data frame --------------------------------------------------------------
head(df_cancer)
#>   treatment_group control_group
#> 1        6.097665      4.493064
#> 2        6.609234      5.520956
#> 3        5.665810      3.954091
#> 4        4.830564      3.733212
#> 5        4.917361      4.109373
#> 6        3.457433      3.563800

# sequential t-test: $ operator ------------------------------------------------
seq_ttest(df_cancer$treatment_group, # x argument
          df_cancer$control_group,   # y argument
          d = 0.3,                   
          verbose = FALSE)           
#> 
#> *****  Sequential  Two Sample t-test *****
#> 
#> formula: df_cancer$treatment_group and  df_cancer$control_group
#> test statistic:
#>  log-likelihood ratio = 10.777, decision = accept H1
#> SPRT thresholds:
#>  lower log(B) = -2.944, upper log(A) = 2.944


# sequential t-test: global variables ------------------------------------------
treatment <- df_cancer$treatment_group
control <- df_cancer$control_group

seq_ttest(treatment,
          control,
          d = 0.3,
          verbose = FALSE)
#> 
#> *****  Sequential  Two Sample t-test *****
#> 
#> formula: treatment and  control
#> test statistic:
#>  log-likelihood ratio = 10.777, decision = accept H1
#> SPRT thresholds:
#>  lower log(B) = -2.944, upper log(A) = 2.944
```

#### *One-sample test*

If one wants to perform a one-sample test there is only one group and
therefore only one variable. If the data are in a data frame, the `$`
operator is essential to get access to the variables. The `mu` argument
is additionally required, which specifies the mean which one wants to
test against.

``` r
# show data frame --------------------------------------------------------------
head(df_cancer)
#>   treatment_group control_group
#> 1        6.097665      4.493064
#> 2        6.609234      5.520956
#> 3        5.665810      3.954091
#> 4        4.830564      3.733212
#> 5        4.917361      4.109373
#> 6        3.457433      3.563800

# sequential t-test: $ operator ------------------------------------------------
seq_ttest(df_cancer$treatment_group,     # x argument
          mu = 3.5,            
          d = 0.2,
          verbose = FALSE)
#> 
#> *****  Sequential One Sample t-test *****
#> 
#> formula: df_cancer$treatment_group
#> test statistic:
#>  log-likelihood ratio = 16.677, decision = accept H1
#> SPRT thresholds:
#>  lower log(B) = -2.944, upper log(A) = 2.944


# sequential t-test: global variables ------------------------------------------
treatment <- df_cancer$treatment_group

seq_ttest(treatment,     # x argument
          mu = 3.5, 
          data = df,
          d = 0.2,                  
          verbose = FALSE)
#> 
#> *****  Sequential One Sample t-test *****
#> 
#> formula: treatment
#> test statistic:
#>  log-likelihood ratio = 16.677, decision = accept H1
#> SPRT thresholds:
#>  lower log(B) = -2.944, upper log(A) = 2.944
```

### Further arguments

#### Paired

The `paired` argument states if the data are paired. To perform a paired
sequential *t*-test, `paired` has to be set to `TRUE`.

``` r
# show data frame --------------------------------------------------------------
head(df_stress)
#>   baseline_stress one_year_stress
#> 1        7.175250        7.844337
#> 2        4.918343        5.527191
#> 3        4.634266        5.783046
#> 4        5.671340        7.793956
#> 5        4.141257        3.133889
#> 6        4.771696        8.548586

# sequential t-test: $ operator ------------------------------------------------
seq_ttest(df_stress$baseline_stress, # x argument
          df_stress$one_year_stress, # y argument
          d = 0.3,
          paired = TRUE,
          data = df_stress)  
#> 
#> *****  Sequential Paired t-test *****
#> 
#> formula: df_stress$baseline_stress and  df_stress$one_year_stress
#> test statistic:
#>  log-likelihood ratio = 7.174, decision = accept H1
#> SPRT thresholds:
#>  lower log(B) = -2.944, upper log(A) = 2.944
#> Log-Likelihood of the:
#>  alternative hypothesis = -3.483
#>  null hypothesis = -10.657
#> alternative hypothesis: true difference in means is not equal to 0.
#> specified effect size: Cohen's d = 0.3
#> degrees of freedom: df = 119
#> sample estimates:
#> mean difference 
#>        -0.39622 
#> *Note: to get access to the object of the results use the @ or [] instead of the $ operator.
```

#### Alternative

The `alternative` argument states in which way the test is to be
performed:

- two-sided: `"two.sided"` or

- one-sided: `"less"` or `"greater"`.

``` r
# show data frame --------------------------------------------------------------
head(df_income)
#>   monthly_income    sex
#> 1       4091.001 female
#> 2       3274.591   male
#> 3       2696.436 female
#> 4       3826.413   male
#> 5       3522.478 female
#> 6       2563.597   male

# sequential t-test: data argument ---------------------------------------------
seq_ttest(monthly_income ~ 1,     # x argument 
          mu = 1000,
          d = 0.3,
          alternative = "two.sided",
          data = df_income)
#> 
#> *****  Sequential One Sample t-test *****
#> 
#> formula: monthly_income ~ 1
#> test statistic:
#>  log-likelihood ratio = 31.548, decision = accept H1
#> SPRT thresholds:
#>  lower log(B) = -2.944, upper log(A) = 2.944
#> Log-Likelihood of the:
#>  alternative hypothesis = -149.747
#>  null hypothesis = -181.295
#> alternative hypothesis: true mean is not equal to 1000.
#> specified effect size: Cohen's d = 0.3
#> degrees of freedom: df = 119
#> sample estimates:
#> mean of x 
#>    3076.4 
#> *Note: to get access to the object of the results use the @ or [] instead of the $ operator.
```

#### Na.rm

The `na.rm` argument defines the handling of missing values. If set to
`TRUE` (default value), it will remove all missing values automatically.
If this behavior is not wanted, the `na.rm` argument has to be set to
`FALSE`. If missing values are discovered, an error is triggered.

#### Verbose

The `verbose` argument defines the extent of the output shown in the
console. If set to `TRUE` (default value), the output will be elaborate,
if set to `FALSE` the output will be short.

``` r
# sequential t-test: verbose FALSE ---------------------------------------------
seq_ttest(df_cancer$treatment_group, # x argument
          df_cancer$control_group,   # y argument
          d = 0.3,
          verbose = FALSE)
#> 
#> *****  Sequential  Two Sample t-test *****
#> 
#> formula: df_cancer$treatment_group and  df_cancer$control_group
#> test statistic:
#>  log-likelihood ratio = 10.777, decision = accept H1
#> SPRT thresholds:
#>  lower log(B) = -2.944, upper log(A) = 2.944

# sequential t-test: verbose TRUE ----------------------------------------------
seq_ttest(df_cancer$treatment_group, # x argument
          df_cancer$control_group,   # y argument
          d = 0.3,
          verbose = TRUE) 
#> 
#> *****  Sequential  Two Sample t-test *****
#> 
#> formula: df_cancer$treatment_group and  df_cancer$control_group
#> test statistic:
#>  log-likelihood ratio = 10.777, decision = accept H1
#> SPRT thresholds:
#>  lower log(B) = -2.944, upper log(A) = 2.944
#> Log-Likelihood of the:
#>  alternative hypothesis = -11.635
#>  null hypothesis = -22.411
#> alternative hypothesis: true difference in means is not equal to 0.
#> specified effect size: Cohen's d = 0.3
#> degrees of freedom: df = 238
#> sample estimates:
#> mean of x mean of y 
#>   4.92417   4.02215 
#> *Note: to get access to the object of the results use the @ or [] instead of the $ operator.
```

## How do I get access to the results?

The simplest way to get access to the results is to run the
[`seq_ttest()`](https://meikesteinhilber.github.io/sprtt/reference/seq_ttest.md)
function. It will print the results automatically in the console. The
verbose argument specifies how much information is wished to be shown.

However, the recommended way is to save the results in an object (e.g
“results”). Doing so allows running further calculations with it
afterward. It is important to keep in mind that the output object will
be an S4 class. Therefore the access operator is the `@` sign or the
`[]` brackets.

``` r
# save the resuts in a object 
results <- seq_ttest(df_cancer$treatment_group,
                     df_cancer$control_group,  
                     d = 0.3)
# access the object with the @ operator 
results@decision
#> [1] "accept H1"

# access the object with the [] brackets
results["decision"]
#> [1] "accept H1"
```
