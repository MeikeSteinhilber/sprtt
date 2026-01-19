#' Get path to cached simulation data directory
#' @keywords internal
get_sprtt_cache_dir <- function() {
  cache_dir <- rappdirs::user_data_dir("sprtt")
  if (!dir.exists(cache_dir)) {
    dir.create(cache_dir, recursive = TRUE)
  }
  cache_dir
}

#' Download simulation data for sample size planning
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' Downloads pre-computed simulation results from GitHub releases.
#' Data is cached locally and only needs to be downloaded once.
#'
#' Data is hosted at:
#' \href{https://github.com/MeikeSteinhilber/sprtt_plan_sample_size}{MeikeSteinhilber/sprtt_plan_sample_size}
#'
#' @param force Logical. If TRUE, re-download even if data exists. Default FALSE.
#' @return Invisibly returns the path to the cached data file.
#' @export
#' @examples
#' \dontrun{
#' # Download data (only needed once)
#' download_sample_size_data()
#'
#' # Force re-download (e.g., after data update)
#' download_sample_size_data(force = TRUE)
#' }
#'
download_sample_size_data <- function(force = FALSE) {
  cache_dir <- get_sprtt_cache_dir()
  data_file <- file.path(cache_dir, "sprtt_external_data_plan_sample_size.rds")

  if (file.exists(data_file) && !force) {
    message("Simulation data already cached at: ", data_file)
    return(invisible(data_file))
  }

  message("Downloading simulation data for sample size planning...")
  message("This is a one-time download (~70 MB).")

  tryCatch({
    piggyback::pb_download(
      file = "sprtt_external_data_plan_sample_size.rds",
      repo = "MeikeSteinhilber/sprtt_plan_sample_size",
      tag = "latest",  # Or use specific tag like "v0.1.0-data"
      dest = cache_dir
    )

    message("\u2713 Download complete! Data cached at: ", cache_dir)
    invisible(data_file)

  }, error = function(e) {
    stop(
      "Failed to download simulation data.\n",
      "Please check:\n",
      "  1. Your internet connection\n",
      "  2. The repository 'MeikeSteinhilber/sprtt_plan_sample_size' is public\n",
      "  3. A release with 'sprtt_external_data_plan_sample_size.rds' exists\n",
      "Error message: ", e$message,
      call. = FALSE
    )
  })
}

#' Access sample size simulation data
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' Loads pre-computed simulation results for SPRT sample size planning.
#' If not already cached locally, the data (~70 MB) will be downloaded automatically
#' from GitHub releases. Use this function to access the complete dataset for custom
#' analysis and visualization. See the **Data Structure** section below for details
#' on available columns.
#'
#' Data is hosted at:
#' \href{https://github.com/MeikeSteinhilber/sprtt_plan_sample_size}{MeikeSteinhilber/sprtt_plan_sample_size}
#'
#'
#' @return A data frame with simulation results
#' @export
#' @section Data Structure:
#' The downloaded dataset contains simulation results with the following columns:
#'
#' **Simulation Metadata:**
#' \itemize{
#'   \item \code{batch}: Batch identifier for the simulation run
#'   \item \code{iteration}: Individual simulation iteration within a batch
#'   \item \code{source_file}: Path to the file containing simulation parameters or results
#' }
#'
#' **Input Parameters:**
#' \itemize{
#'   \item \code{f_simulated}: The true effect size used to generate the simulated data
#'   \item \code{f_expected}: The expected effect size specified for the SPRT
#'   \item \code{k_groups}: Number of groups in the design
#'   \item \code{alpha}: Significance level (Type I error rate)
#'   \item \code{power}: Desired statistical power (1 - Type II error rate)
#'   \item \code{distribution}: Data distribution used for simulation
#'   \item \code{sd}: Standard deviation(s) used in data generation in each group
#'   \item \code{sample_ratio}: Ratio of sample sizes between groups (e.g., 1:1, 2:1)
#'   \item \code{n_raw_data}: Total number of raw observations generated in each group
#'   \item \code{fix_n}: Fixed sample size
#' }
#'
#' **Individual Test Results:**
#' \itemize{
#'   \item \code{n}: Actual sample size at which the SPRT terminated
#'   \item \code{decision}: Test decision
#'   \item \code{decision_error}: Whether the decision was erroneous (Type I or Type II error)
#'   \item \code{log_lr}: Log-likelihood ratio at termination
#'   \item \code{f}: Calculated effect size from the data
#'   \item \code{f_adj}: Adjusted effect size
#'   \item \code{f_statistic}: F-statistic from ANOVA test
#' }
#'
#' **Summary Statistics (Aggregated across iterations):**
#' \itemize{
#'   \item \code{decision_error_rate}: Proportion of incorrect decisions
#'   \item \code{mean_n}: Mean sample size across all iterations
#'   \item \code{sd_error_n}: Standard error of the mean sample size (sd(n)/sqrt(n))
#'   \item \code{median_n}: Median sample size (50th percentile)
#'   \item \code{min_n}, \code{max_n}: Minimum and maximum sample sizes observed
#'   \item \code{q25_n}, \code{q50_n}, \code{q75_n}, \code{q90_n}, \code{q95_n}: Sample size quantiles
#'   \item \code{decision_rate_25}, \code{decision_rate_50}, \code{decision_rate_75},
#'         \code{decision_rate_90}, \code{decision_rate_95}, \code{decision_rate_100}:
#'         Cumulative decision rates at various percentages of maximum sample size
#' }
#' @examples
#' \dontrun{
#' # Load data (downloads automatically if needed)
#' df <- load_sample_size_data()
#' head(df)
#' }

load_sample_size_data <- function() {
  cache_dir <- get_sprtt_cache_dir()
  data_file <- file.path(cache_dir, "sprtt_external_data_plan_sample_size.rds")

  # Download if not cached
  if (!file.exists(data_file)) {
    download_sample_size_data()
  }

  # Load and return
  readRDS(data_file)
}

#' Clear cached simulation data
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' Removes locally cached simulation data (~70 MB) used by [`plan_sample_size()`].
#' Data will be automatically re-downloaded on next use of sample size planning functions.
#'
#' This function is useful when:
#' * You want to free up disk space
#' * The cached data may be outdated and you want to force a fresh download
#' * Troubleshooting cache-related issues
#'
#' @return Invisibly returns `TRUE` if cache was cleared, `FALSE` if no cache existed.
#' @export
#' @examples
#' \dontrun{
#' # Clear cache
#' cache_clear()
#' }
cache_clear <- function() {
  cache_dir <- get_sprtt_cache_dir()
  data_file <- file.path(cache_dir, "sprtt_external_data_plan_sample_size.rds")

  if (file.exists(data_file)) {
    unlink(data_file)
    message("Cached simulation data cleared.")
    message("Data will be re-downloaded on next use.")
    return(invisible(TRUE))
  } else {
    message("No cached data found.")
    return(invisible(FALSE))
  }
}

#' Cache information
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' Displays information about cached simulation data (~70 MB) used by [`plan_sample_size()`].
#' Shows the cache directory location, whether data is cached, and file size if present.
#'
#' The simulation data is automatically downloaded on first use of sample size planning
#' functions and stored locally for faster subsequent access.
#'
#' @return Invisibly returns a list with:
#'   * `cache_dir`: Character string with the cache directory path
#'   * `data_cached`: Logical indicating if simulation data is cached
#'   * `file_size_mb`: Numeric file size in MB (or `NA` if not cached)
#'
#' @seealso
#' * [`cache_clear()`] to remove cached data
#' * [`download_sample_size_data()`] to manually download simulation data
#' * [`plan_sample_size()`] which uses the cached data
#'
#' @export
cache_info <- function() {
  cache_dir <- get_sprtt_cache_dir()
  data_file <- file.path(cache_dir, "sprtt_external_data_plan_sample_size.rds")

  info <- list(
    cache_dir = cache_dir,
    data_cached = file.exists(data_file),
    file_size_mb = if (file.exists(data_file)) {
      round(file.size(data_file) / 1e6, 2)
    } else {
      NA
    }
  )

  cat("SPRTT Simulation Data Cache\n")
  cat("---------------------------\n")
  cat("Cache directory:", info$cache_dir, "\n")
  cat("Data cached:", info$data_cached, "\n")
  if (info$data_cached) {
    cat("File size:", info$file_size_mb, "MB\n")
  }

  invisible(info)
}
