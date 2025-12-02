# Sequential Analysis of Variance

**\[experimental\]**

Performs a sequential one-way fixed effects ANOVA, see Steinhilber et
al. (2023) <doi:10.31234/osf.io/m64ne> for more information. The
repeated measurement ANOVA is not implemented yet in this function. For
more information check out the vignette
[`vignette("one_way_anova", package = "sprtt")`](https://meikesteinhilber.github.io/sprtt/articles/one_way_anova.md)

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

  A formula specifying the model.

- f:

  Cohen's f (expected minimal effect size or effect size of interest).

- alpha:

  the type I error. A number between 0 and 1.

- power:

  1 - beta (beta is the type II error probability). A number between 0
  and 1.

- data:

  A data frame in which the variables specified in the formula will be
  found.

- verbose:

  a logical value whether you want a verbose output or not.

- plot:

  calculates the ANOVA sequentially on the data and saves the results in
  the slot called plot. This calculation is necessary for the
  plot_anova() function.

- seq_steps:

  Defines the sequential steps for the sequential calculation if
  `plot = TRUE`. Argument takes either a vector of numbers or the
  argument `single` or `balanced`. A vector of numbers specifies the
  sample sizes at which the anova is calculated. `single` specifies that
  after each single point the test statistic is calculated (step size =
  1). Attention: the calculation starts at the number of groups times
  two. If the data do not fit to this, you have to specify the
  sequential steps yourself in this argument. `balanced` specifies that
  the step size is equal to the number of groups. Attention: the
  calculation starts at the number of groups times two. If the data do
  not fit to this, you have to specify the sequential steps yourself in
  this argument.

## Value

An object of the S4 class
[`seq_anova_results`](https://meikesteinhilber.github.io/sprtt/reference/seq_anova_results-class.md).
Click on the class link to see the full description of the slots. To get
access to the object use the `@`-operator or `[]`-brackets instead of
`$`. See the examples below.

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
