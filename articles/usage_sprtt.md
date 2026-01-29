# How to use the sprtt package

The `sprtt` package is a toolbox for **s**equential **p**robability
**r**atio **t**ests (SPRTs). This vignette introduces the core functions
and demonstrates a typical analysis workflow. For more comprehensive
guides on specific topics, see the other package vignettes. If you are
unfamiliar with SPRTs, please see the *XXX* section first.

- The data sets used below are included in the `sprtt` package. The data
  sets are available when the package is loaded.

- In the R code sections:

  - `# comment`: is a comment
  - `function()`: is R code
  - `#> results of function()`: is console output

## Workflow

### 1. Understand the theoretical background of SPRTs

The foundational literature (Hajnal, 1961; S. Rushton, 1950; S. Rushton,
1952; A. Wald, 1945; Abraham Wald, 1947) offers valuable depth but is
not required reading. However, understanding SPRT mechanics, robustness
to assumption violations, and proper application is essential. The
following papers provide a good background:

**Key references:**

- sequential *t*-tests: (**schnuerch2019?**) <doi:10.1037/met0000234>
- sequential one-way ANOVA: (**steinhilber2024?**)
  <doi:10.1037/met0000677>
- understanding questionable research practices in the context of SPRTs:
  (**steinhilber2025?**) <doi:10.31234/osf.io/vkbu3_v1>

For comparisons of different sequential designs (including SPRTs), see:

- Group sequential designs vs Sequential Bayes Factor Test vs SPRT
  (**schnuerch2019?**) <doi:10.1037/met0000234>
- Sequential Bayes Factor Test vs SPRT (**stefan2022?**)
  <doi:10.3758/s13428-021-01754-8>

### 2. Check if SPRTs are the fitting choice

Whether a statistical tool is appropriate depends strongly on the
research context and intended use. SPRTs are recommended when:

- Data can be collected sequentially
- Data can be analyzed sequentially (ideally after each new observation)
- The research question translates to a clear hypothesis test: \\H_0\\
  vs \\H_1\\ (is there an effect or not?)
- Resources are limited and efficiency is a priority
- Long-term error rates need to be controlled (both \\\alpha\\ and
  \\\beta\\ error rates)
- Accepting \\H_0\\ (no effect) is of interest

SPRTs are **not** recommended when:

- Sufficient literature already establishes the existence of the effect
  and the main goal is precise effect size estimation
- Multiple hypotheses must be tested on the same dataset (theoretically
  possible but not yet implemented)
- Data are collected all at once or only in very large batches
- Groups cannot be sampled somewhat equally over time (e.g., collecting
  all participants from one group before starting the other)

### 3. Plan your resources

The
[`plan_sample_size()`](https://meikesteinhilber.github.io/sprtt/reference/plan_sample_size.md)
function helps establish realistic expectations for data requirements
and resource planning.

Unlike traditional designs, SPRTs do not require classical a priori
power analysis because power (\\1-\beta\\) is controlled through the
stopping boundaries. This allows starting data collection immediately
and stopping once the test reaches a decision. However, planning
necessary resources remains important for practical concerns.

Two sample sizes are relevant:

- **Expected sample size** (\\N\_{\text{median}}\\): The median sample
  size required to reach a decision. Most studies will finish near this
  value.
- **Maximum sample size** (\\N\_{\text{max}}\\): The maximum affordable
  sample size. Choose settings where \\N\_{\text{max}}\\ yields a
  decision rate of at least 80% (i.e., the test reaches a decision in at
  least 80% of cases where the maximum sample is reached).

For more details see the vignette *XXX*.

### 4. Plan the data collection and register your test specifications

A thoughtful data collection plan is highly recommended to keep groups
somewhat balanced and to track and balance (or randomize) potential
confounders.

As SPRTs are best suited for confirmatory research, preregistering the
data collection plan, hypothesis, and test specifications (e.g., effect
size of interest, \\\alpha\\ and \\\beta\\ levels) is strongly
recommended.

Preparing an analysis script in advance enables a smooth process for
continuously analyzing incoming data. This ensures data collection stops
immediately once the stopping criterion is reached, avoiding unnecessary
additional data collection.

To test the analysis pipeline, use either:

- The example datasets included in the `sprtt` package
- The data generating functions, which allow specifying the true effect
  size for simulation testing

### 5. Collect the data and apply the SPRTs

The following test are currently implemented:

- sequential *t*-tests
- sequential one-way ANOVA with independent groups

See the vignettes for each test. *XXX*

### 5. Reporting of the results

Guidelines for the reporting of SPRTs can be found in the following
paper that also explicitly covers sequential testing and specifically
SPRTs (**schubert2025?**) <doi:10.1038/s44271-025-00356-w>.

## References

Hajnal, J. (1961). A two-sample sequential t-test. *Biometrika*,
*48*(1/2), 65–75. <https://doi.org/10.2307/2333131>

Rushton, S. (1950). On a sequential t-test. *Biometrika*, *37*, 326–333.
<https://doi.org/10.2307/2332385>

Rushton, S. (1952). On a Two-Sided Sequential t-Test. *Biometrika*,
*39*(3/4), 302. <https://doi.org/10.2307/2334026>

Wald, A. (1945). Sequential tests of statistical hypotheses. *The Annals
of Mathematical Statistics*, *16*(2), 117–186.

Wald, Abraham. (1947). *Sequential analysis*. Wiley.
