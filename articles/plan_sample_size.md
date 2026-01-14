# Sample Size Planning for Sequential ANOVAs

## Introduction

### Why Sample Size Planning Matters

Determining an appropriate sample size is a critical step in designing
any study. Too few participants may result in insufficient statistical
power to detect meaningful effects, while collecting more data than
necessary wastes resources and participant time. For sequential
designs—where data are analyzed continuously as they arrive—sample size
planning becomes even more important because researchers need to balance
the efficiency gains of early stopping against the risk of premature
conclusions.

### Sequential ANOVAs

Traditional ANOVAs require researchers to collect all data before
conducting a single hypothesis test. Sequential ANOVAs, by contrast,
allow for continuous monitoring of the data as they accumulate. This
approach offers several advantages:

- **Early stopping for efficacy:** If a clear effect emerges, data
  collection can stop earlier than planned, saving time and resources.
- **Early stopping for futility:** If the data strongly suggest no
  effect, researchers can terminate the study early rather than
  continuing to collect unhelpful data.
- **Flexibility:** Researchers can make informed decisions throughout
  data collection rather than waiting until the end.

However, these benefits come with a cost: sequential testing inflates
the Type I error rate if not properly controlled. The Sequential
Probability Ratio Test (SPRT) framework implemented in **sprtt**
addresses this issue by maintaining the desired alpha level throughout
the sequential process.

### The Challenge of Sample Size Planning

Unlike traditional ANOVAs where power analysis formulas are
well-established, sequential designs require simulation-based approaches
to determine sample sizes. This is because:

1.  **Complex stopping rules:** Sequential tests can stop at any point,
    making analytical solutions intractable.
2.  **Multiple comparisons:** Continuous monitoring involves many
    implicit tests, affecting power calculations.
3.  **Trade-offs:** The maximum sample size must balance the benefits of
    early stopping against the risk of requiring more participants than
    a traditional design.

The **sprtt** package solves this problem by providing pre-computed
simulation results that allow researchers to quickly determine
appropriate sample sizes for their sequential ANOVA designs.

------------------------------------------------------------------------

## Overview of the Sample Size Planning System

### The `plan_sample_size()` Function

The
[`plan_sample_size()`](https://meikesteinhilber.github.io/sprtt/reference/plan_sample_size.md)
function is the main interface for sample size planning. It generates an
interactive HTML report containing:

- **Recommended maximum sample size** for your design
- **Expected sample size** (average across simulations)
- **Probability of early stopping** at various sample sizes
- **Power curves** showing how statistical power accumulates as data are
  collected
- **Comparison to traditional ANOVA** sample size requirements

The function works by querying a large database of simulation results,
selecting the relevant scenarios, and presenting them in an
easy-to-interpret format.

### Pre-computed Simulation Database

To make sample size planning fast and accessible, **sprtt** includes
access to extensive simulation results. These simulations were conducted
by:

1.  Generating thousands of datasets for each combination of parameters
2.  Running sequential ANOVAs on each dataset
3.  Recording when each test stopped (if at all) and whether it
    correctly detected the effect
4.  Aggregating these results to determine power and expected sample
    sizes

This simulation database is approximately 15 MB and is stored externally
to keep the package installation size small. The data are downloaded
automatically on first use and cached locally for future sessions.

### Supported Design Parameters

The simulation database covers a range of common experimental designs:

- **Effect sizes (Cohen’s *f*):** 0.10, 0.15, 0.20, 0.25, 0.30, 0.35,
  0.40
- **Number of groups:** 2, 3, 4, 5
- **Desired power:** 0.80, 0.90, 0.95
- **Alpha level:** 0.05 (fixed)

These values span from small to large effects and from simple to
moderately complex designs, covering most practical research scenarios.

------------------------------------------------------------------------

## Getting Started

### Installation and Setup

First, ensure the **sprtt** package is installed and loaded:

``` r
# Install from CRAN (if needed)
install.packages("sprtt")

# Load the package
library(sprtt)
```

### Your First Sample Size Report

Let’s say you’re planning a study comparing three groups and expect a
medium effect size (Cohen’s *f* = 0.25). You want 95% power to detect
this effect. Here’s how to generate a sample size planning report:

``` r
plan_sample_size(
  f_expected = 0.25,  # Expected effect size
  k_groups = 3,       # Number of groups
  power = 0.95        # Desired power
)
```

When you run this code for the first time, several things happen:

1.  **Data download:** The simulation database (~70 MB) is downloaded
    from GitHub and saved to your local cache directory. This is a
    one-time operation.
2.  **Report generation:** An HTML report is created in your temporary
    directory.
3.  **Browser launch:** The report automatically opens in your default
    web browser (if running interactively).

The entire process typically takes 30-60 seconds for the initial
download, then just a few seconds for subsequent reports.

### Understanding the Output

The generated HTML report contains several sections:

- **Recommended sample size:** The maximum sample size you should plan
  for, ensuring you achieve the desired power.
- **Expected sample size:** The average sample size at which sequential
  tests stopped in the simulations. This is typically much lower than
  the maximum, illustrating the efficiency of sequential designs.
- **Visual summaries:** Plots showing the distribution of stopping
  points and how power accumulates over sample size.
- **Technical details:** Information about the simulation parameters and
  assumptions.

This report serves as a comprehensive reference you can share with
collaborators, include in grant applications, or use for your own
planning.

------------------------------------------------------------------------

## Function Reference

### Main Function: `plan_sample_size()`

The primary function for generating sample size reports.

#### Parameters

| Parameter     | Type      | Default                                                    | Description                                                                                                   |
|---------------|-----------|------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------|
| `f_expected`  | numeric   | *required*                                                 | Expected standardized effect size (Cohen’s *f*). Must be one of: 0.10, 0.15, 0.20, 0.25, 0.30, 0.35, or 0.40. |
| `k_groups`    | integer   | *required*                                                 | Number of groups to compare. Must be 2, 3, 4, or 5.                                                           |
| `power`       | numeric   | 0.95                                                       | Desired statistical power. Must be 0.80, 0.90, or 0.95.                                                       |
| `output_dir`  | character | [`tempdir()`](https://rdrr.io/r/base/tempfile.html)        | Directory where the HTML report will be saved.                                                                |
| `output_file` | character | `"sprtt-report-sample-size-planning.html"`                 | Filename for the generated report.                                                                            |
| `open`        | logical   | [`interactive()`](https://rdrr.io/r/base/interactive.html) | Whether to open the report in your browser after generation. Set to `FALSE` for batch processing.             |
| `overwrite`   | logical   | FALSE                                                      | Whether to overwrite an existing file with the same name without prompting.                                   |

#### Return Value

The function invisibly returns the full path to the generated HTML file
as a character string. This is useful if you want to programmatically
access or move the file after generation.

#### Input Validation

The function validates all inputs before generating the report. If you
specify a parameter value that doesn’t exist in the simulation database,
you’ll receive an informative error message listing the available
options. For example:

``` r
# This will produce an error:
plan_sample_size(f_expected = 0.22, k_groups = 3)
#> Error: `f_expected` = 0.22 is not available. 
#> Please choose one of 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, or 0.4
```

------------------------------------------------------------------------

## Practical Examples

### Example 1: Comparing Different Effect Sizes

Effect size has a dramatic impact on required sample size. Here’s how to
generate reports for different scenarios:

``` r
# Planning for a small effect (f = 0.15)
plan_sample_size(f_expected = 0.15, k_groups = 3, power = 0.95)

# Planning for a large effect (f = 0.40)
plan_sample_size(f_expected = 0.40, k_groups = 3, power = 0.95)
```

You’ll notice that the report for *f* = 0.15 recommends a much larger
maximum sample size than *f* = 0.40. This reflects the fundamental
principle that smaller effects require more data to detect reliably.

### Example 2: Adjusting Power Requirements

Different research contexts may require different levels of power. While
80% is often considered a minimum, many researchers prefer 90% or 95%
power:

``` r
# Standard power (80%)
plan_sample_size(f_expected = 0.25, k_groups = 3, power = 0.80)

# Higher power for critical studies (95%)
plan_sample_size(f_expected = 0.25, k_groups = 3, power = 0.95)
```

Higher power requirements lead to larger recommended sample sizes but
provide greater confidence in detecting true effects when they exist.

### Example 3: Saving Reports to a Specific Location

By default, reports are saved to a temporary directory. For reports you
want to keep, specify a custom location:

``` r
plan_sample_size(
  f_expected = 0.25,
  k_groups = 4,
  output_dir = "~/Documents/research/sample_size_planning",
  output_file = "study1_anova_power.html",
  open = TRUE
)
```

This is particularly useful when preparing documentation for grant
applications, pre-registrations, or manuscript supplementary materials.

------------------------------------------------------------------------

## Data Management

### The Simulation Database

The simulation database contains results from millions of individual
simulated studies. For each combination of parameters (effect size,
number of groups, power), the database includes:

- Stopping points (sample sizes at which sequential tests terminated)
- Decision outcomes (correct vs. incorrect statistical decisions)
- Summary statistics (mean, median, quantiles of stopping points)

This comprehensive database enables instant sample size recommendations
without requiring users to run time-consuming simulations themselves.

### Cache System

To minimize download times and enable offline use, **sprtt** implements
a local caching system. The simulation data are stored in a
platform-specific user data directory:

- **Windows:** `%LOCALAPPDATA%\sprtt`
- **macOS:** `~/Library/Application Support/sprtt`
- **Linux:** `~/.local/share/sprtt`

Once downloaded, the data persist across R sessions, so you only
download them once.

### Managing Cached Data

#### Downloading Data Explicitly

While
[`plan_sample_size()`](https://meikesteinhilber.github.io/sprtt/reference/plan_sample_size.md)
downloads data automatically when needed, you can also download it
explicitly:

``` r
# Download simulation data manually
download_sample_size_data()
```

This is useful if you want to: - Pre-download data on a fast internet
connection before traveling - Verify the download completed
successfully - Troubleshoot download issues

To force a re-download (for example, after a package update with new
simulation data):

``` r
download_sample_size_data(force = TRUE)
```

#### Checking Cache Status

To see whether data are cached and how much disk space they occupy:

``` r
cache_info()
```

This displays: - The cache directory location on your system - Whether
simulation data are currently cached - The file size (approximately 15
MB when cached)

#### Clearing the Cache

If you need to free up disk space or suspect corrupted data, you can
clear the cache:

``` r
cache_clear()
```

The data will be re-downloaded automatically the next time you run
[`plan_sample_size()`](https://meikesteinhilber.github.io/sprtt/reference/plan_sample_size.md).

### Working with Simulation Data Directly

Advanced users may want to access the raw simulation data for custom
analyses or visualizations. You can load the data directly into your R
session:

``` r
# Load the complete simulation database
df_all <- load_sample_size_data()

# Examine the structure
str(df_all)
```

This data frame contains all simulation results and can be filtered,
summarized, or visualized using standard R tools. For example:

``` r
library(dplyr)

# Get results for a specific scenario
results_subset <- df_all %>%
  filter(
    f_expected == 0.25,
    power == 0.95,
    k_groups == 3
  )

# Calculate summary statistics
summary(results_subset$n_max)
```

------------------------------------------------------------------------

## Workflow Recommendations

### Planning a Single Study

For planning a single study, the workflow is straightforward:

1.  Determine your expected effect size based on prior research or pilot
    data
2.  Decide on your desired power level (typically 0.80, 0.90, or 0.95)
3.  Count the number of groups in your design
4.  Generate the report and review the recommendations

``` r
library(sprtt)

plan_sample_size(
  f_expected = 0.25,    # Based on prior meta-analysis
  k_groups = 4,         # Four experimental conditions
  power = 0.90          # 90% power for this pilot study
)
```

### Preparing Multiple Scenarios

When preparing grant applications or pre-registrations, you might want
to explore multiple scenarios (e.g., different effect size assumptions):

``` r
# Define scenarios to compare
scenarios <- data.frame(
  effect = c(0.20, 0.25, 0.30),
  label = c("conservative", "expected", "optimistic")
)

# Generate reports for each scenario
for (i in seq_len(nrow(scenarios))) {
  plan_sample_size(
    f_expected = scenarios$effect[i],
    k_groups = 3,
    power = 0.90,
    output_dir = "grant_application/power_analyses",
    output_file = sprintf("power_analysis_%s.html", scenarios$label[i]),
    open = FALSE,  # Don't open each one
    overwrite = TRUE
  )
}

message("Generated ", nrow(scenarios), " sample size reports")
```

This approach creates a set of reports that document your planning
across different assumptions, demonstrating thorough preparation to
reviewers.

### First-Time Setup in a New Environment

When setting up **sprtt** on a new computer or after a clean R
installation:

``` r
# Install package
install.packages("sprtt")

# Load package
library(sprtt)

# Verify installation by generating a test report
plan_sample_size(f_expected = 0.25, k_groups = 3)

# Data downloads automatically on first run
# All subsequent reports will be fast
```

------------------------------------------------------------------------

## Troubleshooting

### Download Issues

**Symptom:** Error message stating “Failed to download simulation data”

**Possible causes:** - No internet connection - Firewall blocking GitHub
access - GitHub temporary outage - Corrupted partial download

**Solutions:**

1.  Verify your internet connection
2.  Try downloading manually with
    `download_sample_size_data(force = TRUE)`
3.  Check the cache location with
    [`cache_info()`](https://meikesteinhilber.github.io/sprtt/reference/cache_info.md)
    and ensure you have write permissions
4.  If behind a corporate firewall, contact your IT department about
    accessing GitHub
5.  Clear the cache and retry:
    [`cache_clear()`](https://meikesteinhilber.github.io/sprtt/reference/cache_clear.md)
    followed by
    [`download_sample_size_data()`](https://meikesteinhilber.github.io/sprtt/reference/download_sample_size_data.md)

### Parameter Availability

**Symptom:** Error message “f_expected = X is not available”

**Cause:** You’ve requested a parameter value not included in the
simulation database

**Solution:** The simulation database includes specific discrete values
to keep file sizes manageable. Check available options:

``` r
df_all <- load_sample_size_data()

# Available effect sizes (f)
sort(unique(df_all$f_expected))

# Available power levels
sort(unique(df_all$power))

# Available group counts
sort(unique(df_all$k_groups))
```

Then use the closest available value to your desired parameter. For
instance, if you want *f* = 0.22, use 0.20 or 0.25 instead.

### File Overwrite Conflicts

**Symptom:** Prompted whether to overwrite an existing file

**Cause:** A report with the same filename already exists in the output
directory

**Solutions:**

1.  **Change the filename:** Specify a different `output_file` parameter
2.  **Allow overwriting:** Set `overwrite = TRUE` to replace the file
    automatically
3.  **Use version numbers:** Include dates or version numbers in
    filenames: `"report_2025-01-07.html"`

### Memory Issues

**Symptom:** Error about insufficient memory when loading simulation
data

**Cause:** The simulation database (~70 MB as a file, larger in memory)
exceeds available RAM

**Solution:** This is rare but can occur on severely memory-constrained
systems. Close other applications and try again. If the problem
persists, consider: - Accessing the simulation data on a more powerful
computer - Using the pre-generated reports rather than creating new
ones - Contacting the package maintainers about accessing a subset of
the data

------------------------------------------------------------------------

## Technical Details

### Simulation Methodology

The simulation database was created using the following procedure:

1.  **Data generation:** For each parameter combination, thousands of
    datasets were generated under the null and alternative hypotheses
2.  **Sequential testing:** Each dataset was analyzed using the
    sequential ANOVA procedure, with continuous monitoring until a
    decision or maximum sample size
3.  **Recording outcomes:** Stopping points, decisions, and statistical
    power were recorded
4.  **Aggregation:** Results were summarized to produce power curves and
    sample size recommendations

This approach ensures that recommendations account for the complex
behavior of sequential tests, including early stopping patterns and Type
I error control.

### Data Storage and Distribution

To balance package size with data accessibility, the simulation results
are stored externally on GitHub:

- **Repository:** `MeikeSteinhilber/sprtt_plan_sample_size`
- **Filename:** `sprtt_external_data_plan_sample_size.rds`
- **Format:** Compressed R data file (.rds)
- **Size:** ~70 MB
- **Access method:** `piggyback` package for downloading GitHub release
  assets

This architecture keeps the installed package lightweight (~1 MB) while
providing access to comprehensive simulation data on demand.

### Alpha Level

All sample size recommendations assume a Type I error rate (α) of 0.05.
This value is fixed and not user-configurable, as it represents the
standard in most research fields. If your research requires a different
alpha level, please contact the package maintainers to discuss extending
the simulation database.

### Computational Considerations

Generating each HTML report requires: - Loading the simulation database
into memory - Filtering to relevant parameter combinations - Rendering
the R Markdown template with embedded plots

On modern systems, this typically completes in 2-5 seconds after the
initial data download. The process is entirely local after data are
cached—no internet connection is required for subsequent reports.

------------------------------------------------------------------------
