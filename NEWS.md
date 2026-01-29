# sprtt 0.3.0

-   Add: `plan_sample_size()` creates HTML reports for sample size planning of sequential ANOVAs

-   Add: `download_sample_size_data()` downloads the data required for `plan_sample_size()`

-   Add: `load_sample_size_data()` provides manual access to the simulation dataset used by `plan_sample_size()`

-   Add: `cache_clear()` removes the cached simulation dataset used by `plan_sample_size()`

-   Add: `cache_info()` displays information about cached simulation data used by `plan_sample_size()`

-   **Breaking change:** `plot_anova()` argument `position_lr_x` now uses absolute x-axis coordinates (e.g., `position_lr_x = 30` places the label at x = 30) instead of relative positioning, providing more intuitive and precise control of label placement.

-   Add: `plot_anova()` gains new argument `position_lr_y` to control the y-axis position of the likelihood ratio label using absolute coordinates.

-   Change: Internal function documentation improved throughout the package


# sprtt 0.2.0

-   Add: the `seq_anova()` function, which performs a sequential one-way fixed effects ANOVA

-   Add: `draw_sample_normal()` function, which simulates data for a sequential ANOVA using normal distributions.

-   Add: `draw_sample_mixture()` function, which simulates data for a sequential ANOVA using Gaussian Mixture distributions

-   Add: `plot_anova()` plot function for the results of the `seq_anova()` function.

-   Bug fix: update text in show(), if `mu` is not equal to 0

-   Change: sprtt logo


# sprtt 0.1.0

-   Added the `seq_ttest()` function, which performs sequential *t*-tests

-   Added the test datasets `df_income`, `df_cancer` and `df_stress`

-   Added the vignette "How to use the `sprtt` package"

-   Added the vignette "Sequential *t*-test"

-   Added the vignette "Use Case"

-   Added tests to simulate the error rates of the test

-   Added unit tests

-   Added pkgdown site

-   Added logo
