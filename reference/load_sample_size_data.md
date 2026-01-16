# Access sample size simulation data

**\[experimental\]**

Loads pre-computed simulation results for SPRT sample size planning. If
not already cached locally, the data (~70 MB) will be downloaded
automatically from GitHub releases. Use this function to access the
complete dataset for custom analysis and visualization. See the **Data
Structure** section below for details on available columns.

Data is hosted at:
[MeikeSteinhilber/sprtt_plan_sample_size](https://github.com/MeikeSteinhilber/sprtt_plan_sample_size)

## Usage

``` r
load_sample_size_data()
```

## Value

A data frame with simulation results

## Data Structure

The downloaded dataset contains simulation results with the following
columns:

**Simulation Metadata:**

- `batch`: Batch identifier for the simulation run

- `iteration`: Individual simulation iteration within a batch

- `source_file`: Path to the file containing simulation parameters or
  results

**Input Parameters:**

- `f_simulated`: The true effect size used to generate the simulated
  data

- `f_expected`: The expected effect size specified for the SPRT

- `k_groups`: Number of groups in the design

- `alpha`: Significance level (Type I error rate)

- `power`: Desired statistical power (1 - Type II error rate)

- `distribution`: Data distribution used for simulation

- `sd`: Standard deviation(s) used in data generation in each group

- `sample_ratio`: Ratio of sample sizes between groups (e.g., 1:1, 2:1)

- `n_raw_data`: Total number of raw observations generated in each group

- `fix_n`: Fixed sample size

**Individual Test Results:**

- `n`: Actual sample size at which the SPRT terminated

- `decision`: Test decision

- `decision_error`: Whether the decision was erroneous (Type I or Type
  II error)

- `log_lr`: Log-likelihood ratio at termination

- `f`: Calculated effect size from the data

- `f_adj`: Adjusted effect size

- `f_statistic`: F-statistic from ANOVA test

**Summary Statistics (Aggregated across iterations):**

- `decision_error_rate`: Proportion of incorrect decisions

- `mean_n`: Mean sample size across all iterations

- `sd_error_n`: Standard error of the mean sample size (sd(n)/sqrt(n))

- `median_n`: Median sample size (50th percentile)

- `min_n`, `max_n`: Minimum and maximum sample sizes observed

- `q25_n`, `q50_n`, `q75_n`, `q90_n`, `q95_n`: Sample size quantiles

- `decision_rate_25`, `decision_rate_50`, `decision_rate_75`,
  `decision_rate_90`, `decision_rate_95`, `decision_rate_100`:
  Cumulative decision rates at various percentages of maximum sample
  size

## Examples

``` r
if (FALSE) { # \dontrun{
# Load data (downloads automatically if needed)
df <- load_sample_size_data()
head(df)
} # }
```
