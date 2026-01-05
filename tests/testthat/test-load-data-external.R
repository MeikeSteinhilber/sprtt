test_that("data download works", {
  skip_on_cran()
  skip_if_offline()

  # Clear cache to test fresh download
  cache_clear()

  # Should download successfully
  expect_message(download_sample_size_data(), "Downloading")

  # Should be cached now
  expect_message(download_sample_size_data(), "already cached")
})

test_that("data loads correctly", {
  skip_on_cran()
  skip_if_offline()

  df_all <- load_sample_size_data()

  expect_s3_class(df_all, "data.frame")
  expect_true(nrow(df_all) > 0)
  expect_true("f_expected" %in% names(df_all))
  expect_true("power" %in% names(df_all))
})

test_that("cache management works", {
  skip_on_cran()

  info <- cache_info()
  expect_type(info, "list")
  expect_true("cache_dir" %in% names(info))
})
