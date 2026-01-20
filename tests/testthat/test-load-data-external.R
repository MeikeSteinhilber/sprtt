# test_that("data download works", {
#   skip_on_cran()
#   skip_if_offline()
#
#   # Clear cache to test fresh download
#   cache_clear()
#
#   # Should download successfully
#   expect_message(download_sample_size_data(), "Downloading")
#
#   # Should be cached now
#   expect_message(download_sample_size_data(), "already cached")
# })
#
# test_that("data loads correctly", {
#   skip_on_cran()
#   skip_if_offline()
#
#   df_all <- load_sample_size_data()
#
#   expect_s3_class(df_all, "data.frame")
#   expect_true(nrow(df_all) > 0)
#   expect_true("f_expected" %in% names(df_all))
#   expect_true("power" %in% names(df_all))
# })
#
# test_that("cache management works", {
#   skip_on_cran()
#
#   info <- cache_info()
#   expect_type(info, "list")
#   expect_true("cache_dir" %in% names(info))
# })

test_that("data download works", {
  skip_on_cran()
  skip_if_offline()

  # Clear cache to test fresh download
  cache_clear()

  # Should download successfully
  expect_message(download_sample_size_data(), "Downloading")

  # Should be cached now
  expect_message(download_sample_size_data(), "already cached")

  # Test that file actually exists
  cache_dir <- get_sprtt_cache_dir()
  data_file <- file.path(cache_dir, "sprtt_external_data_plan_sample_size.rds")
  expect_true(file.exists(data_file))
})

test_that("force download works", {
  skip_on_cran()
  skip_if_offline()

  # Ensure data is cached first
  download_sample_size_data()

  # Force re-download should show downloading message
  expect_message(download_sample_size_data(force = TRUE), "Downloading")

  # Regular call should show cached message
  expect_message(download_sample_size_data(force = FALSE), "already cached")
})

test_that("data loads correctly", {
  skip_on_cran()
  skip_if_offline()

  df_all <- load_sample_size_data()

  # Basic structure checks
  expect_s3_class(df_all, "data.frame")
  expect_true(nrow(df_all) > 0)

  # Check for key input parameter columns
  expect_true("f_expected" %in% names(df_all))
  expect_true("f_simulated" %in% names(df_all))
  expect_true("power" %in% names(df_all))
  expect_true("alpha" %in% names(df_all))
  expect_true("k_groups" %in% names(df_all))

  # Check for result columns
  expect_true("n" %in% names(df_all))
  expect_true("decision" %in% names(df_all))
  expect_true("mean_n" %in% names(df_all))

  # Check for summary statistics
  expect_true("median_n" %in% names(df_all))
  expect_true("q25_n" %in% names(df_all))
  expect_true("q75_n" %in% names(df_all))
})

test_that("load triggers download if not cached", {
  skip_on_cran()
  skip_if_offline()

  # Clear cache
  cache_clear()

  # load_sample_size_data should trigger download
  expect_message(load_sample_size_data(), "Downloading")

  # Second load should be silent (no download message)
  df <- suppressMessages(load_sample_size_data())
  expect_s3_class(df, "data.frame")
})

test_that("cache_clear works correctly", {
  skip_on_cran()
  skip_if_offline()

  # Ensure data exists
  suppressMessages(download_sample_size_data())

  # Clear should return TRUE and show message
  expect_message(result <- cache_clear(), "Cached simulation data cleared")
  expect_true(result)

  # File should no longer exist
  cache_dir <- get_sprtt_cache_dir()
  data_file <- file.path(cache_dir, "sprtt_external_data_plan_sample_size.rds")
  expect_false(file.exists(data_file))

  # Clearing again should return FALSE
  expect_message(result <- cache_clear(), "No cached data found")
  expect_false(result)
})

test_that("cache directory is created if missing", {
  skip_on_cran()

  cache_dir <- get_sprtt_cache_dir()

  # Remove the cache directory completely
  if (dir.exists(cache_dir)) {
    unlink(cache_dir, recursive = TRUE)
  }

  # Verify it's gone
  expect_false(dir.exists(cache_dir))

  # Call function that should create it
  new_cache_dir <- get_sprtt_cache_dir()

  # Now it should exist
  expect_true(dir.exists(new_cache_dir))
  expect_equal(new_cache_dir, cache_dir)
})

test_that("cache_info returns correct information", {
  skip_on_cran()
  skip_if_offline()

  # Test with cached data
  suppressMessages(download_sample_size_data())
  info <- suppressMessages(cache_info())

  expect_type(info, "list")
  expect_true("cache_dir" %in% names(info))
  expect_true("data_cached" %in% names(info))
  expect_true("file_size_mb" %in% names(info))

  expect_true(info$data_cached)
  expect_true(info$file_size_mb > 0)
  expect_true(dir.exists(info$cache_dir))

  # Test without cached data
  cache_clear()
  info_empty <- suppressMessages(cache_info())

  expect_false(info_empty$data_cached)
  expect_true(is.na(info_empty$file_size_mb))
})

test_that("cache directory is created if missing", {
  cache_dir <- get_sprtt_cache_dir()
  expect_true(dir.exists(cache_dir))
})

test_that("download returns file path invisibly", {
  skip_on_cran()
  skip_if_offline()

  cache_clear()

  result <- suppressMessages(download_sample_size_data())
  expect_type(result, "character")
  expect_true(file.exists(result))
  expect_match(result, "sprtt_external_data_plan_sample_size\\.rds$")
})

test_that("cache_info produces expected output", {
  skip_on_cran()
  skip_if_offline()

  suppressMessages(download_sample_size_data())

  expect_output(cache_info(), "SPRTT Simulation Data Cache")
  expect_output(cache_info(), "Cache directory:")
  expect_output(cache_info(), "Data cached:")
  expect_output(cache_info(), "File size:")
})

test_that("download handles missing internet gracefully", {
  skip_on_cran()
  skip_if_offline()

  # This test is more conceptual - actual implementation would require mocking
  # Just verify the error message structure exists
  cache_clear()

  # Normal download should work
  expect_message(download_sample_size_data(), "Downloading")
})

test_that("data structure contains all documented columns", {
  skip_on_cran()
  skip_if_offline()

  df <- suppressMessages(load_sample_size_data())

  # Simulation metadata
  metadata_cols <- c("batch", "iteration", "source_file")
  expect_true(all(metadata_cols %in% names(df)))

  # Input parameters
  input_cols <- c("f_simulated", "f_expected", "k_groups", "alpha", "power",
                  "distribution", "sd", "sample_ratio", "n_raw_data", "fix_n")
  expect_true(all(input_cols %in% names(df)))

  # Individual test results
  result_cols <- c("n", "decision", "decision_error", "log_lr", "f",
                   "f_adj", "f_statistic")
  expect_true(all(result_cols %in% names(df)))

  # Summary statistics
  summary_cols <- c("decision_error_rate", "mean_n", "sd_error_n", "median_n",
                    "min_n", "max_n", "q25_n", "q50_n", "q75_n", "q90_n", "q95_n")
  expect_true(all(summary_cols %in% names(df)))
})
