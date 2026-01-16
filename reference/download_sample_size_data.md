# Download simulation data for sample size planning

**\[experimental\]**

Downloads pre-computed simulation results from GitHub releases. Data is
cached locally and only needs to be downloaded once.

Data is hosted at:
[MeikeSteinhilber/sprtt_plan_sample_size](https://github.com/MeikeSteinhilber/sprtt_plan_sample_size)

## Usage

``` r
download_sample_size_data(force = FALSE)
```

## Arguments

- force:

  Logical. If TRUE, re-download even if data exists. Default FALSE.

## Value

Invisibly returns the path to the cached data file.

## Examples

``` r
if (FALSE) { # \dontrun{
# Download data (only needed once)
download_sample_size_data()

# Force re-download (e.g., after data update)
download_sample_size_data(force = TRUE)
} # }
```
