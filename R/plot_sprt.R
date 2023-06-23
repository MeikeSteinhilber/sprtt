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
#' @param anova_results result object of the seq_anova() function (argument must be of class seq_anova_results).
#' @param labels show labels in the plot.
#' @param position_labels_x position of the boundary labels on the x-axis.
#' @param position_labels_y position of the boundary labels on the y-axis.
#' @param position_lr_x scales the position of the LR label on the x-axis.
#' @param font_size font size of the plot.
#' @param line_size line size of the plot.
#' @param highlight_color highlighting color, default is red.
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
                      position_lr_x = 0.05,
                      font_size = 25,
                      line_size = 1.5,
                      highlight_color = "#CD2626"
                      ) {
  library(dplyr)
  library(purrr)
  library(glue)
  library(ggplot2)

  if (inherits(anova_results, c("seq_ttest_results"))) {
    stop("The plot_anova() function only works for sequential anovas (anova_results argument must be of class seq_anova_results).")
  }
  if (!inherits(anova_results, c("seq_anova_results"))) {
    stop("anova_results argument must be of class seq_anova_results.")
  }

  A_boundary_log <- anova_results@plot$A_boundary_log
  B_boundary_log <- anova_results@plot$B_boundary_log

  results <- data.frame(lr_log = anova_results@plot$lr_log,
                        sample_size = anova_results@plot$sample_size) %>%
    mutate(decision = case_when(
      lr_log >= A_boundary_log ~ "H1",
      lr_log <= B_boundary_log ~ "H0",
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

  # set defaults ---------------------------------------------------------------
  # palette <- "Dark2"
  # green <- "#69b3a2"
  # blue <- "#404080"
  # red <- 	"#CD2626" #"#8B0000"
  theme_set(theme_bw(base_size = font_size))

  # create plot ----------------------------------------------------------------

  plot <- results %>%
    # slice(1:decision_sample_position) %>%
    ggplot(aes(x = sample_size, y = lr_log)) +
    xlim(0 , results$sample_size[N_steps] + results$sample_size[N_steps]*0.15) +
    geom_line(linewidth = line_size) +
    geom_hline(yintercept = A_boundary_log, linetype = "dashed", linewidth = line_size) +
    geom_hline(yintercept = B_boundary_log, linetype = "dashed", linewidth = line_size) +
    labs(#title = glue("f expected = {f_expected}, f simulated = {f_simulated}"),
         x = "Sample Size N",
         y = "Log-Likelihood Ratio") +
    theme_bw(base_size = font_size)

    if (decision_sample_position > 0) {
      plot <- plot +
        geom_point(aes(x = sample_size[decision_sample_position], y = lr_log[decision_sample_position]),
                 color = highlight_color, size = line_size*4)
      if (labels == TRUE) {
        LR <- round(exp(results$lr_log[decision_sample_position]), 2)
        nLR <- results$sample_size[decision_sample_position]
        plot <- plot +
          annotate(geom = "text",
          x = results$sample_size[decision_sample_position] + results$sample_size[decision_sample_position]*position_lr_x, y = 0,
          label = glue("LR[{nLR}] ==~ {LR}"),
          parse = TRUE,
          size = font_size/.pt, color = highlight_color)
      }
    } else{
      plot <- plot +
        geom_point(aes(x = sample_size[N_steps], y = lr_log[N_steps]),
                   color = highlight_color, size = line_size*4)
      if (labels == TRUE) {
        LR <- round(exp(results$lr_log[N_steps]), 2)
        nLR <- results$sample_size[N_steps]
        if (results$lr_log[N_steps]>0) {y_ = -0.5} else{y_ = 0.5}
        plot <- plot +
          annotate(geom = "text",
                   x = results$sample_size[N_steps] + results$sample_size[N_steps]*position_lr_x,
                   y = y_,
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
      distance_h <- ceiling(max_lr*position_labels_y)
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
