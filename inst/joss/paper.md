---
title: 'sprtt: An R Package and Toolbox for Sequential Probability Ratio Tests'
tags:
  - R
  - sequential testing
  - sequential probability ratio test
  - SPRT
  - sequential ANOVA
authors:
  - name: Meike Snijder-Steinhilber
    orcid: 0000-0002-7144-2100
    affiliation: "1" 
  - name: Martin Schnuerch
    orcid: 0000-0001-6531-2265
    affiliation: "2"
  - name: Anna-Lena Schubert
    orcid: 0000-0001-7248-0662
    affiliation: "2"
affiliations:
 - name: University of Mainz, Germany
   index: 1
 - name: University of Mannheim, Germany
   index: 2
date: 28 February 2026
bibliography: references.bib
---

# Summary
[//]: # (*A description of the high-level functionality and purpose of the software for a diverse, non-specialist audience.*)

The `sprtt` package provides a toolbox for Sequential Probability Ratio Tests (SPRTs), implementing modern variants including sequential *t*-tests and sequential ANOVA for applied and methodological research. 
While traditional fixed-sample designs require researchers to commit to a predetermined sample size, SPRTs enable continuous evidence evaluation with predefined stopping rules — terminating data collection as soon as evidence crosses a threshold for rejecting or accepting the null hypothesis.
Crucially, this flexibility comes without inflating long-run Type I and Type II error rates beyond the levels specified in advance.
On average, this sequential approach requires 50% fewer observations than a comparable Neyman-Pearson fixed-sample design [@wald1945].

Wald's original SPRTs were constructed for simple hypotheses, but newer variants extend these methods to composite hypotheses through sequential *t*-tests and sequential ANOVA -- designs that are standard in fields like psychology and medicine.
[XXX needs to be checked again!]
Because Wald's mathematical proofs do not directly apply to these extensions, their error rate control and efficiency cannot be guaranteed analytically [@wald1945; @schnuerch2020].
In practice, error rate control is approximate and has been validated through extensive simulation studies under a range of conditions [@schnuerch2020; @steinhilber2024; @stefan2022].
Despite the long history of SPRTs, the `sprtt` package is the first to provide accessible software implementations for both sequential *t*-tests [@rushton1950; @hajnal1961] and sequential ANOVA [@wetherill1986; @steinhilber2024].
The package implements these validated procedures and additionally provides example datasets, data generating functions, sample size planning, and visualization tools to facilitate the adoption of SPRTs in applied research.


# Statement of need and research impact

[//]: # (*A section that clearly illustrates the research purpose of the software and places it in the context of related work. This should clearly state what problems the software is designed to solve, who the target audience is, and its relation to other work.*)

[//]: # (*Evidence of realized impact (publications, external use, integrations) or credible near-term significance (benchmarks, reproducible materials, community-readiness signals). The evidence should be compelling and specific, not aspirational.*)

Due to the replication crisis [@opensciencecollaboration2015; @ioannidis2005; @bogdan2025] in empirical fields like psychology and medicine, statistical procedures have been scrutinized and new alternatives have gained attention [XXX].
Sequential testing methods have become increasingly popular in recent years as they directly address one of the most pressing demands in empirical research: the need to minimize resource expenditure and participant burden without sacrificing statistical rigor [@schnuerch2020; @stefan2022; @steinhilber2024].
This is relevant across all empirical research, and particularly vital in clinical and applied settings where continued data collection can carry real ethical costs.
Among sequential testing procedures, SPRTs are theoretically well-established [@wald1947; @erdfelder2021; XXX], and specific variants for the statistical tests commonly used in psychological research — such as the sequential *t*-test and sequential ANOVA — have recently been formally validated in simulation studies [@schnuerch2020; @steinhilber2024].
However, to our knowledge, no dedicated and maintained software implementation of these specific variants existed prior to the `sprtt` package, with the exception of a bare R script provided alongside the original methodological work [@schnuerch2020].
Translating promising statistical methods into accessible, user-friendly, and open-source software is therefore essential for closing the gap between methodological development and adoption in practice.

The `sprtt` package was first published on CRAN in 2021 and has since accumulated close to 13,000 downloads, averaging approximately 200 downloads per month in the 12 months preceding March 2026 [@steinhilber2023a].
The package has been used in applied research [@quevedoputter2022], simulation studies [@steinhilber2024; @steinhilber2025], and has been referenced in methodological work [@schubert2025a; fischer2025].
The target audience includes applied researchers using SPRT variants in their empirical work, as well as methodologists conducting simulation studies to gain further insights into the properties of SPRTs.

![Monthly CRAN downloads of the `sprtt` package since its first release in August 2021. Dashed vertical lines indicate CRAN release versions. The LOESS trend line with 95% confidence band reflects the overall download trajectory across complete months.](sprtt_downloads.png)

# State of the field                                                                                                                  
[//]: # (*A description of how this software compares to other commonly-used packages in the research area. If related tools exist, provide a clear “build vs. contribute” justification explaining your unique scholarly contribution and why existing alternatives are insufficient.*)

The landscape of sequential testing software is sparse.
Beyond R, no established software packages for SPRTs appear to exist, though several major technology companies including Netflix, Uber, and Spotify have either published on SPRTs or stated their use, suggesting that proprietary implementations exist in industry [@bibaut2024].
In R the package `SPRT` implements Wald's original sequential test for simple hypotheses, the `gsDesign` package provides a `binomialSPRT()` function for truncated binomial SPRTs, and the `MSPRT` and the `Sequential` packages cover a variety of truncated SPRT variants.
To our knowledge, no publicly available software implements sequential *t*-tests or sequential one-way ANOVA as described by @schnuerch2020 and @steinhilber2024.
The `sprtt` package fills this gap directly.

# Software design

[//]: # (*An explanation of the trade-offs you weighed, the design/architecture you chose, and why it matters for your research application. This should demonstrate meaningful design thinking beyond a superficial code structure description.*)

The sprtt package is built around two main user-facing functions:
`seq_ttest()` and `seq_anova()`.
The `seq_ttest()` function implements the sequential *t*-test and deliberately mirrors the interface of the `t.test()` function from the `stats` package to ensure familiarity for R users.
The `seq_anova()` function follows a similar design philosophy, maintaining consistency across the package's interface.

## Design principle

The core design principle is modularity: each internal function should perform one task well.
This approach emphasizes simplicity, testability, clear structure, and minimal code repetition.
The internal architecture of the core functions are documented in more detail in the developer vignette.

While the primary focus remains on implementing well-tested SPRT variants with proven efficiency and error rate control, the package continuously expands its functionality to improve user experience.
Supporting features include example datasets, data simulation functions, visualization tools for sequential ANOVA results, and sample size planning for sequential ANOVA.
The `lifecycle` package is used throughout to clearly communicate the maturity status of each function — an important consideration for research software where interface stability directly affects reproducibility.
The core functions `seq_ttest()`, `seq_anova()`, and the data simulation utilities are stable: we commit to not introducing silent breaking changes to these functions.
Where changes are unavoidable, users will be informed through deprecation warnings and messaging well in advance.
Newer additions, including the visualization tools and the sample size planning function, are marked as experimental, reflecting that their interfaces may still undergo substantial revisions as they mature.

A concrete illustration of why this distinction matters is the plot function for `seq_ttest()`.
Mirroring the `t.test()` interface was a deliberate choice to lower the barrier to adoption, but as the package grew, a complication emerged: the wide variety of input formats accepted by `t.test()` has so far prevented the implementation of a consistent plot function for `seq_ttest()` — a feature that already exists for `seq_anova()` and is planned for a future release.
Resolving this may require interface adjustments to `seq_ttest()`, which will be handled through the deprecation-with-messaging approach rather than silent breaking changes.


## External data

Sample size planning for sequential tests cannot be derived analytically and instead requires extensive Monte Carlo simulations to characterize sampling behavior across a wide range of parameter combinations.
The `plan_sample_size()` function addresses this by generating an HTML report based on a pre-computed simulation dataset covering multiple effect sizes, group sizes, and Type II error rates — each estimated from 10,000 replications per condition, run on a high-performance computing cluster.
Pre-computing this dataset offers several advantages over on-demand simulation: recommendations are returned instantly, all users access identical results ensuring reproducibility, and redundant computation across research groups is avoided.
The trade-off is that the lookup table only covers pre-specified parameter combinations; users with highly custom scenarios are directed to the simulation functions to generate their own estimates.

However, the comprehensive nature of these simulations produces a dataset too large to bundle directly with the package under CRAN size constraints.
To resolve this tension, the simulation dataset is maintained in a separate GitHub repository (https://github.com/MeikeSteinhilber/sprtt_plan_sample_size) and downloaded on demand, after which it is cached locally to avoid repeated downloads.
This separation also serves a transparency purpose: the full simulation pipeline — including the hierarchical SLURM scripts used for cluster execution — is publicly available for inspection and verification.
To give users direct control over this external dependency, the sprtt package includes dedicated helper functions (`download_sample_size_data()`, `cache_info()`, `cache_clear()`) for manually downloading, inspecting, and clearing the locally cached dataset.

# Software documentation

The `sprtt` package is documented through a dedicated website (https://meikesteinhilber.github.io/sprtt/), a README on both the main GitHub repository and the supplementary repository hosting simulation code and results for the `plan_sample_size()` function.
The package further includes a comprehensive set of vignettes.
Introductory vignettes cover general package usage and a recommended workflow and an introduction to SPRTs, complemented by a simple *t*-test use case.
More advanced vignettes provide dedicated guidance on the sequential *t*-test and sequential one-way ANOVA.
Finally, further topics are addressed in vignettes on sample size planning and a developer guide for users who want to contribute to or extend the package.

# AI usage disclosure

[//]: # (*Transparent disclosure of any use of generative AI in the software creation, documentation, or paper authoring. If no AI tools were used, state this explicitly. If AI tools were used, describe how they were used and how the quality and correctness of AI-generated content was verified.*)

The core `sprtt` implementation, all architectural decisions, and the research contributions are original human intellectual work.
Development began in February 2021 and predates the widespread availability of modern AI-assisted programming tools, with the majority of the codebase written without AI assistance (CRAN releases: August 2021 and July 2023).
For the latest release, generative AI (Claude, Anthropic) was used to assist with debugging new code, writing unit tests, and reviewing the package documentation for improvements.
For this manuscript, AI was additionally used to support writing tasks such as improving grammar and spelling and suggesting organizational structure.
In all cases, AI served an assistive role only, and all output was thoroughly reviewed and verified by the authors.


# Acknowledgements

This work was supported by the Carl Zeiss Foundation (P2019-01-003; 2021-2026).
Parts of this research were also supported by a grant from the German Research Foundation (Deutsche Forschungsgemeinschaft, GRK 2277) to the Research Training Group "Statistical Modeling in Psychology".

# References
