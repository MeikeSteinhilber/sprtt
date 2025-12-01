#' Plot Sequential ANOVA Results
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' Creates plots for the results of the seq_anova() function.
#'
# #' @param sample_size sample size.
# #' @param lr_log log-likelihood-ratio.
# #' @param A_boundary_log Log of the A boundary.
# #' @param B_boundary_log Log of the B boundary.
#' @param anova_results result object of the seq_anova() function (argument must be of class `seq_anova_results`).
#' @param labels show labels in the plot.
#' @param position_labels_x Numeric value controlling the horizontal position of
#'   the decision labels ("Accept H0" / "Accept H1"). The value is interpreted
#'   as a proportion of the maximum sample size `N`, i.e., the labels are placed
#'   at `x = N * position_labels_x`. Defaults to `0.15`, which places the labels
#'   near the left side of the plot. `0.5` places the labels in the center.
#' @param position_labels_y Numeric value controlling the vertical offset of the
#'   decision labels from the decision boundaries. The value is multiplied by
#'   the maximum absolute log–likelihood ratio (`max(|lr_log|)`) to obtain the
#'   vertical distance between the boundary lines and the corresponding text.
#'   Larger values move the labels further away from the boundary lines.
#'   Defaults to `0.075`.
#' @param position_lr_x Optional numeric value specifying the x-coordinate of
#'   the LR label in data units (i.e., on the sample size axis). If `NULL`
#'   (default), the LR label is placed at the sample size where the highlighted
#'   point occurs: at the stopping sample size if a decision was reached, or at
#'   the final sample size otherwise.
#' @param position_lr_y Optional numeric value specifying the y-coordinate of
#'   the LR label in data units (i.e., on the log–likelihood ratio axis). If
#'   `NULL` (default), the LR label is placed on the horizontal axis (`y = 0`)
#'   when a decision was reached early. If no decision boundary was crossed, the
#'   LR label is placed slightly above or below zero, depending on the sign of
#'   the final log–likelihood ratio, so that the label does not overlap the
#'   highlighted point.
#' @param font_size font size of the plot.
#' @param line_size line size of the plot.
#' @param highlight_color highlighting color, default is "#CD2626" (red).
#'
#' @import ggplot2 glue purrr
#'
#' @return returns a plot
#' @export
#'
#' @example inst/examples/plot_anova.R
#'
plot_anova <- function(anova_results,
                      labels = TRUE,
                      position_labels_x = 0.15,
                      position_labels_y = 0.075,
                      position_lr_x = NULL,
                      position_lr_y = NULL,
                      font_size = 25,
                      line_size = 1.5,
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
  lr_factor <- 0.1


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
    xlim(0 , results$sample_size[N_steps] + results$sample_size[N_steps]*(lr_factor+0.05)) +
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
