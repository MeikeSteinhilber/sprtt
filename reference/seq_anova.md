# Sequential Analysis of Variance

**\[experimental\]**

Performs a sequential one-way fixed effects ANOVA, which is a variant of
a Sequential Probability Ratio Test (SPRT). The test allows for
continuous monitoring of data collection and provides stopping
boundaries based on likelihood ratios, offering efficiency gains over
traditional fixed-N designs.

The sequential ANOVA continuously evaluates the likelihood ratio after
each observation (or group of observations), stopping when sufficient
evidence accumulates for either H0 or H1.

For methodological details, see Steinhilber et al. (2024)
<doi:10.1037/met0000677>. For practical guidance, see
[`vignette("one_way_anova", package = "sprtt")`](https://meikesteinhilber.github.io/sprtt/articles/one_way_anova.md).

## Usage

``` r
seq_anova(
  formula,
  f,
  alpha = 0.05,
  power = 0.95,
  data,
  verbose = TRUE,
  plot = FALSE,
  seq_steps = "single"
)
```

## Arguments

- formula:

  A formula specifying the model (e.g., `outcome ~ group`). The response
  variable should be on the left side and the grouping factor on the
  right side. Currently only supports one-way designs.

- f:

  Cohen's f (expected minimal effect size or effect size of interest),
  that defines the H1.

- alpha:

  Type I error rate (alpha level). The probability of rejecting H0 when
  it is true. Default is 0.05. Must be between 0 and 1.

- power:

  Statistical power (1 - beta), where beta is the Type II error rate.
  The probability of correctly rejecting H0 when H1 is true with effect
  size f. Default is 0.95. Must be between 0 and 1. Higher values lead
  to wider stopping boundaries and potentially larger sample sizes.

- data:

  A data frame containing the variables specified in the formula.
  Missing values (NA) will be removed with a warning

- verbose:

  a logical value whether you want a verbose output or not.

- plot:

  Logical. If `TRUE`, stores sequential test statistics at each
  sequential step for visualization with
  [`plot_anova()`](https://meikesteinhilber.github.io/sprtt/reference/plot_anova.md).
  This enables retrospective examination of the decision process but
  increases computation time for large datasets. Default is `FALSE`.

- seq_steps:

  Specifies when to calculate test statistics during sequential testing
  (only relevant when `plot = TRUE`). Options:

  - Vector of integers: Calculate at specific sample sizes (e.g.,
    `c(10, 20, 30)`)

  - `"single"`: Calculate after each observation (step size = 1). Note:
    Starts at `k_groups * 2` to ensure sufficient data

  - `"balanced"`: Calculate when each group gains one observation (step
    size = number of groups). Note: Starts at `k_groups * 2`

  For unbalanced designs or non-standard sequences, specify custom steps
  as a vector.

## Value

An object of the S4 class
[`seq_anova_results`](https://meikesteinhilber.github.io/sprtt/reference/seq_anova_results-class.md).
Click on the class link to see the full description of the slots. To get
access to the object use the `@`-operator or `[]`-brackets instead of
`$`. See the examples below.

## Limitations

- Only one-way fixed effects ANOVA is currently supported

- Repeated measures ANOVA is not yet implemented

## See also

- [`plot_anova()`](https://meikesteinhilber.github.io/sprtt/reference/plot_anova.md)
  for visualizing sequential ANOVA results

- [`plan_sample_size()`](https://meikesteinhilber.github.io/sprtt/reference/plan_sample_size.md)
  for sample size planning

- [`seq_ttest()`](https://meikesteinhilber.github.io/sprtt/reference/seq_ttest.md)
  for sequential t-tests

- [`vignette("one_way_anova", package = "sprtt")`](https://meikesteinhilber.github.io/sprtt/articles/one_way_anova.md)
  for detailed tutorial

- [`vignette("plan_sample_size", package = "sprtt")`](https://meikesteinhilber.github.io/sprtt/articles/plan_sample_size.md)
  for planning guidance

- Steinhilber et al. (2023) for theoretical background

## Examples

``` r
# simulate data ----------------------------------------------------------------
set.seed(333)
data <- sprtt::draw_sample_normal(k_groups = 3,
                    f = 0.25,
                    sd = c(1, 1, 1),
                    max_n = 50)


# calculate sequential ANOVA ---------------------------------------------------
results <- sprtt::seq_anova(y ~ x, f = 0.25, data = data)
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
#>  log-likelihood ratio = 7.174, decision = accept H1
#> SPRT thresholds:
#>  lower log(B) = -2.944, upper log(A) = 2.944
#> Log-Likelihood of the:
#>  alternative hypothesis = -3.752
#>  null hypothesis = -10.926
#> alternative hypothesis: true difference in means is not equal to 0.
#> specified effect size: Cohen's f = 0.25
#> empirical Cohen's f = 0.3974361, 95% CI[0.2149383, 0.5519742]
#> Cohen's f adjusted = 0.373
#> degrees of freedom: df1 = 2, df2 = 147
#> SS effect = 20.80949, SS residual = 131.7428, SS total = 152.5523
#> *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

# calculate sequential ANOVA ---------------------------------------------------
results <- sprtt::seq_anova(y ~ x,
                            f = 0.25,
                            data = data,
                            alpha = 0.01,
                            power = .80,
                            verbose = TRUE)
results
#> 
#> *****  Sequential ANOVA *****
#> 
#> formula: y ~ x
#> test statistic:
#>  log-likelihood ratio = 7.174, decision = accept H1
#> SPRT thresholds:
#>  lower log(B) = -1.599, upper log(A) = 4.382
#> Log-Likelihood of the:
#>  alternative hypothesis = -3.752
#>  null hypothesis = -10.926
#> alternative hypothesis: true difference in means is not equal to 0.
#> specified effect size: Cohen's f = 0.25
#> empirical Cohen's f = 0.3974361, 95% CI[0.2149383, 0.5519742]
#> Cohen's f adjusted = 0.373
#> degrees of freedom: df1 = 2, df2 = 147
#> SS effect = 20.80949, SS residual = 131.7428, SS total = 152.5523
#> *Note: to get access to the object of the results use the @ or [] instead of the $ operator.

# calculate sequential ANOVA ---------------------------------------------------
results <- sprtt::seq_anova(y ~ x,
                            f = 0.15,
                            data = data,
                            alpha = 0.05,
                            power = .80,
                            verbose = FALSE)
results
#> 
#> *****  Sequential ANOVA *****
#> 
#> formula: y ~ x
#> test statistic:
#>  log-likelihood ratio = 4.725, decision = accept H1
#> SPRT thresholds:
#>  lower log(B) = -1.558, upper log(A) = 2.773
```
