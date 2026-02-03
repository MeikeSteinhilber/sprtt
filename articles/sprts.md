# Introduction to SPRTs

The `sprtt` package is a **s**equential **p**robability **r**atio
**t**ests **t**oolbox (**sprtt**). This vignette describes the
theoretical background of these tests.

If you are interested in a workflow to use the `sprtt` package, see the
vignette
[`vignette("workflow_sprtt")`](https://meikesteinhilber.github.io/sprtt/articles/workflow_sprtt.md).
For a simple use case of a sequential *t*-test see the vignette
[`vignette("use_case")`](https://meikesteinhilber.github.io/sprtt/articles/use_case.md).

### The Sequential Testing Principle

Sequential Probability Ratio Tests (SPRTs) fundamentally differ from
fixed-sample designs by continuously evaluating evidence as data
accumulates (A. Wald, 1945). After collecting each data point (or batch
of data points), the test leads to one of three outcomes:

- **Stop and accept \\H_0\\** (no effect): Sufficient evidence
  accumulated against an effect
- **Stop and accept \\H_1\\** (effect): Sufficient evidence accumulated
  for an effect  
- **Continue sampling**: Evidence remains inconclusive

This approach allows researchers to stop data collection as soon as
sufficient evidence has been obtained, leading to substantial efficiency
gains compared to fixed-sample designs.

### The Likelihood Ratio and Decision Boundaries

At the core of SPRTs is the *likelihood ratio* \\\text{LR}\_n\\, which
quantifies the relative evidence for \\H_1\\ versus \\H_0\\ after \\n\\
observations:

\\\text{LR}\_n = \frac{P(\text{data} \mid H_1)}{P(\text{data} \mid
H_0)}\\

The SPRT compares this likelihood ratio to two boundaries:

- **Upper boundary** \\A\\: If \\\text{LR}\_n \geq A\\, stop and accept
  \\H_1\\
- **Lower boundary** \\B\\: If \\\text{LR}\_n \leq B\\, stop and accept
  \\H_0\\
- **Continue**: If \\B \< \text{LR}\_n \< A\\, collect more data

These boundaries are determined by the desired Type I (\\\alpha\\) and
Type II (\\\beta\\) error rates:

\\A = \frac{1-\beta}{\alpha} \quad \text{and} \quad B =
\frac{\beta}{1-\alpha}\\

In practice, it is often more convenient to work with the log-likelihood
ratio \\\text{LLR}\_n = \log(\text{LR}\_n)\\. The logarithm transforms
products of likelihoods into sums, which improves numerical stability
(avoiding very small or very large numbers) and simplifies computation.

The corresponding log-boundaries are:

\\\text{LLR}\_n \geq \log(A) \rightarrow \text{accept } H_1\\

\\\text{LLR}\_n \leq \log(B) \rightarrow \text{accept } H_0\\

The `sprtt` package uses the \\\text{LLR}\_n\\ for the internal
calculations.

### Random Sample Size

Unlike fixed-sample designs where \\N\\ is predetermined, the sample
size in SPRTs is a random variable. You don’t know beforehand when the
test will stop—it depends on:

- The true effect size in the population
- Random variation in the observed data
- The specified error rates (\\\alpha\\, \\\beta\\)
- The effect size specified under \\H_1\\

When the true effect matches \\H_1\\ (or \\H_0\\), the test tends to
stop quickly. When the truth lies between the hypotheses, stopping may
take longer. This randomness is a feature, not a bug—it’s what enables
the efficiency gains.

### Why SPRTs Always Stop

A crucial theoretical property of SPRTs is that they are *guaranteed to
terminate* with probability 1 under both \\H_0\\ and \\H_1\\ (Abraham
Wald, 1947). This means that if you continue collecting data, the
likelihood ratio will eventually cross one of the boundaries – you won’t
collect data indefinitely.

The mathematical proof relies on the law of large numbers and properties
of random walks. However, while termination is guaranteed
asymptotically, practical constraints (budget, time) may require setting
a maximum sample size \\N\_{\text{max}}\\ based on available resources.
The
[`plan_sample_size()`](https://meikesteinhilber.github.io/sprtt/reference/plan_sample_size.md)
function helps determine the required \\N\_{\text{max}}\\ for a given
design, ensuring a desired decision rate (e.g., 80%) is achieved, that
is, the test reaches a decision before exhausting resources in at least
80% of cases.

### Efficiency

SPRTs achieve remarkable efficiency compared to fixed-sample designs (A.
Wald, 1945). On average, SPRTs require approximately *58% fewer
observations* to reach the same decision with the same error rates
(Steinhilber et al., 2024).

Additionally, SPRTs are especially efficient compare to fixed-sample
designs, when the expected effect (or effect size of interest) is small
and when the expected effect is smaller than the true effect in the data
(Steinhilber et al., 2024).

### The Bias-Efficiency Tradeoff

While SPRTs are highly efficient, they come with an important caveat:
effect size estimates are conditionally biased (Schnuerch & Erdfelder,
2020; Steinhilber et al., 2024).

**Small samples** (early stops): lead to *overestimation* of effect
sizes in single studies.

**Large samples** (late stops): lead to *underestimation* of effect
sizes in single studies.

However, across multiple studies, the weighted average of effect size
estimates is close to the true population parameter.

This means that effect size estimates from individual SPRT studies
should be interpreted with caution. It is important to note that
conditional bias of sequential samples is not specific to SPRTs but a
general phenomenon of sequential testing procedures (Fan et al., 2004;
Nardini & Sprenger, 2013; Whitehead, 1986).

**Practical implications:**

- Use SPRTs for hypothesis testing (accept/reject decisions)
- Be cautious when interpreting point estimates from individual
  sequential studies
- For precise effect size estimation, consider fixed-sample designs with
  large enough samples or bias-corrected estimators, where available

### Practical Considerations

While SPRTs theoretically continue until a boundary is crossed,
practical constraints require planning. The `sprtt` package provides
tools to explore these tradeoffs through the
[`plan_sample_size()`](https://meikesteinhilber.github.io/sprtt/reference/plan_sample_size.md)
function, helping you find designs that balance efficiency with
feasibility.

### References

Fan, X. (Frank)., DeMets, D. L., & Lan, K. K. G. (2004). Conditional
bias of point estimates following a group sequential test. *Journal of
Biopharmaceutical Statistics*, *14*(2), 505–530.
<https://doi.org/10.1081/BIP-120037195>

Nardini, C., & Sprenger, J. (2013). Bias and Conditioning in Sequential
Medical Trials. *Philosophy of Science*, *80*(5), 1053–1064.
<https://doi.org/10.1086/673732>

Schnuerch, M., & Erdfelder, E. (2020). Controlling decision errors with
minimal costs: The sequential probability ratio t test. *Psychological
Methods*, *25*(2), 206–226. <https://doi.org/10.1037/met0000234>

Steinhilber, M., Schnuerch, M., & Schubert, A.-L. (2024). Sequential
analysis of variance: Increasing efficiency of hypothesis testing.
*Psychological Methods*. <https://doi.org/10.1037/met0000677>

Wald, A. (1945). Sequential tests of statistical hypotheses. *The Annals
of Mathematical Statistics*, *16*(2), 117–186.

Wald, Abraham. (1947). *Sequential analysis*. Wiley.

Whitehead, J. (1986). On the bias of maximum likelihood estimation
following a sequential test. *Biometrika*, *73*(3), 573–581.
