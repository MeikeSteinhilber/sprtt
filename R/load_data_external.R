# R/data_external.R

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
#' Downloads pre-computed simulation results from GitHub releases.
#' Data is cached locally and only needs to be downloaded once.
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
download_sample_size_data <- function(force = FALSE) {
  cache_dir <- get_sprtt_cache_dir()
  data_file <- file.path(cache_dir, "sprtt_external_data_plan_sample_size.rds")

  if (file.exists(data_file) && !force) {
    message("Simulation data already cached at: ", data_file)
    return(invisible(data_file))
  }

  message("Downloading simulation data for sample size planning...")
  message("This is a one-time download (~15 MB).")

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

#' Load simulation data for sample size planning
#'
#' @description
#' `r lifecycle::badge("experimental")`
#' Loads pre-computed simulation results. Downloads data if not already cached.
#'
#' @return A data frame with simulation results
#' @export
#' @examples
#' \dontrun{
#' # Load data (downloads automatically if needed)
#' df_all <- load_sample_size_data()
#' head(df_all)
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
#' Removes locally cached simulation data. Data will be re-downloaded on next use.
#'
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
  } else {
    message("No cached data found.")
  }
}

#' Cache information
#' @description
#' `r lifecycle::badge("experimental")`
#' Get information about cached simulation data
#'
#' @return List with cache directory path, file existence, and file size
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
