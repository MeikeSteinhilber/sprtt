.onAttach <- function(libname, pkgname) {
  cache_dir <- get_sprtt_cache_dir()
  data_file <- file.path(cache_dir, "df_all.rds")

  if (!file.exists(data_file)) {
    packageStartupMessage(
      "Note: Sample size planning functions require simulation data (~15 MB).\n",
      "Data will download automatically on first use.\n",
      "See ?download_sample_size_data for more information."
    )
  }
}
