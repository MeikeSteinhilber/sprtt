# Sequential t-Test

## Overview

The `sprtt` package is a **s**equential **p**robability **r**atio
**t**ests **t**oolbox (**sprtt**). This vignette describes the
theoretical background of these tests.

Other recommended vignettes cover:

- a [general
  guide](https://meikesteinhilber.github.io/sprtt/articles/usage-sprtt.html),
  how to use the package and

- an extended [use
  case](https://meikesteinhilber.github.io/sprtt/articles/use-case.html).

## What is a sequential test procedure?

With a sequential approach, data is continuously collected and an
analysis is performed after each data point, which can lead to three
different results (A. Wald, 1945):

- The data collection is *terminated* because enough evidence has been
  collected for the null hypothesis (H₀).

- The data collection is *terminated* because enough evidence has been
  collected for the alternative hypothesis (H₁).

- The data collection *will continue* as there is not yet enough
  evidence for either of the two hypotheses.

Basically it is not necessary to perform an analysis after each data
point — several data points can also be added at once. However, this
affects the sample size (N) and the error rates (Schnuerch et al.,
2020).

The efficiency of sequential designs has already been examined.
Reductions in the sample by 50% and more were found in comparison to
analyses with fixed sample sizes (Schnuerch et al., 2020; A. Wald,
1945). Sequential hypothesis testing is therefore particularly suitable
when resources are limited because the required sample size is reduced
without compromising predefined error probabilities.

## What is the sequential *t*-test?

The sequential *t*-test is based on the Sequential Probability Ratio
Test (SPRT) by Abraham Abraham Wald (1947), which is a highly efficient
sequential hypothesis test. However, the usage of Wald´s SPRT is limited
in the case of normally distributed data, because the variance has to be
known or specified in the hypothesis. Rushton (1950; **rushton1952?**)
and Hajnal (1961) have further developed the SPRT using the
*t*-statistic. The basic idea is to transform the sequence of
observations (which is dependent on the variance) into a sequence of the
associated *t*-statistic (which is *in*dependent of the variance).

In the SPRT the null and alternative hypotheses are defined as follows,
with 𝜃 representing the model parameter :

\$\$ H_0:\\ 𝜃\\ =\\ 𝜃_0 \\ H_1:\\ 𝜃\\ =\\ 𝜃_1 \$\$

The test statistic of the SPRT is based on a likelihood ratio, which is
a measure of the relative evidence in the data for the given hypotheses.
More specifically, it is the ratio of the likelihood of the alternative
hypothesis to the likelihood of the null hypothesis at the *m*-th step
of the sampling process (LR_(m)).

$$LR_{m} = \frac{f\left( data_{m}|H_{1} \right)}{f\left( data_{m}|H_{0} \right)} = \frac{f\left( x_{1},...,x_{m}|\theta_{1} \right)}{f\left( x_{1},...,x_{m}|\theta_{0} \right)}$$

Before the transformation into the *t*-statistic, the model parameter 𝜃
contains the parameters of a normal distribution: the mean (*µ*) and the
standard deviation (𝜎). Therefore, the Wald SPRT requires prior
knowledge about the variance (𝜎²) or a specification in the hypotheses.

After the transformation of the observed values into the associated
t-statistic, the model parameter 𝜃 contains the parameters of the
non-central t-distribution: the degrees of freedom (*df*) and the
non-centrality parameter (𝛥).

$${f\left( x_{1},...,x_{m}|µ,\sigma \right)} = > {f\left( t_{2},...,t_{m}|df,{\mathit{Δ}} \right)}$$

For the calculation of the degrees of freedom, only the sample size of
the group(s) is needed. The non-centrality parameter also requires a
specification of the expected effect size in form of Cohen\`s d (*d*).

To eventually calculate the LR of the sequential *t*-test, only the
current t_(*m*)-statistic is necessary. Rushton (1950) demonstrated that
an SPRT can be performed by simply considering the ratio of probability
densities for the most recent t_(*m*) statistic under the alternative
and null hypothesis at any *m-*th stage. Thus, the test statistic for a
one and two-sided sequential t-test can be calculated as follows:

\$\$ LR\_{m,\\ one-sided\\ sequential\\ t-test} = \frac {𝑓(t_m \| 𝜃_1)}
{𝑓(t_m \| 𝜃_0)} \\ LR\_{m,\\ two-sided\\ sequential\\ t-test} = \frac
{𝑓(t_m^2 \| 𝜃_1)} {𝑓(t_m^2 \| 𝜃_0)}. \$\$

To account for the fact that the algebraic sign is unknown in a
two-sided test, the *t*-value is squared (**rushton1952?**).

After the calculation of the test statistic, the decision will be either
to continue sampling or to terminate the sampling and accept one of the
hypotheses. A. Wald (1945) defined the following rules for the SPRT:

|    Condition     |                Decision |
|:----------------:|------------------------:|
|    LR_(m) ≤ B    | accept H₀ and reject H₁ |
| B \< LR_(m) \< A |       continue sampling |
|    LR_(m) ≤ A    | accept H₁ and reject H₀ |

The A and B boundaries are calculated with the previously defined error
rates 𝛼 (Type I error) and 𝛽 (Type II error) as follows:

\$\$ A = \left( \frac{1 - 𝛽}{𝛼} \right) \\ B = \left( \frac{𝛽}{1 - 𝛼}
\right). \$\$

In summary, three specifications are required to calculate a sequential
*t*-test:

- the 𝛼 error probability (usually 0.05 or less),

- the 𝛽 error probability (usually .20 or less), and

- Cohen´s d (either as the expected effect size or as the lower limit
  for a substantial effect).

## References

Hajnal, J. (1961). A two-sample sequential t-test. *Biometrika*,
*48*(1/2), 65–75. <https://doi.org/10.2307/2333131>

Rushton, S. (1950). On a sequential t-test. *Biometrika*, *37*, 326–333.
<https://doi.org/10.2307/2332385>

Schnuerch, M., Erdfelder, E., & Heck, D. W. (2020). Sequential
hypothesis tests for multinomial processing tree models. *Journal of
Mathematical Psychology*, *95*, 102326.
<https://doi.org/10.1016/j.jmp.2020.102326>

Wald, A. (1945). Sequential tests of statistical hypotheses. *The Annals
of Mathematical Statistics*, *16*(2), 117–186.

Wald, Abraham. (1947). *Sequential analysis*. Wiley.
