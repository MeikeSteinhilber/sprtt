# Sequential Probability Ratio Test using t-statistic

Performs one-sample, two-sample, and paired sequential t-tests, which
are variants of Sequential Probability Ratio Tests (SPRT). The test
allows for continuous monitoring of data collection and provides
stopping boundaries based on likelihood ratios, offering efficiency
gains over traditional fixed-N designs.

The sequential t-test continuously evaluates the likelihood ratio after
each observation (or pair of observations), stopping when sufficient
evidence accumulates for either H0 or H1.

For methodological details, see Schnuerch & Erdfelder (2019)
<doi:10.1037/met0000234>. For practical guidance, see
[`vignette("t_test", package = "sprtt")`](https://meikesteinhilber.github.io/sprtt/articles/t_test.md).

## Usage

``` r
seq_ttest(
  x,
  y = NULL,
  data = NULL,
  mu = 0,
  d,
  alpha = 0.05,
  power = 0.95,
  alternative = "two.sided",
  paired = FALSE,
  na.rm = TRUE,
  verbose = TRUE
)
```

## Arguments

- x:

  Works with two classes: `numeric` and `formula`. Therefore you can
  write `"x"` or `"x~y"`.

  - `"numeric input"`: a (non-empty) numeric vector of data values.

  - `"formula input"`: a formula of the form lhs ~ rhs where lhs is a
    numeric variable giving the data values and rhs either 1 for a
    one-sample test or a factor with two levels giving the corresponding
    groups.

- y:

  An optional (non-empty) numeric vector of data values. Only used for
  two-sample tests when `x` is numeric.

- data:

  An optional data frame containing the variables specified in the
  formula. Only used when `x` is a formula.

- mu:

  a number indicating the true value of the mean (or difference in means
  if you are performing a two sample test).

- d:

  a number indicating the specified (expected) effect size (Cohen's d)

- alpha:

  Type I error rate (alpha level). The probability of rejecting H0 when
  it is true. Default is 0.05. Must be between 0 and 1.

- power:

  Statistical power (1 - beta), where beta is the Type II error rate.
  The probability of correctly rejecting H0 when H1 is true with effect
  size d. Default is 0.95. Must be between 0 and 1. Higher values lead
  to wider stopping boundaries and potentially larger sample sizes.

- alternative:

  a character string specifying the alternative hypothesis, must be one
  of `two.sided` (default), `greater` or `less`. You can specify just
  the initial letter.

- paired:

  Logical indicating whether to perform a paired t-test. Default is
  `FALSE`.

- na.rm:

  a logical value indicating whether `NA` values should be removed
  before the computation proceeds.

- verbose:

  a logical value whether you want a verbose output or not.

## Value

An object of the S4 class
[`seq_ttest_results`](https://meikesteinhilber.github.io/sprtt/reference/seq_ttest_results-class.md).
Click on the class link to see the full description of the slots. To get
access to the object use the `@`-operator or `[]`-brackets instead of
`$`. See the examples below.

## See also

- [`seq_anova()`](https://meikesteinhilber.github.io/sprtt/reference/seq_anova.md)
  for sequential one-way ANOVA

- [`draw_sample_normal()`](https://meikesteinhilber.github.io/sprtt/reference/draw_sample_normal.md)
  for simulating test data

- [`vignette("t_test", package = "sprtt")`](https://meikesteinhilber.github.io/sprtt/articles/t_test.md)
  for detailed tutorial

- [`vignette("usage_sprtt", package = "sprtt")`](https://meikesteinhilber.github.io/sprtt/articles/usage_sprtt.md)
  for package overview

- Schnuerch & Erdfelder (2019) <doi:10.1037/met0000234> for theoretical
  background

## Examples

``` r
# set seed --------------------------------------------------------------------
set.seed(333)

# load library ----------------------------------------------------------------
library(sprtt)

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

# two sample: numeric input----------------------------------------------------
treatment_group <- stats::rnorm(20, mean = 0, sd = 1)
control_group <- stats::rnorm(20, mean = 1, sd = 1)
seq_ttest(treatment_group, control_group, d = 0.8)
#> 
#> *****  Sequential  Two Sample t-test *****
#> 
#> formula: treatment_group and  control_group
#> test statistic:
#>  log-likelihood ratio = 5.347, decision = accept H1
#> SPRT thresholds:
#>  lower log(B) = -2.944, upper log(A) = 2.944
#> Log-Likelihood of the:
#>  alternative hypothesis = -4.211
#>  null hypothesis = -9.558
#> alternative hypothesis: true difference in means is not equal to 0.
#> specified effect size: Cohen's d = 0.8
#> degrees of freedom: df = 38
#> sample estimates:
#> mean of x mean of y 
#>  -0.05204   1.18768 
#> *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

# two sample: formula input ---------------------------------------------------
stress_level <- stats::rnorm(20, mean = 0, sd = 1)
sex <- as.factor(c(rep(1, 10), rep(2, 10)))
seq_ttest(stress_level ~ sex, d = 0.8)
#> 
#> *****  Sequential  Two Sample t-test *****
#> 
#> formula: stress_level ~ sex
#> test statistic:
#>  log-likelihood ratio = -1.455, decision = continue sampling
#> SPRT thresholds:
#>  lower log(B) = -2.944, upper log(A) = 2.944
#> Log-Likelihood of the:
#>  alternative hypothesis = -1.233
#>  null hypothesis = 0.222
#> alternative hypothesis: true difference in means is not equal to 0.
#> specified effect size: Cohen's d = 0.8
#> degrees of freedom: df = 18
#> sample estimates:
#> mean of x mean of y 
#>  -0.23286  -0.08217 
#> *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

# NA in the data --------------------------------------------------------------
stress_level <- c(NA, stats::rnorm(20, mean = 0, sd = 2), NA)
sex <- as.factor(c(rep(1, 11), rep(2, 11)))
seq_ttest(stress_level ~ sex, d = 0.8, na.rm = TRUE)
#> 
#> *****  Sequential  Two Sample t-test *****
#> 
#> formula: stress_level ~ sex
#> test statistic:
#>  log-likelihood ratio = -0.359, decision = continue sampling
#> SPRT thresholds:
#>  lower log(B) = -2.944, upper log(A) = 2.944
#> Log-Likelihood of the:
#>  alternative hypothesis = -1.923
#>  null hypothesis = -1.564
#> alternative hypothesis: true difference in means is not equal to 0.
#> specified effect size: Cohen's d = 0.8
#> degrees of freedom: df = 18
#> sample estimates:
#> mean of x mean of y 
#>  -0.40818   0.42068 
#> *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

# work with dataset (data are in the package included) ------------------------
seq_ttest(monthly_income ~ sex, data = df_income, d = 0.8)
#> 
#> *****  Sequential  Two Sample t-test *****
#> 
#> formula: monthly_income ~ sex
#> test statistic:
#>  log-likelihood ratio = -9.514, decision = accept H0
#> SPRT thresholds:
#>  lower log(B) = -2.944, upper log(A) = 2.944
#> Log-Likelihood of the:
#>  alternative hypothesis = -8.093
#>  null hypothesis = 1.421
#> alternative hypothesis: true difference in means is not equal to 0.
#> specified effect size: Cohen's d = 0.8
#> degrees of freedom: df = 118
#> sample estimates:
#> mean of x mean of y 
#>  3072.086  3080.715 
#> *Note: to get access to the object of the results use the @ or [] instead of the $ operator.
```
