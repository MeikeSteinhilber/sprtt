# \#—- MAIN FUNCTION DOCUMENTATION ———————————————- Generate an HTML report for sample size planning for sequential ANOVAs.

Renders a parameterized R Markdown report that helps plan sample size
for an SPRT analysis. The function takes expected effect size
(`f_expected`), number of groups (`k_groups`), and desired power, then
generates a reproducible HTML report summarizing the simulation-based
sample size recommendations. The alpha level is always 0.05.

The report template is part of the **sprtt** package and is located
under
`inst/rmarkdown/templates/report_sample_size/skeleton/skeleton.Rmd`.

## Usage

``` r
plan_sample_size(
  f_expected,
  k_groups,
  power = 0.95,
  output_dir = tempdir(),
  output_file = "sprtt-report-sample-size-planning.html",
  open = interactive(),
  overwrite = FALSE
)
```

## Arguments

- f_expected:

  Numeric scalar. The expected standardized effect size (e.g., Cohen's
  f). Must be greater than 0.

- k_groups:

  Integer scalar. The number of groups to compare. Must be at least 2.

- power:

  Numeric scalar (default = 0.95). Desired statistical power for the
  design.

- output_dir:

  Character string. Directory in which to save the rendered HTML report.
  Defaults to a temporary directory
  ([`tempdir()`](https://rdrr.io/r/base/tempfile.html)).

- output_file:

  Character string. File name of the generated HTML report. Defaults to
  `"sprtt-report-sample-size-planning.html"`.

- open:

  Logical (default =
  [`interactive()`](https://rdrr.io/r/base/interactive.html)). If
  `TRUE`, the generated report is opened in the system's default web
  browser after rendering.

- overwrite:

  Logical (default = `FALSE`). If `FALSE` and the target file already
  exists, the user is prompted interactively whether to overwrite it. In
  non-interactive sessions, an error is raised unless
  `overwrite = TRUE`.

## Value

Invisibly returns the path to the rendered HTML file (character string).
The report is optionally opened in the default browser.

## Details

This function is a front-end utility for rendering a pre-defined R
Markdown report using
[`rmarkdown::render()`](https://pkgs.rstudio.com/rmarkdown/reference/render.html).

## File Overwrite Behavior

- If the specified output file already exists:

  - and `overwrite = FALSE`, the user is asked whether to overwrite (in
    interactive sessions); otherwise, an error is thrown.

  - If `overwrite = TRUE`, the file is replaced silently.

## See also

[`rmarkdown::render()`](https://pkgs.rstudio.com/rmarkdown/reference/render.html),
[`utils::browseURL()`](https://rdrr.io/r/utils/browseURL.html), and the
**sprtt** package report templates.

## Examples

``` r
if (FALSE) { # \dontrun{
# Generate and open an SPRT sample size planning report:
plan_sample_size(
  f_expected = 0.25,
  k_groups = 3,
  power = 0.9,
  output_file = "sprtt-sample-size.html",
  open = TRUE
)

# Prevent overwriting an existing file:
plan_sample_size(0.25, 3, overwrite = FALSE)
} # }
```
