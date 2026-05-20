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
While traditional fixed-sample designs require researchers to commit to a predetermined sample size, SPRTs enable continuous evidence evaluation with predefined stopping rules -- terminating data collection as soon as evidence crosses a threshold for rejecting or accepting the null hypothesis [@wald1945].
Crucially, this flexibility comes without inflating long-run Type I and Type II error rates beyond the levels specified in advance.
For Wald’s original SPRT under simple hypotheses, 50% fewer observations are required compared to a Neyman-Pearson fixed-sample design [@wald1945].
Newer variants extend these methods to composite hypotheses through sequential *t*-tests and sequential ANOVA -- designs standard in fields like psychology and medicine.
For the composite-hypothesis extensions implemented in `sprtt`, efficiency cannot be derived analytically [@wald1945; @cox1952; @kollerstrom1979; @schnuerch2020], but simulation studies have shown that error rates are well-controlled and efficiency gains remain of similar magnitude [@schnuerch2020; @steinhilber2024; @stefan2022].
Despite the long history of SPRTs, the `sprtt` package is the first to provide accessible software implementations for both sequential *t*-tests [@rushton1950; @hajnal1961; @schnuerch2020] and sequential ANOVA [@wetherill1986; @steinhilber2024].
The package implements these validated procedures and additionally provides example datasets, data generating functions, sample size planning, and visualization tools to facilitate the adoption of SPRTs in applied research.


# Statement of need

[//]: # (*A section that clearly illustrates the research purpose of the software and places it in the context of related work. This should clearly state what problems the software is designed to solve, who the target audience is, and its relation to other work.*)

Due to the replication crisis [@opensciencecollaboration2015; @ioannidis2005; @bogdan2025] in empirical fields like psychology and medicine, statistical procedures have been scrutinized, and new alternatives have gained attention [@cumming2014; @lakens2018; @wagenmakers2018].
Sequential testing methods have become increasingly popular in recent years as they directly address pressing demands in empirical research: the need to minimize resource expenditure and participant burden without sacrificing statistical rigor [@schnuerch2020; @steinhilber2024; @ly2025; @lakens2021b; @erdfelder2021].
This is relevant across all empirical research, and particularly vital in clinical settings where continued data collection can carry real ethical costs.

Although SPRTs are well-established in the statistical literature [@wald1947; @siegmund1985; @bartroff2012; @tartakovsky2014], their original formulation relies on simple hypotheses, which are rarely used in applied research: they require researchers to specify nuisance parameters -- such as the variance -- which are rarely known in advance.
As a first step toward practical applicability, variants based on composite hypotheses were developed, namely the sequential *t*-test [@rushton1950; @hajnal1961] and sequential ANOVA [@wetherill1986].
As a second step, these variants were recently validated in simulation studies, establishing their statistical properties under realistic conditions [@schnuerch2020; @steinhilber2024].
As a third step, this methodological progress needed to be matched by accessible software: prior to `sprtt`, the only available implementation was a bare R script provided alongside validation work [@schnuerch2020].
Translating these promising statistical methods into accessible, user-friendly, and open-source software is therefore essential for finally closing the gap between statistical theory and adoption in practice.

# State of the field                                                                                                                  
[//]: # (*A description of how this software compares to other commonly-used packages in the research area. If related tools exist, provide a clear “build vs. contribute” justification explaining your unique scholarly contribution and why existing alternatives are insufficient.*)

The landscape of sequential testing software is sparse.
Beyond R, very few software packages appear to exist, though several major technology companies including Netflix, Uber, and Spotify have either published on sequential testing and SPRT variants or stated their use, suggesting that proprietary implementations may exist in industry [@bibaut2024; @schultzberg2023; @deb2018].
The only Python implementation, the `sprt` package on PyPI [@yu2017], covers Wald's SPRT for Normal, Binomial, and Poisson distributions but has not been updated since its initial release in 2017 and lacks documentation.
No SPRT implementations seem to exist in Julia.
A JavaScript library for sequential generalized likelihood ratio tests `SeGLiR` [@oygard2014] targets browser-based A/B testing and has not been maintained since 2017.
JASP [@love2019] is a free and open-source application that implements sequential Bayesian hypothesis testing [@schonbrodt2017], using a Bayes Factor rather than a likelihood ratio as the monitoring statistic, which requires the specification of prior distributions.
These Bayesian tools address an important but different use case.
The present package is intended for researchers who prefer a frequentist sequential framework, want to control long-run Type I and Type II error rates in familiar Neyman–Pearson terms, or wish to avoid the need to specify prior distributions.
In R, the package `SPRT` [@budihal2025] implements Wald's original sequential tests for simple hypotheses, the `gsDesign` [@anderson2026] package provides a function for truncated binomial SPRTs, and the `MSPRT` [@pramanik2020] and `Sequential` [@silva2025] packages cover a variety of truncated SPRT variants.
Beyond the SPRT, anytime-valid inference has emerged as an alternative sequential testing framework, using e-values to guarantee validity at any sample size [@ramdas2023; @grunwald2023] -- current software implementations include the R package `safestats` [@ly2024; @ly2025] and the Python package `savvi` [@assuncao2024].
To our knowledge, no publicly available software implements sequential *t*-tests or sequential one-way ANOVA as described and validated by @schnuerch2020 and @steinhilber2024.
The `sprtt` package fills this gap directly.

# Research impact

[//]: # (*Evidence of realized impact (publications, external use, integrations) or credible near-term significance (benchmarks, reproducible materials, community-readiness signals). The evidence should be compelling and specific, not aspirational.*)

The `sprtt` package was first published on CRAN in 2021 and has since accumulated close to 13,000 downloads, averaging approximately 200 downloads per month in the 12 months preceding March 2026 [@steinhilber2023].
The package has been used in experimental research [@quevedoputter2022], simulation studies [@steinhilber2024; @steinhilber2025], and has been referenced in methodological work [@schubert2025a; @fischer2025].
The target audience includes applied researchers using SPRT variants in their empirical work, as well as methodologists conducting simulation studies to gain further insights into the properties of SPRTs.

![Monthly CRAN downloads of the `sprtt` package since its first release in August 2021. Dashed vertical lines indicate CRAN release versions. The LOESS trend line with 95% confidence band reflects the overall download trajectory across complete months.](sprtt_downloads_2026-05-20.png)


# Software design

[//]: # (*An explanation of the trade-offs you weighed, the design/architecture you chose, and why it matters for your research application. This should demonstrate meaningful design thinking beyond a superficial code structure description.*)

The `sprtt` package is built around two main user-facing functions:
`seq_ttest()` and `seq_anova()`.
The `seq_ttest()` function implements the sequential *t*-test and deliberately mirrors the interface of the `t.test()` function from the `stats` package to ensure familiarity for R users.
The `seq_anova()` function follows a similar design philosophy, maintaining consistency across the package's interface.

## Design principle

The core design principle is modularity: each internal function should perform one task well.
This approach emphasizes simplicity, testability, clear structure, and minimal code repetition.
The internal architecture of the core functions is documented in more detail in the developer vignette of the `sprtt` package.
The package is designed to return interpretable results not only when a stopping boundary is crossed, but also when monitoring remains inconclusive at the current stage of data collection.
More generally, functions perform input validation to catch common issues such as invalid argument types, missing values, or out-of-range parameters.

While the primary focus remains on implementing well-tested SPRT variants with proven efficiency and error rate control, the package continuously expands its functionality to improve user experience.
Supporting features include example datasets, data simulation functions, visualization tools for sequential ANOVA results, and sample size planning for sequential ANOVA.
The `lifecycle` package is used throughout to clearly communicate the maturity status of each function -- an important consideration for research software where interface stability directly affects reproducibility.
The core functions `seq_ttest()`, `seq_anova()`, and the data simulation utilities are stable: we commit to not introducing silent breaking changes to these functions.
Where changes are unavoidable, users will be informed through deprecation warnings and messaging well in advance.
Newer additions, including the visualization tools and the sample size planning function, are marked as experimental, reflecting that their interfaces may still undergo substantial revisions as they mature.

A concrete illustration of why this distinction matters is the plot function for `seq_ttest()`.
Mirroring the `t.test()` interface was a deliberate choice to lower the barrier to adoption, but as the package grew, a complication emerged: the wide variety of input formats accepted by `t.test()` has so far prevented the implementation of a consistent plot function for `seq_ttest()` -- a feature that already exists for `seq_anova()` and is planned for a future release.
Resolving this may require interface adjustments to `seq_ttest()`, which will be handled through the deprecation-with-messaging approach rather than silent breaking changes.


## External data

Sample size planning for the implemented tests cannot be derived analytically and instead requires extensive Monte Carlo simulations to characterize sampling behavior across a wide range of parameter combinations.
The `plan_sample_size()` function addresses this by generating an HTML report based on a pre-computed simulation dataset covering multiple effect sizes, group sizes, and Type II error rates -- each estimated from 10,000 replications per condition, run on a high-performance computing cluster.
Pre-computing this dataset offers several advantages over on-demand simulation: recommendations are returned instantly, all users access identical results ensuring reproducibility, and redundant computation across research groups is avoided.
The trade-off is that the lookup covers only a predefined set of parameter combinations; users with custom scenarios are therefore directed to the simulation functions to generate tailored estimates.

However, the comprehensive nature of these simulations produces a dataset too large to bundle directly with the package under CRAN size constraints.
To resolve this tension, the simulation dataset is maintained in a separate GitHub repository (https://github.com/MeikeSteinhilber/sprtt_plan_sample_size) and downloaded on demand, after which it is cached locally to avoid repeated downloads.
This separation also serves a transparency purpose: the full simulation pipeline including the hierarchical SLURM scripts used for cluster execution is publicly available for inspection and verification.
To give users direct control over this external dependency, the sprtt package includes dedicated helper functions (`download_sample_size_data()`, `cache_info()`, `cache_clear()`) for manually downloading, inspecting, and clearing the locally cached dataset.
The generated HTML report records the package version and the exact version of the downloaded simulation dataset, allowing users to reproduce recommendations even if the external repository is updated later.

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
For this manuscript, AI was additionally used to support writing tasks such as improving grammar and spelling, formatting of references, and suggesting manuscript structure.
In all cases, AI served an assistive role only, and all output was thoroughly reviewed and verified by the authors.


# Acknowledgements

We thank the Carl Zeiss Foundation for the generous 5-year funding of SMART-AGE (P2019-01-003; 2021-2026).
Parts of this research were supported by a grant from the German Research Foundation (Deutsche Forschungsgemeinschaft, GRK 2277) to the Research Training Group “Statistical Modeling in Psychology”.
Parts of this research were conducted using the supercomputer Mogon II and services offered by Johannes Gutenberg University Mainz (hpc.uni-mainz.de).

# References
