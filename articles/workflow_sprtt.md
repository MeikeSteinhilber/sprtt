# How to use the sprtt package?

The `sprtt` package is a toolbox for **s**equential **p**robability
**r**atio **t**ests (SPRTs). This vignette introduces the core functions
and demonstrates a typical analysis workflow. For more comprehensive
guides on specific topics, see the other package vignettes. If you are
unfamiliar with SPRTs, please read first the vignette
[`vignette("sprt")`](https://meikesteinhilber.github.io/sprtt/articles/sprt.md).

## Workflow

### 1. Understand the theoretical background of SPRTs

The foundational literature (Wald, 1945, 1947) established the
mathematical framework for SPRTs. While these original papers provide
theoretical depth, they require strong mathematical statistics
background and focus primarily on abstract theory rather than practical
application.

For practical implementation, we strongly recommend starting with the
following simulation studies, which demonstrate robustness to assumption
violations, explain common pitfalls, and provide actionable guidance:

**Essential reading:**

- **Sequential *t*-tests**: Schnuerch & Erdfelder (2020) — Demonstrates
  performance under various assumption violations and provides practical
  guidance
- **Sequential one-way ANOVA**: Steinhilber et al. (2024) — Extends
  SPRTs to the one-way ANOVA design with comprehensive simulation
  evidence
- **Understanding questionable research practices in sequential
  designs**: Steinhilber et al. (2025) — Critical for avoiding misuse
  and ensuring appropriate application

For comparisons of different sequential designs (including SPRTs), see:

- Schnuerch & Erdfelder (2020) – Group sequential designs vs Sequential
  Bayes Factor Test vs SPRT
- Stefan et al. (2022) – Sequential Bayes Factor Test vs SPRT

### 2. When to use SPRTs

Whether a statistical tool is appropriate depends strongly on the
research context and intended use. SPRTs are recommended when:

- Resources are limited and efficiency is a priority
- The research question translates to a clear hypothesis test:
  Concluding in favor of either \\H_0\\ (no effect) or \\H_1\\ (effect)
  provides useful information for your research question.
- Data can be collected sequentially
- Data can be analyzed sequentially (ideally after each new observation)
- Long-term error rates need to be controlled (both \\\alpha\\ and
  \\\beta\\ error rates)

SPRTs are **not** recommended when:

- Data are collected all at once or only in very large batches, see here
  fixed designs or Group Sequential Designs
- Multiple hypotheses must be tested on the same dataset (theoretically
  possible but not yet implemented)
- Groups cannot be sampled somewhat equally over time (e.g., collecting
  all participants from one group before starting the other)
- Sufficient literature already establishes the existence of the effect
  and the main goal is precise effect size estimation (see Steinhilber
  et al. (2024))

### 3. Plan your resources

The
[`plan_sample_size()`](https://meikesteinhilber.github.io/sprtt/reference/plan_sample_size.md)
function helps establish realistic expectations for data requirements
and resource planning.

Unlike traditional designs, SPRTs do not require classical a priori
power analysis. Power is controlled through the stopping boundaries,
allowing you to start data collection immediately and stop once the test
reaches a decision.

However, resource planning remains essential. While the boundaries
control \\\alpha\\ and \\\beta\\ error rates in the long run, they
cannot guarantee you will collect enough data to reach a decision within
your available resources.

Two sample sizes are relevant for planning:

- **Expected sample size** (\\N\_{\text{median}}\\): The median sample
  size required to reach a decision. Most studies will finish near this
  value.
- **Maximum sample size** (\\N\_{\text{max}}\\): The maximum affordable
  sample size. Choose settings where \\N\_{\text{max}}\\ yields a
  decision rate of at least 80% (i.e., the test reaches a decision in at
  least 80% of cases where the maximum sample is reached).

The
[`plan_sample_size()`](https://meikesteinhilber.github.io/sprtt/reference/plan_sample_size.md)
function provides tables and plots to help you find appropriate design
parameters that balance efficiency with feasibility.

For detailed examples and guidance, see the vignette
[`vignette("plan_sample_size")`](https://meikesteinhilber.github.io/sprtt/articles/plan_sample_size.md).

### 4. Plan the data collection and register your test specifications

A thoughtful data collection plan is highly recommended to keep groups
somewhat balanced and to track and balance (or randomize) potential
confounders.

**Outliers**

The question of how one should deal with outliers in sequential testing
is still an ongoing research topic. Note, that implementing a naive
sequential outlier analysis can lead to a inflation of the \\\alpha\\
error rate, see Steinhilber et al. (2025).

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

- sequential *t*-tests, see
  [`vignette("t_test")`](https://meikesteinhilber.github.io/sprtt/articles/t_test.md)
- sequential one-way ANOVA with independent groups, see
  [`vignette("one_way_anova")`](https://meikesteinhilber.github.io/sprtt/articles/one_way_anova.md)

### 5. Reporting of the results

Guidelines for the reporting of SPRTs can be found in the paper of
Schubert et al. (2025) that also explicitly covers sequential testing
and specifically SPRTs.

A complete SPRT report should include: the specific variant of the SPRT
used (e.g., sequential *t*-test), the \\\alpha\\ and \\\beta\\ levels,
the effect size or other parameters specifying the alternative
hypothesis, the starting point of the SPRT (the sample size at the first
look), the final sample size when data collection was stopped, the final
likelihood ratio, a plot showing the full likelihood progression across
all looks, and an effect size estimate with confidence interval
(Schubert et al., 2025). Note that effect size estimates in sequential
designs are often biased and should be interpreted with caution.

**Example report — decision reached (\\H_1\\ accepted):**

> We preregistered a sequential *t*-test (Schnuerch & Erdfelder, 2020;
> Wald, 1945) with error probabilities \\\alpha = .05\\ and \\\beta =
> .05\\, and a minimum effect size of interest of \\d = 0.5\\. The first
> look took place at \\n = 5\\ per group. Data collection stopped at \\N
> = 48\\ (24 per group) when the likelihood ratio crossed the upper
> decision boundary (\\LR\_{48} = 21.3 \> B = 19\\), providing
> sufficient evidence to accept \\H_1\\. The estimated effect size was
> \\d = 0.61\\ (95% CI \[0.21, 1.00\]). A plot of the full likelihood
> progression is provided in Figure X. All materials and the
> preregistration are available at \[OSF link\].

**Example report — \\N\_{max}\\ reached (non-decision):**

> We preregistered a sequential *t*-test (Schnuerch & Erdfelder, 2020;
> Wald, 1945) with error probabilities \\\alpha = .05\\ and \\\beta =
> .05\\, a minimum effect size of interest of \\d = 0.5\\, and a maximum
> sample size of \\N\_{max} = 200\\ (100 per group). The first look took
> place at \\n = 4\\ per group. Data collection stopped upon reaching
> \\N\_{max} = 200\\ without the likelihood ratio crossing either
> decision boundary (\\LR\_{200} = 3.1\\; lower boundary \\A = 1/19\\,
> upper boundary \\B = 19\\). This constitutes a non-decision: the
> accumulated evidence was insufficient to accept either \\H_0\\ or
> \\H_1\\ with the prespecified error control. The results are therefore
> inconclusive, though the final likelihood ratio indicates that the
> data are 3.1 times more likely under \\H_1\\ than under \\H_0\\. Note
> that a non-decision due to resource depletion does not constitute
> evidence for \\H_0\\. The estimated effect size was \\d = 0.21\\ (95%
> CI \\\[-0.07, 0.49\]\\). A plot of the full likelihood progression is
> provided in Figure X.

## References

Schnuerch, M., & Erdfelder, E. (2020). Controlling decision errors with
minimal costs: The sequential probability ratio t test. *Psychological
Methods*, *25*(2), 206–226. <https://doi.org/10.1037/met0000234>

Schubert, A.-L., Steinhilber, M., Kang, H., & Quintana, D. (2025).
*Improving statistical reporting in psychology*. OSF. https://doi.
org/10.31234/osf. io/5gr9n_v.

Stefan, A. M., Schönbrodt, F. D., Evans, N. J., & Wagenmakers, E.-J.
(2022). Efficiency in sequential testing: Comparing the sequential
probability ratio test and the sequential Bayes factor test. *Behavior
Research Methods*, *54*(6), 3100–3117.
<https://doi.org/10.3758/s13428-021-01754-8>

Steinhilber, M., Schnuerch, M., & Schubert, A.-L. (2024). Sequential
analysis of variance: Increasing efficiency of hypothesis testing.
*Psychological Methods*. <https://doi.org/10.1037/met0000677>

Steinhilber, M., Schnuerch, M., & Schubert, A.-L. (2025). *The Dark Side
of Sequential Testing: A Simulation Study on Questionable Research
Practices*. PsyArXiv. <https://doi.org/10.31234/osf.io/vkbu3_v1>

Wald, A. (1945). Sequential tests of statistical hypotheses. *The Annals
of Mathematical Statistics*, *16*(2), 117–186.

Wald, A. (1947). *Sequential analysis*. Wiley.
