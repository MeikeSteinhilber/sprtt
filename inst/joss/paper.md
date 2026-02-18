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
*A description of the high-level functionality and purpose of the software for a diverse, non-specialist audience.*


The `sprtt` package provides a toolbox for Sequential Probability Ratio Tests (SPRTs), implementing modern variants including sequential *t*-tests and sequential ANOVA for applied research and methodological investigations.
Statistical hypothesis testing based on the Neyman-Pearson framework [-@neyman1933] controls long-run error rates across repeated experiments: the $\alpha$ level defines the upper boundary for Type I errors (false positives) and $\beta$ defines the upper boundary for Type II errors (false negatives).
Traditional fixed sample designs determine the required sample size $N$ before data collection begins based on the expected effect size.
This approach has an obvious limitation: evidence accumulating during data collection cannot influence the decision to stop.
If the true effect is larger than expected, the fixed sample design collects more data than necessary.
Abraham Wald's Sequential Probability Ratio Test [-@wald1945;-@wald1947] addresses this inefficiency by allowing continuous evaluation of evidence during data collection.
SPRTs maintain the same error rate control as fixed sample designs but permit stopping as soon as sufficient evidence accumulates for either accepting or rejecting the null hypothesis.
This sequential approach reduces required sample sizes by 50% or more on average compared to fixed sample alternatives [@wald1945;@steinhilber2024;@schnuerch2020].
While Wald's original SPRTs were constructed for simple hypotheses, newer variants extend these methods to composite hypotheses through sequential *t*-tests and sequential ANOVA.
These extensions are essential for fields like psychology and medicine where composite hypotheses are often standard.
However, Wald's mathematical proofs apply only to simple hypothesis tests, making simulation studies crucial for investigating the efficiency and error rate control of these newer variants.

The `sprtt` package is closely linked to current methodological research, implementing new SPRT procedures after they have demonstrated good performance in extensive simulations.
The main focus of the package is on the core sequential tests themselves, but it also provides helper functions for sample size planning and visualization to facilitate the adoption of SPRTs in applied research.

# Statement of need and research impact

*A section that clearly illustrates the research purpose of the software and places it in the context of related work. This should clearly state what problems the software is designed to solve, who the target audience is, and its relation to other work.*

While SPRTs are well-known in the statistical literature, they have rarely been implemented in research software and remain relatively unknown to many applied researchers [@steinhilber2024; @erdfelder2021].
Due to the replication crisis [@opensciencecollaboration2015; @ioannidis2005; @bogdan2025] in empirical fields like psychology and medicine, statistical procedures have been scrutinized and new alternatives have gained attention.
SPRTs have become increasingly popular in recent years, creating a need for accessible software implementations in the context of simulation studies and practical applications [@schnuerch2020; @stefan2022; @steinhilber2024].
Critically, sequential testing directly addresses one of the most pressing demands in empirical research: the need to minimize resource expenditure and participant burden without sacrificing statistical rigor.
This is relevant across all empirical research, and particularly vital in clinical and applied settings where continued data collection can carry real ethical costs.
The `sprtt`package was first published on CRAN in 2021 and has since been downloaded more than 13,000 times [@steinhilber2023a], and has been used in multiple methodological and applied papers [@schubert2025a; @quevedoputter2022; @steinhilber2024; @steinhilber2025].
The target audience includes applied researchers using SPRT variants in their empirical work, as well as methodologists conducting simulation studies to gain further insights into the properties of SPRTs.
Translating promising statistical methods into accessible, user-friendly, and open-source software is essential for closing the gap between methodological development and adoption in practice.

# State of the field                                                                                                                  
*A description of how this software compares to other commonly-used packages in the research area. If related tools exist, provide a clear “build vs. contribute” justification explaining your unique scholarly contribution and why existing alternatives are insufficient.*

*Evidence of realized impact (publications, external use, integrations) or credible near-term significance (benchmarks, reproducible materials, community-readiness signals). The evidence should be compelling and specific, not aspirational.*

The landscape of sequential testing software is sparse.
The R package `SPRT` implements Wald's original sequential test for simple hypotheses, the `gsDesign` package provides a `binomialSPRT()` function for truncated binomial SPRTs, and the `MSPRT` package covers a variety of truncated SPRT variants.
The R package `Sequential` implements other truncated SPRT variants for Poisson and binomial data, primarily targeting epidemiological safety surveillance.
Beyond R, no established software packages for SPRTs appear to exist, though several major technology companies including Netflix, Uber, and Spotify have either published on SPRTs or stated their use, suggesting that proprietary implementations exist in industry [@bibaut2024].
To our knowledge, no publicly available software implements sequential *t*-tests or sequential one-way ANOVA as described by @schnuerch2020 and @steinhilber2024.
The `sprtt` package fills this gap directly.

# Software design

*An explanation of the trade-offs you weighed, the design/architecture you chose, and why it matters for your research application. This should demonstrate meaningful design thinking beyond a superficial code structure description.*

The sprtt package is built around two main user-facing functions: `seq_ttest()` and `seq_anova()`.
The `seq_ttest()` function implements the sequential *t*-test and deliberately mirrors the interface of the `t.test()` function from the stats package to ensure familiarity for R users.
The `seq_anova()` function follows a similar design philosophy, maintaining consistency across the package's interface.

The core design principle is modularity: each internal function should perform one task well.
This approach emphasizes simplicity, testability, clear structure, and minimal code repetition.
The internal architecture is documented in detail in the developer vignette.

While the primary focus remains on implementing well-tested SPRT variants with proven efficiency and error rate control, the package continuously expands its functionality to improve user experience.
Supporting features include example datasets, data simulation functions, visualization tools for sequential ANOVA results, and sample size planning capabilities for sequential ANOVA.
The `lifecycle` package is used throughout to clearly communicate the maturity status of each function, distinguishing stable implementations from experimental features.

The sample size planning function generates an HTML guide based on extensive simulation data.
To manage computational efficiency, this simulation dataset is maintained in a separate GitHub repository and downloaded on demand.
A set of helper functions allows users to access, download, or clear this cached data as needed.


# AI usage disclosure

*Transparent disclosure of any use of generative AI in the software creation, documentation, or paper authoring. If no AI tools were used, state this explicitly. If AI tools were used, describe how they were used and how the quality and correctness of AI-generated content was verified.*


# Citations

Citations to entries in paper.bib should be in
[rMarkdown](http://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html)
format.

If you want to cite a software repository URL (e.g. something on GitHub without a preferred
citation) then you can do it with the example BibTeX entry below for @fidgit.

For a quick reference, the following citation commands can be used:
- `@author:2001`  ->  "Author et al. (2001)"
- `[@author:2001]` -> "(Author et al., 2001)"
- `[@author1:2001; @author2:2001]` -> "(Author1 et al., 2001; Author2 et al., 2002)"

# Figures

Figures can be included like this:
![Caption for example figure.\label{fig:example}](figure.png)
and referenced from text using \autoref{fig:example}.

Figure sizes can be customized by adding an optional second parameter:
![Caption for example figure.](figure.png){ width=20% }



# Acknowledgements

This work was supported by the Carl Zeiss Foundation (P2019-01-003; 2021-2026).
Parts of this research were also supported by a grant from the German Research Foundation (Deutsche Forschungsgemeinschaft, GRK 2277) to the Research Training Group "Statistical Modeling in Psychology".

# References
