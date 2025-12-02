# Draw Samples from a Gaussian Mixture Distribution

**\[experimental\]**

Draws exemplary samples with a certain effect size for the sequential
one-oway ANOVA or the sequential t-test, see Steinhilber et al. (2023)
<doi:10.31234/osf.io/m64ne>

## Usage

``` r
draw_sample_mixture(k_groups, f, max_n, counter_n = 100, verbose = FALSE)
```

## Arguments

- k_groups:

  number of groups (levels of factor_A)

- f:

  Cohen's f. The simulated effect size.

- max_n:

  sample size for the groups (total sample size = max_n\*k_groups)

- counter_n:

  number of times the function tries to find a possible parameter
  combination for the distribution. Default value is set to 100.

- verbose:

  `TRUE` or `FALSE.` Print out more information about the internal
  process of sampling the parameters (the internal counter that was
  reached, some additional hints and the drawn parameters for the
  Gaussian Mixture distributions.)

## Value

returns a data.frame with the columns y (observations) and x (factor_A).

## Examples

``` r
set.seed(333)

data <- sprtt::draw_sample_mixture(
  k_groups = 2,
  f = 0.40,
  max_n = 2
)
data
#>             y x
#> 1 -0.35195917 1
#> 2  0.65107923 2
#> 3  1.13464217 1
#> 4  0.06825929 2

data <- sprtt::draw_sample_mixture(
  k_groups = 4,
  f = 1.2, # very large effect size
  max_n = 4,
  counter_n = 1000, # increase of counter is necessary
  verbose = TRUE # prints more information to the console
)
#> Internal counter reached = 54
#> 
#> group1:
#> mean1 = -1.99074652277088, mean2 = -0.428610482246108,
#> sigma1 = 0.834923571040213, sigma2 = 0.287694501108814
#> 
#> group2:
#> mean1 = 1.23360638346966, mean2 = 0.129657848600828,
#> sigma1 = 1.05769847648328, sigma2 = 0.521462126165875
#> 
#> group3:
#> mean1 = -2.04772209975713, mean2 = -0.141818342492629,
#> sigma1 = 0.424153872448029, sigma2 = 0.0621202584498169
#> 
#> group4:
#> mean1 = 2.60899963472551, mean2 = 0.636633580470748,
#> sigma1 = 0.224572574962626, sigma2 = 0.0667325451814857
data
#>             y x
#> 1  -3.5762655 1
#> 2   0.7385727 2
#> 3  -0.1367248 3
#> 4   0.6237656 4
#> 5  -0.7708177 1
#> 6   1.0060454 2
#> 7  -1.7081033 3
#> 8   0.6918255 4
#> 9  -2.4084128 1
#> 10  0.1284941 2
#> 11 -1.9372623 3
#> 12  2.5216276 4
#> 13 -2.0195175 1
#> 14 -0.1744742 2
#> 15 -2.1017450 3
#> 16  0.6802637 4
```
