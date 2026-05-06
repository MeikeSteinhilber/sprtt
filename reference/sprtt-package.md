# sprtt: Sequential Probability Ratio Tests Toolbox

A toolbox for Sequential Probability Ratio Tests (SPRT) based on Wald
(1945)
[doi:10.2134/agronj1947.00021962003900070011x](https://doi.org/10.2134/agronj1947.00021962003900070011x)
. SPRTs are applied during the sampling process, ideally after each
observation, and at every stage return a decision to either continue
sampling or terminate and accept one of the specified hypotheses. The
\`seq_ttest()\` function performs one-sample, two-sample, and paired
t-tests for one- and two-sided hypotheses (Schnuerch & Erdfelder (2019)
[doi:10.1037/met0000234](https://doi.org/10.1037/met0000234) ). The
\`seq_anova()\` function performs a sequential one-way fixed effects
ANOVA (Steinhilber et al. (2024)
[doi:10.1037/met0000677](https://doi.org/10.1037/met0000677) ). The
\`plan_sample_size()\` function helps plan sequential studies by
simulating required sample sizes across a range of effect sizes. For
more information, see the vignettes browseVignettes(package = "sprtt")
or the package website <https://meikesteinhilber.github.io/sprtt/>.

## See also

Useful links:

- <https://meikesteinhilber.github.io/sprtt/>

- Report bugs at <https://github.com/MeikeSteinhilber/sprtt/issues>

## Author

**Maintainer**: Meike Snijder-Steinhilber <Meike.Steinhilber@aol.com>
([ORCID](https://orcid.org/0000-0002-7144-2100))

Authors:

- Martin Schnuerch ([ORCID](https://orcid.org/0000-0001-6531-2265))
  \[thesis advisor\]

- Anna-Lena Schubert ([ORCID](https://orcid.org/0000-0001-7248-0662))
  \[thesis advisor\]
