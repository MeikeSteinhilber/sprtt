#* @testing plan_sample_size


# helpers ----------------------------------------------------------------------

canon_html <- function(path) {
  stopifnot(file.exists(path))
  doc <- xml2::read_html(path)
  xml2::xml_find_all(doc, "//meta[@name='generator']") |> xml2::xml_remove()
  xml2::xml_find_all(doc, "//comment()") |> xml2::xml_remove()
  txt <- as.character(doc)
  txt <- gsub("[0-9]{4}-[0-9]{2}-[0-9]{2}[ T][0-9]{2}:[0-9]{2}:[0-9]{2}Z?", "<TIME>", txt)
  txt <- gsub("id=\"[A-Za-z0-9_-]{6,}\"", "id=\"<ID>\"", txt)
  txt <- gsub("[ \t]+", " ", txt)
  txt <- gsub("\r\n?", "\n", txt, perl = TRUE)
  txt
}

# error messages ---------------------------------------------------------------

test_that("plan_sample_size: paremters out of scope", {
  expect_error(
    plan_sample_size(f_expected = 0.24, k_groups = 3, overwrite = FALSE),
    "is not available"
  )
  expect_error(
    plan_sample_size(f_expected = 0.25, k_groups = 7, overwrite = FALSE),
    "is not available"
  )
  expect_error(
    plan_sample_size(f_expected = 0.25, k_groups = 3,
                     power = 0.60, overwrite = FALSE),
    "is not available"
  )
})


test_that("plan_sample_size: paremters wrong data type", {
  expect_error(
    plan_sample_size(f_expected = "0.25", k_groups = 3, overwrite = FALSE),
    "is not TRUE"
  )
  expect_error(
    plan_sample_size(f_expected = 0.25, k_groups = "3", overwrite = FALSE),
    "is not TRUE"
  )
  expect_error(
    plan_sample_size(f_expected = 0.25, k_groups = 3,,
                     power = "0.95",
                     overwrite = FALSE),
    "is not TRUE"
  )
})


# general functioning - creating html output -----------------------------------

test_that("template is shipped", {
  p <- system.file("rmarkdown", "templates", "report_sample_size", "skeleton",
                   "skeleton.Rmd", package = "sprtt")
  expect_true(nzchar(p), info = "system.file returned empty path")
  expect_true(file.exists(p), info = "template skeleton.Rmd not found in inst/")
})

test_that("renders HTML to the specified directory", {
  # testthat::skip_if_not_installed("rmarkdown")
  # testthat::skip_if_not(rmarkdown::pandoc_available())
  # Optional: skip on CRAN if render is slow/heavy
  # testthat::skip_on_cran()

  withr::local_tempdir() -> tmp
  out <- plan_sample_size(
    f_expected = sprtt::df$f_expected[1],
    k_groups   = sprtt::df$k_groups[1],
    power      = sprtt::df$power[1],
    output_dir = tmp,
    output_file = "report.html",
    open = FALSE,
    overwrite = TRUE
  )

  # Function returns the output file path (invisible)
  expect_true(is.character(out) && length(out) == 1)
  expect_true(file.exists(out))
  expect_gt(file.info(out)$size, 0)

  # Quick sanity on contents (don’t rely on exact formatting)
  head <- readLines(out, n = 100L, warn = FALSE)
  expect_true(any(grepl("<html", head, ignore.case = TRUE)))
  # If your Rmd has a stable title/headline, check for it too:
  # expect_true(any(grepl("Sample-size report", head, fixed = TRUE)))
})

test_that("renders HTM too", {
  # testthat::skip_if_not_installed("rmarkdown")
  # testthat::skip_if_not(rmarkdown::pandoc_available())

  withr::local_tempdir() -> tmp
  out <- plan_sample_size(
    f_expected = sprtt::df$f_expected[1],
    k_groups   = sprtt::df$k_groups[1],
    power      = sprtt::df$power[1],
    output_dir = tmp,
    output_file = "report.htm",
    open = FALSE,
    overwrite = TRUE
  )
  expect_true(file.exists(out))
  expect_match(out, "\\.htm$", perl = TRUE)
})


test_that("overwrite protection works when open = FALSE", {
  withr::local_tempdir() -> tmp
  path <- file.path(tmp, "report.html")
  cat("<html></html>", file = path)

  expect_error(
    plan_sample_size(
      f_expected = sprtt::df$f_expected[1],
      k_groups   = sprtt::df$k_groups[1],
      power      = sprtt::df$power[1],
      output_dir = tmp,
      output_file = basename(path),
      open = FALSE,
      overwrite = FALSE
    ),
    regexp = "already exists.*overwrite = TRUE",
    ignore.case = TRUE
  )

  # Now with overwrite = TRUE it should succeed
  testthat::skip_if_not_installed("rmarkdown")
  testthat::skip_if_not(rmarkdown::pandoc_available())
  out <- plan_sample_size(
    f_expected = sprtt::df$f_expected[1],
    k_groups   = sprtt::df$k_groups[1],
    power      = sprtt::df$power[1],
    output_dir = tmp,
    output_file = basename(path),
    open = FALSE,
    overwrite = TRUE
  )
  expect_true(file.exists(out))
})


# snapshots of output ----------------------------------------------------------

# too frickle

