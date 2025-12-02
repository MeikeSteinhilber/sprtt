# SPRTs

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
different results (Wald, 1945):

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
analyses with fixed sample sizes (Schnuerch et al., 2020; Wald, 1945).
Sequential hypothesis testing is therefore particularly suitable when
resources are limited because the required sample size is reduced
without compromising predefined error probabilities.

Schnuerch, M., Erdfelder, E., & Heck, D. W. (2020). Sequential
hypothesis tests for multinomial processing tree models. *Journal of
Mathematical Psychology*, *95*, 102326.
<https://doi.org/10.1016/j.jmp.2020.102326>

Wald, A. (1945). Sequential tests of statistical hypotheses. *The Annals
of Mathematical Statistics*, *16*(2), 117–186.
