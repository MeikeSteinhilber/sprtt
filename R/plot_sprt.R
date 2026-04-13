#' Plot Sequential ANOVA Results
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' Creates a visualization of the sequential probability ratio test (SPRT) for
#' ANOVA results, showing the log-likelihood ratio trajectory across sample sizes
#' and decision boundaries.
#'
#' @param anova_results A `seq_anova_results` object from [seq_anova()].
#'   **Important:** The `seq_anova()` function must be called with `plot = TRUE`
#'   to generate the necessary data for plotting.
#' @param labels Logical. If `TRUE` (default), display decision labels
#'   ("Accept H0" / "Accept H1") and the likelihood ratio at the decision point.
#' @param position_labels_x Numeric value between 0 and 1 controlling the
#'   horizontal position of decision labels as a proportion of maximum sample
#'   size. Default is `0.15` (left side); `0.5` centers the labels.
#' @param position_labels_y Numeric value controlling the vertical spacing
#'   between decision boundaries and their labels. The value is multiplied by
#'   `max(|log-likelihood ratio|)` to determine spacing. Larger values move
#'   labels further from boundaries. Default is `0.075`.
#' @param position_lr_x Optional numeric value for the x-coordinate (sample size)
#'   of the likelihood ratio label. If `NULL` (default), positioned at the
#'   decision point or final sample size.
#' @param position_lr_y Optional numeric value for the y-coordinate
#'   (log-likelihood ratio) of the likelihood ratio label. If `NULL` (default),
#'   positioned at `y = 0` for early decisions, or slightly offset for
#'   continuing sampling scenarios.
#' @param font_size Numeric. Base font size for plot text. Default is `20`.
#' @param line_size Numeric. Line width for the trajectory and boundaries.
#'   Default is `1.5`.
#' @param highlight_color Character string. Color for highlighting the decision
#'   point or final sample. Default is `"#CD2626"` (red).
#'
#' @return A [ggplot2::ggplot()] object showing:
#'   \itemize{
#'     \item Log-likelihood ratio trajectory across sample sizes
#'     \item Dashed horizontal lines indicating decision boundaries
#'     \item Highlighted point showing where decision was reached (or final sample)
#'     \item Optional labels for decision regions and likelihood ratio value
#'   }
#'
#' @import ggplot2 glue purrr
#'
#' @export
#'
#' @example inst/examples/plot_anova.R
#'
plot_anova <- function(anova_results,
                      labels = TRUE,
                      position_labels_x = 0.15,
                      position_labels_y = 0.1,
                      position_lr_x = NULL,
                      position_lr_y = NULL,
                      font_size = 15,
                      line_size = 1,
                      highlight_color = "#CD2626"
                      ) {

  if (inherits(anova_results, c("seq_ttest_results"))) {
    stop("The plot_anova() function only works for sequential anovas (anova_results argument must be of class seq_anova_results).")
  }
  if (!inherits(anova_results, c("seq_anova_results"))) {
    stop("anova_results argument must be of class seq_anova_results.")
  }

  if (is.null(anova_results@plot)) {
    stop("The anova_results@plot is NULL. Solution: The function argument `plot` must be set to TRUE in the seq_anova() function.")
  }

  A_boundary_log <- anova_results@A_boundary_log
  B_boundary_log <- anova_results@B_boundary_log

  results <- data.frame(lr_log = anova_results@plot$lr_log,
                        sample_size = anova_results@plot$sample_size) %>%
    mutate(decision = case_when(
      .data$lr_log >= A_boundary_log ~ "H1",
      .data$lr_log <= B_boundary_log ~ "H0",
      TRUE ~ "CS"
    ))

  N_steps <- nrow(results)
  N <- results$sample_size[N_steps]

  if (any(results$decision == "H1" | results$decision == "H0")) {
    decision_sample_position <- which(results$decision != "CS")[1]
  } else{
    decision_sample_position <- 0
  }

  max_lr <- max(abs(results$lr_log))
  lr_factor <- 0.05


  # set defaults ---------------------------------------------------------------
  # palette <- "Dark2"
  # green <- "#69b3a2"
  # blue <- "#404080"
  # red <- 	"#CD2626" #"#8B0000"
  theme_set(theme_bw(base_size = font_size))

  # create plot ----------------------------------------------------------------

  plot <- results %>%
    # slice(1:decision_sample_position) %>%
    ggplot(aes(x = .data$sample_size, y = .data$lr_log)) +
    xlim(0 , results$sample_size[N_steps] + results$sample_size[N_steps]*(lr_factor+0.1)) +
    geom_line(linewidth = line_size) +
    geom_hline(yintercept = A_boundary_log, linetype = "dashed", linewidth = line_size) +
    geom_hline(yintercept = B_boundary_log, linetype = "dashed", linewidth = line_size) +
    labs(#title = glue("f expected = {f_expected}, f simulated = {f_simulated}"),
         x = "Sample Size N",
         y = "Log-Likelihood Ratio") +
    theme_bw(base_size = font_size)

    if (decision_sample_position > 0) {
      x_decision <- results$sample_size[decision_sample_position]
      y_decision <- results$lr_log[decision_sample_position]

      plot <- plot +
        annotate("point",
                 x = x_decision,
                 y = y_decision,
                 colour = highlight_color,
                 size = line_size * 4)

      if (labels == TRUE) {
        LR <- round(exp(results$lr_log[decision_sample_position]), 2)
        nLR <- results$sample_size[decision_sample_position]

        if (is.null(position_lr_y)) {
          position_lr_y <- 0
        }

        if (is.null(position_lr_x)) {
          position_lr_x <- results$sample_size[decision_sample_position] + results$sample_size[decision_sample_position]*lr_factor
        }

        plot <- plot +
          annotate(
            geom = "text",
            x = position_lr_x,
            y = position_lr_y,
            label = glue("LR[{nLR}] ==~ {LR}"),
            parse = TRUE,
            size = font_size/.pt, color = highlight_color
          )
      }
    } else{
      x_last <- results$sample_size[N_steps]
      y_last <- results$lr_log[N_steps]

      plot <- plot +
        annotate("point",
                 x = x_last,
                 y = y_last,
                 colour = highlight_color,
                 size = line_size * 4)

      if (labels == TRUE) {
        LR <- round(exp(results$lr_log[N_steps]), 2)
        nLR <- results$sample_size[N_steps]

        if (is.null(position_lr_y)) {
          if (results$lr_log[N_steps] > 0) {position_lr_y = -0.5} else {position_lr_y = 0.05}
        }

        if (is.null(position_lr_x)) {
          position_lr_x <- results$sample_size[N_steps] + results$sample_size[N_steps]*lr_factor
        }

        plot <- plot +
          annotate(geom = "text",
                   x = position_lr_x,
                   y = position_lr_y,
                   label = glue("LR[{nLR}] ==~ {LR}"),
                   parse = TRUE,
                   size = font_size/.pt, color = highlight_color)
      }
    }

    if (labels == TRUE) {
      if (decision_sample_position == 0) {
        h0_col <- "black"
        h1_col <- "black"
      } else if (results$decision[decision_sample_position] == "H1") {
        h0_col <- "black"
        h1_col <- highlight_color
      } else if (results$decision[decision_sample_position] == "H0") {
        h0_col <- highlight_color
        h1_col <- "black"
      }
      distance_h <- max_lr*position_labels_y
      plot <- plot +
        annotate(geom = "text", x = N*position_labels_x, y = A_boundary_log + distance_h,
                label = "Accept~ H[1]", size = font_size/.pt, parse = TRUE, color = h1_col) +
        annotate(geom = "text", x = N*position_labels_x, y = B_boundary_log - distance_h,
                 label = "Accept~ H[0]", size = font_size/.pt, parse = TRUE, color = h0_col)
        # annotate(geom = "text", x = 10, y = B_boundary_log + distance_h/2,
        #         label = "Continue Sampling")
    }
  plot
}

# labels = TRUE
# position_labels_x = 0.15
# position_labels_y = 0.075
# font_size = 25
# line_size = 1.5
# highlight_color = "#CD2626"
# position_lr_x = 0.05
