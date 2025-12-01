#---- GENERAL SETTINGS ---------------------------------------------------------
# #' @importFrom stats dt df model.frame as.formula runif
#'
#'
#' #---- MAIN FUNCTION DOCUMENTATION ----------------------------------------------
#' Generate an HTML report for sample size planning for sequential ANOVAs.
#'
#' @description
#' Renders a parameterized R Markdown report that helps plan sample size for an SPRT analysis.
#' The function takes expected effect size (`f_expected`), number of groups (`k_groups`),
#' and desired power, then generates a reproducible HTML report summarizing the simulation-based
#' sample size recommendations. The alpha level is always 0.05.
#'
#' The report template is part of the **sprtt** package and is located under
#' `inst/rmarkdown/templates/report_sample_size/skeleton/skeleton.Rmd`.
#'
#' @param f_expected Numeric scalar. The expected standardized effect size (e.g., Cohen’s *f*).
#'   Must be greater than 0.
#' @param k_groups Integer scalar. The number of groups to compare. Must be at least 2.
#' @param power Numeric scalar (default = 0.95). Desired statistical power for the design.
#' @param output_dir Character string. Directory in which to save the rendered HTML report.
#'   Defaults to a temporary directory (`tempdir()`).
#' @param output_file Character string. File name of the generated HTML report.
#'   Defaults to `"sprtt-report-sample-size-planning.html"`.
#' @param open Logical (default = `interactive()`). If `TRUE`, the generated report is opened
#'   in the system’s default web browser after rendering.
#' @param overwrite Logical (default = `FALSE`). If `FALSE` and the target file already exists,
#'   the user is prompted interactively whether to overwrite it. In non-interactive sessions,
#'   an error is raised unless `overwrite = TRUE`.
#'
#' @details
#' This function is a front-end utility for rendering a pre-defined R Markdown report using
#' `rmarkdown::render()`.
#'
#' @return
#' Invisibly returns the path to the rendered HTML file (character string).
#' The report is optionally opened in the default browser.
#'
#' @section File Overwrite Behavior:
#' - If the specified output file already exists:
#'   - and `overwrite = FALSE`, the user is asked whether to overwrite (in interactive sessions);
#'     otherwise, an error is thrown.
#'   - If `overwrite = TRUE`, the file is replaced silently.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Generate and open an SPRT sample size planning report:
#' plan_sample_size(
#'   f_expected = 0.25,
#'   k_groups = 3,
#'   power = 0.9,
#'   output_file = "sprtt-sample-size.html",
#'   open = TRUE
#' )
#'
#' # Prevent overwriting an existing file:
#' plan_sample_size(0.25, 3, overwrite = FALSE)
#' }
#'
#' @seealso
#' [rmarkdown::render()], [utils::browseURL()], and the **sprtt** package report templates.
#'
#' @export


plan_sample_size <- function(f_expected,
                             k_groups,
                             power = 0.95,
                             output_dir = tempdir(),
                             output_file = "sprtt-report-sample-size-planning.html",
                             open = interactive(),
                             overwrite = FALSE) {
  if (!requireNamespace("rmarkdown", quietly = TRUE)) {
    stop("Package 'rmarkdown' must be installed to render the report.", call. = FALSE)
  }

  # Basic validation
  stopifnot(length(f_expected) == 1, is.numeric(f_expected))
  stopifnot(length(power) == 1, is.numeric(power), power > 0, power < 1)
  stopifnot(length(k_groups) == 1, is.numeric(k_groups), k_groups >= 2)


  # check input parameters
  # if (is.null(df)) df <- get("df", envir = asNamespace("sprtt"))
  # if (is.null(df_all)) df_all <- get("df_all", envir = asNamespace("sprtt"))

  if (!f_expected %in% df$f_expected) {
    stop(
      glue("`f_expected` = {f_expected} is not available. Please choose one of {glue_collapse(shQuote(sort(unique(df$f_expected))), ', ', last = ' or ')}")
    )
  }
  if (!power %in% df$power) {
    stop(
      glue("`power` = {power} is not available. Please choose one of {glue_collapse(shQuote(sort(unique(df$power))), ', ', last = ' or ')}")
    )
  }
  if (!k_groups %in% df$k_groups) {
    stop(
      glue("`k_groups` = {k_groups} is not available. Please choose one of {glue_collapse(shQuote(sort(unique(df$k_groups))), ', ', last = ' or ')}")
    )
  }

  # Construct full output path
  output_path <- file.path(output_dir, output_file)

  # Check for existing file
  # Skip overwrite check if the report is meant to be opened immediately
  if (!open && file.exists(output_path)) {
    if (!overwrite) {
      if (interactive()) {
        answer <- utils::menu(c("Yes", "No"),
                              title = sprintf("File '%s' already exists. Overwrite?", output_file)
        )
        if (answer != 1) {
          message("Aborted — file not overwritten.")
          return(invisible(NULL))
        }
      } else {
        stop(sprintf("Output file '%s' already exists. Use overwrite = TRUE to replace it.",
                     output_file),
             call. = FALSE)
      }
    }
  }

  # Locate the Rmd template
  rmd_path <- system.file(
    "rmarkdown", "templates", "report_sample_size", "skeleton", "skeleton.Rmd",
    package = "sprtt", mustWork = TRUE
  )

  # Render the report
  output <- rmarkdown::render(
    rmd_path,
    params = list(
      pick_f_expected = f_expected,
      pick_power = power,
      pick_k_groups = k_groups
    ),
    output_file = output_file,
    output_dir  = output_dir,
    envir = new.env(parent = globalenv())
    )

  if (open) utils::browseURL(output)
  invisible(output)
}


#  plan_sample_size(0.25, 3)
#  plan_sample_size(0.25, 3, output_dir = "C:/Users/msteinhi/GitHub/sprtt/inst/test")
#  plan_sample_size(0.25, 3, output_dir = "C:/Users/msteinhi/GitHub/sprtt/inst/test", overwrite = TRUE)

# plan_sample_size(f_expected = 0.25, k_groups = 3, open = TRUE)

# plan_sample_size(0.25, 3, overwrite = FALSE)

### error messages

# plan_sample_size(0.24, 3, overwrite = FALSE)


#   plan_sample_size(0.10, 3)
#   plan_sample_size(0.15, 3)
#   plan_sample_size(0.20, 3, power = 0.80)
#   plan_sample_size(0.25, 3)
#   plan_sample_size(0.30, 3)
#   plan_sample_size(0.35, 3)
#   plan_sample_size(0.40, 3)
