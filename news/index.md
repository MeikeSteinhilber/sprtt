# Changelog

## sprtt 0.3.0

- Add:
  [`plan_sample_size()`](https://meikesteinhilber.github.io/sprtt/reference/plan_sample_size.md)
  creates HTML reports for sample size planning of sequential ANOVAs

- Add:
  [`download_sample_size_data()`](https://meikesteinhilber.github.io/sprtt/reference/download_sample_size_data.md)
  downloads the data required for
  [`plan_sample_size()`](https://meikesteinhilber.github.io/sprtt/reference/plan_sample_size.md)

- Add:
  [`load_sample_size_data()`](https://meikesteinhilber.github.io/sprtt/reference/load_sample_size_data.md)
  provides manual access to the simulation dataset used by
  [`plan_sample_size()`](https://meikesteinhilber.github.io/sprtt/reference/plan_sample_size.md)

- Add:
  [`cache_clear()`](https://meikesteinhilber.github.io/sprtt/reference/cache_clear.md)
  removes the cached simulation dataset used by
  [`plan_sample_size()`](https://meikesteinhilber.github.io/sprtt/reference/plan_sample_size.md)

- Add:
  [`cache_info()`](https://meikesteinhilber.github.io/sprtt/reference/cache_info.md)
  displays information about cached simulation data used by
  [`plan_sample_size()`](https://meikesteinhilber.github.io/sprtt/reference/plan_sample_size.md)

- **Breaking change:**
  [`plot_anova()`](https://meikesteinhilber.github.io/sprtt/reference/plot_anova.md)
  argument `position_lr_x` now uses absolute x-axis coordinates (e.g.,
  `position_lr_x = 30` places the label at x = 30) instead of relative
  positioning, providing more intuitive and precise control of label
  placement.

- Add:
  [`plot_anova()`](https://meikesteinhilber.github.io/sprtt/reference/plot_anova.md)
  gains new argument `position_lr_y` to control the y-axis position of
  the likelihood ratio label using absolute coordinates.

- Change: Internal function documentation improved throughout the
  package

## sprtt 0.2.0

CRAN release: 2023-07-06

- Add: the
  [`seq_anova()`](https://meikesteinhilber.github.io/sprtt/reference/seq_anova.md)
  function, which performs a sequential one-way fixed effects ANOVA

- Add:
  [`draw_sample_normal()`](https://meikesteinhilber.github.io/sprtt/reference/draw_sample_normal.md)
  function, which simulates data for a sequential ANOVA using normal
  distributions.

- Add:
  [`draw_sample_mixture()`](https://meikesteinhilber.github.io/sprtt/reference/draw_sample_mixture.md)
  function, which simulates data for a sequential ANOVA using Gaussian
  Mixture distributions

- Add:
  [`plot_anova()`](https://meikesteinhilber.github.io/sprtt/reference/plot_anova.md)
  plot function for the results of the
  [`seq_anova()`](https://meikesteinhilber.github.io/sprtt/reference/seq_anova.md)
  function.

- Bug fix: update text in show(), if `mu` is not equal to 0

- Change: sprtt logo

## sprtt 0.1.0

CRAN release: 2021-08-06

- Added the
  [`seq_ttest()`](https://meikesteinhilber.github.io/sprtt/reference/seq_ttest.md)
  function, which performs sequential *t*-tests

- Added the test datasets `df_income`, `df_cancer` and `df_stress`

- Added the vignette “How to use the `sprtt` package”

- Added the vignette “Sequential *t*-test”

- Added the vignette “Use Case”

- Added tests to simulate the error rates of the test

- Added unit tests

- Added pkgdown site

- Added logo
