# Draw Samples from a Normal Distribution

**\[experimental\]**

Draws exemplary samples with a certain effect size for the sequential
one-oway ANOVA or the sequential t-test, see Steinhilber et al. (2023)
<doi:10.31234/osf.io/m64ne>

## Usage

``` r
draw_sample_normal(k_groups, f, max_n, sd = NULL, sample_ratio = NULL)
```

## Arguments

- k_groups:

  number of groups (levels of factor_A)

- f:

  Cohen's f. The simulated effect size.

- max_n:

  sample size for the groups (total sample size = max_n\*k_groups)

- sd:

  vector of standard deviations of the groups. Default value is 1 for
  each group.

- sample_ratio:

  vector of sample ratios between th groups. Default value is 1 for each
  group.

## Value

returns a data.frame with the columns y (observations) and x (factor_A).

## Examples

``` r
set.seed(333)

data <- sprtt::draw_sample_normal(
  k_groups = 2,
  f = 0.20,
  max_n = 2
)
data
#>             y x
#> 1 -2.25128979 1
#> 2  0.47773897 2
#> 3 -1.72596060 1
#> 4 -0.06916362 2

data <- sprtt::draw_sample_normal(
  k_groups = 4,
  f = 0,
  max_n = 2,
  sd = c(1, 2, 1, 8)
)
data
#>             y x
#> 1 -1.12490028 1
#> 2 -1.74860723 2
#> 3  0.04386162 3
#> 4 -4.67180114 4
#> 5 -0.82329858 1
#> 6  0.22118560 2
#> 7  0.36472778 3
#> 8  0.42960801 4

data <- sprtt::draw_sample_normal(
  k_groups = 3,
  f = 0.40,
  max_n = 2,
  sd = c(1, 0.8, 1),
  sample_ratio = c(1, 2, 3)
)
data
#>              y x
#> 1   1.49184945 1
#> 2  -0.76351823 2
#> 3  -0.24272397 2
#> 4  -0.56053126 3
#> 5   0.36241261 3
#> 6   1.02723505 3
#> 7   2.31369573 1
#> 8   0.13318761 2
#> 9  -1.94566881 2
#> 10 -1.03237731 3
#> 11 -0.02972369 3
#> 12  0.81988184 3
```
