# sprtt: Sequential Probability Ratio Tests Toolbox

It is a toolbox for Sequential Probability Ratio Tests (SPRT), Wald
(1945)
[doi:10.2134/agronj1947.00021962003900070011x](https://doi.org/10.2134/agronj1947.00021962003900070011x)
. SPRTs are applied to the data during the sampling process, ideally
after each observation. At any stage, the test will return a decision to
either continue sampling or terminate and accept one of the specified
hypotheses. The seq_ttest() function performs one-sample, two-sample,
and paired t-tests for testing one- and two-sided hypotheses (Schnuerch
& Erdfelder (2019)
[doi:10.1037/met0000234](https://doi.org/10.1037/met0000234) ). The
seq_anova() function allows to perform a sequential one-way fixed
effects ANOVA (Steinhilber et al. (2023)
[doi:10.31234/osf.io/m64ne](https://doi.org/10.31234/osf.io/m64ne) ).
Learn more about the package by using vignettes "browseVignettes(package
= "sprtt")" or go to the website
<https://meikesteinhilber.github.io/sprtt/>.

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
