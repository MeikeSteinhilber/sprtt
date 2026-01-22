# Use Case

## Note

- The data set `df_stress` is included in the `sprtt` package. Thus, the
  data set is available when the package is loaded.

- In the R code sections:

  - `# comment`: is a comment
  - `function()`: is R code
  - `#> results of function()`: is console output

## Overview

The `sprtt` package is a **s**equential **p**robability **r**atio
**t**ests toolbox (**sprtt**). This vignette describes an exemplary use
case to improve the understanding of the package and the sequential
t-test.

Other recommended vignettes cover:

- [the theoretical
  background](https://meikesteinhilber.github.io/sprtt/articles/sequential_testing.html)
  and

- a [general
  guide](https://meikesteinhilber.github.io/sprtt/articles/usage-sprtt.html),
  how to use the package.

## Use Case

A team of researchers wants to know if the stress of the employees
increased in the company itFlow AG over the last year. The Human
Resources department has gathered data from a new self-care tool they
implemented for the employees. It is difficult to predict how many
employees will participate at the second measurement point (one year
after the baseline). The team suggests using a sequential *t*-test
instead of a Students *t*-test, because the sequential procedure can
reduce the required sample size and is stopped right after the decision
for one of the hypotheses is made. Furthermore, the sequential *t*-test
is able to gather evidence for both the alternative and the null
hypothesis.

### Hypothesis

The researchers know that the company has received more orders than in
the year before. Thus, they expect an increase in self-reported stress.

### Data Analysis

The parameters of the sequential *t*-test are specified as follows:

- The researchers expect an increase in stress but they have no prior
  knowledge about the expected effect size. Thus, they define the lower
  limit of a substantial effect of interest.

  ``` r
  d <- 0.2
  ```

- They choose the common \\\alpha\\ level of .05 and the same level for
  the \\\beta\\ error probability, which leads to a power of .95 (\\1 -
  \beta\\).

  ``` r
  alpha <- 0.05
  power <- 0.95
  ```

- The data are repeated measures, therefore the test is a paired
  sequential *t*-test.

  ``` r
  paired <- TRUE
  ```

- The researchers expect that the stress will have increased after one
  year. Thus, they specify that the true difference in means is greater
  than 0.  
  `(mean(one_year_stress) - mean(baseline_stress)) > 0`

  ``` r
  alternative <- "greater"
  ```

The HR department receives the new data piece by piece and passes it
directly on to the researchers. The test is performed for the first time
and starts with the first two data points.

``` r
# first data from the Human Resources department ---
# current sample size
n_person <- 2

# get data
df <- df_stress[1:n_person,]

# print data
df
#>   baseline_stress one_year_stress
#> 1        7.175250        7.844337
#> 2        4.918343        5.527191

# sequential t-test
results <- seq_ttest(df$one_year_stress,
                     df$baseline_stress,
                     alpha = alpha,
                     power = power,
                     d = d,
                     paired = paired,
                     alternative = alternative,
                     verbose = FALSE)

# print results: console output
results
#> 
#> *****  Sequential Paired t-test *****
#> 
#> formula: df$one_year_stress and  df$baseline_stress
#> test statistic:
#>  log-likelihood ratio = 0.332, decision = continue sampling
#> SPRT thresholds:
#>  lower log(B) = -2.944, upper log(A) = 2.944
```

The decision from the first test is:

``` r
results@decision
#> [1] "continue sampling"
```

As a result, the researchers take one more data point and run the test
again.

``` r
# new data from the Human Resources department ---
# get one more person
n_person <- n_person + 1
df <- df_stress[1:n_person,]

# print new data
df
#>   baseline_stress one_year_stress
#> 1        7.175250        7.844337
#> 2        4.918343        5.527191
#> 3        4.634266        5.783046

# sequential t-test
results <- seq_ttest(df$one_year_stress,
                     df$baseline_stress,
                     alpha = alpha,
                     power = power,
                     d = d,
                     paired = paired,
                     alternative = alternative,
                     verbose = FALSE)

# print results
results@decision
#> [1] "continue sampling"
```

This process is repeated until the decision is made for one of the two
hypotheses. To simulate this sequential process, a while-loop embraces
the sequential *t*-test function in the code below, which will not stop
until one of the hypotheses is accepted or the maximum of the data is
reached.

``` r
# define the starting point
decision <- "continue sampling"
n_person <- 3

# simulation of the sequential procedure
while(decision == "continue sampling") {
  # get the current data
  df <- df_stress[1:n_person,]
  
  # run the sequential test and save the results
  results <- seq_ttest(df$one_year_stress,
                       df$baseline_stress,
                       alpha = alpha,
                       power = power,
                       d = d,
                       paired = paired,
                       alternative = alternative)
  # save the current desicion
  decision <- results@decision
  
  # add a new person
  n_person <- n_person + 1
  
  # break if the maximum of the data is reached
  if (n_person > nrow(df_stress)) {
    break
  }
}

# console output
results
#> 
#> *****  Sequential Paired t-test *****
#> 
#> formula: df$one_year_stress and  df$baseline_stress
#> test statistic:
#>  log-likelihood ratio = 2.988, decision = accept H1
#> SPRT thresholds:
#>  lower log(B) = -2.944, upper log(A) = 2.944
#> Log-Likelihood of the:
#>  alternative hypothesis = -2.238
#>  null hypothesis = -5.226
#> alternative hypothesis: true difference in means is greater than 0.
#> specified effect size: Cohen's d = 0.2
#> degrees of freedom: df = 47
#> sample estimates:
#> mean difference 
#>         0.47931 
#> *Note: to get access to the object of the results use the @ or [] instead of the $ operator.
```

The while-loop comes to an end after 48 data points.

### Report Results

``` r
# Required results for the report

# likelihood ratio (LR)
LR <- round(results@likelihood_ratio, digits = 2)
LR
#> [1] 19.85

# sample size (N) = degrees of freedom +2 (two-samples) or +1 (one-sample & paired)
N <- results@df + 1
N
#> [1] 48

# baseline stress (M and SD)
mean_t1 <- round(mean(df$baseline_stress), digits = 2)
mean_t1
#> [1] 4.99
sd_t1 <- round(sd(df$baseline_stress), digits = 2)
sd_t1
#> [1] 1.02

# after one year stress (M and SD)
mean_t2 <- round(mean(df$one_year_stress), digits = 2)
mean_t2
#> [1] 5.47
sd_t2 <- round(sd(df$one_year_stress), digits = 2)
sd_t2
#> [1] 1.53

# NOT INCLUDED IN THE PACKAGE 

# calculate effect size: Cohen´s d
d_results <- effsize::cohen.d(df$one_year_stress,
                 df$baseline_stress,
                 paired = TRUE)
d <- round(d_results$estimate, digits = 2)
d
#> [1] 0.34

# confidence intervall
d_lower <- round(d_results$conf.int[[1]], digits = 2)
d_lower
#> [1] 0.11
d_upper <- round(d_results$conf.int[[2]], digits = 2)
d_upper
#> [1] 0.57
```

Starting at *N* = 2, the test stops sampling at a total sample size of
*N* = 48 with *LR*₄₈ = 19.85. This ratio indicates that the data are
about 20 times more likely under H₁ than under H₀. Thus, we accept the
alternative hypothesis: The perceived stress at the second measurement
(*M* = 5.47, *SD* = 1.53) is higher than one year ago at the baseline
measurement (*M* = 4.99, *SD* = 1.02), Cohen\`s *d* = 0.34, 95% CI
\[0.11, 0.57\].[¹](#fn1)^(,)[²](#fn2)

## References

Schnuerch, M., Erdfelder, E., & Heck, D. W. (2020). Sequential
hypothesis tests for multinomial processing tree models. *Journal of
Mathematical Psychology*, *95*, 102326.
<https://doi.org/10.1016/j.jmp.2020.102326>

------------------------------------------------------------------------

1.  The citation style was taken from Schnuerch et al. (2020).

2.  Note that this estimate of Cohen’s d as well as the CI are based on
    the assumption of a fixed sample size and, thus, might be biased
    toward an overestimation of the true effect size. See for details
    Schnuerch et al. (2020).
