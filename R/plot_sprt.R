
#' Title
#'
#' @param sample_size
#' @param lr_log
#' @param A_boundary
#' @param B_boundary
#' @param labels
#' @param position_labels_x
#' @param position_labels_y
#' @param font_size
#' @param line_size
#'
#' @return
#' @export
#'
#' @examples
plot_sprt <- function(sample_size, lr_log, A_boundary, B_boundary,
                      labels = TRUE,
                      position_labels_x = 0.15,
                      position_labels_y = 0.075,
                      font_size = 15,
                      line_size = 0.8
                      ) {
  results <- data.frame(sample_size, lr_log) %>%
    mutate(decision = case_when(
      lr_log >= A_boundary ~ "H1",
      lr_log <= B_boundary ~ "H0",
      TRUE ~ "CC"
    ))

  N <- nrow(results)
  if (any(results$decision == "H1" | results$decision == "H0")) {
    decision_sample_position <- which(results$decision != "CC")[1]
  } else{
    decision_sample_position <- 0
  }

  max_lr <- max(abs(lr_log))

  # set defaults ---------------------------------------------------------------
  palette <- "Dark2"
  green <- "#69b3a2"
  blue <- "#404080"
  red <- 	"#CD2626" #"#8B0000"
  theme_set(theme_bw(base_size = font_size))

  # create plot ----------------------------------------------------------------

  plot <- results %>%
    # slice(1:decision_sample_position) %>%
    ggplot(aes(x = sample_size, y = lr_log)) +
    xlim(0 , sample_size[N] + sample_size[N]*0.15) +
    geom_line(linewidth = line_size) +
    geom_hline(yintercept = A_boundary, linetype = "dashed", linewidth = line_size) +
    geom_hline(yintercept = B_boundary, linetype = "dashed", linewidth = line_size) +
    labs(#title = glue("f expected = {f_expected}, f simulated = {f_simulated}"),
         x = "Sample Size N",
         y = "Log-Likelihood Ratio") +
    theme_bw(base_size = font_size)

    if (decision_sample_position > 0) {
      plot <- plot +
        geom_point(aes(x = sample_size[decision_sample_position], y = lr_log[decision_sample_position]),
                 color = red, size = line_size*4)
      if (labels == TRUE) {
        LR <- round(exp(lr_log[decision_sample_position]))
        nLR <- sample_size[decision_sample_position]
        plot <- plot +
          annotate(geom = "text",
          x = sample_size[decision_sample_position] + sample_size[decision_sample_position]*0.05, y = 0,
          label = glue("LR[{nLR}] ==~ {LR}"),
          parse = TRUE,
          size = font_size/.pt, color = red)
      }
    } else{
      plot <- plot +
        geom_point(aes(x = sample_size[N], y = lr_log[N]),
                   color = red, size = line_size*4)
      if (labels == TRUE) {
        LR <- round(exp(lr_log[N]))
        nLR <- sample_size[N]
        if(lr_log[N]>0) {y_ = -0.5} else{y_ = 0.5}
        plot <- plot +
          annotate(geom = "text",
                   x = sample_size[N] + sample_size[N]*0.05,
                   y = y_,
                   label = glue("LR[{nLR}] ==~ {LR}"),
                   parse = TRUE,
                   size = font_size/.pt, color = red)
      }
    }

    if (labels == TRUE) {
      distance_h <- ceiling(max_lr*position_labels_y)
      plot <- plot +
        annotate(geom = "text", x = N*position_labels_x, y = A_boundary + distance_h,
                label = "Accept~ H[1]", size = font_size/.pt, parse = TRUE) +
        annotate(geom = "text", x = N*position_labels_x, y = B_boundary - distance_h,
                 label = "Accept~ H[0]", size = font_size/.pt, parse = TRUE)
        # annotate(geom = "text", x = 10, y = B_boundary + distance_h/2,
        #         label = "Continue Sampling")
    }
  plot
}

# set.seed(333)
# k_groups = 2
# f_simulated = 0.40
# f_expected = 0.40
# alpha = 0.05
# power = .95
# max_n = 300
# df <- sprtt::draw_sample_normal(k_groups, f_simulated,max_n)
# N <- nrow(df)
# seq_steps <- seq(k_groups*2, N, k_groups)
# N_reduced <- length(seq_steps)
# decision <- character(N_reduced)
# lr_log <- double(N_reduced)
# lr <- double(N_reduced)
# f_empiric <- double(N_reduced)
# sample_size <- double(N_reduced)
# i = 1
# for (step in seq_steps) {
#   data <- df[1:step, ]
#   seq_results <- sprtt::seq_anova(y~x,
#                                   f = f_expected,
#                                   alpha,
#                                   power,
#                                   data = data)
#   decision[i] <- seq_results@decision
#   lr_log[i] <- seq_results@likelihood_ratio_log
#   lr[i] <- seq_results@likelihood_ratio
#   f_empiric[i] <- seq_results@effect_sizes$cohens_f
#   sample_size[i] <- step
#   i <- i + 1
# }

# plot_sprt(sample_size, lr_log,
#           seq_results@A_boundary_log,
#           seq_results@B_boundary_log
#           )
#
# plot_sprt(sample_size, lr_log,
#           seq_results@A_boundary_log,
#           seq_results@B_boundary_log
#           )

# plot_sprt(sample_size, lr_log,
#           seq_results@A_boundary_log,
#           seq_results@B_boundary_log,
#           labels = TRUE,
#           position_labels_x = 1,
#           position_labels_y = 1,
#           font_size = 20,
#           line_size = 1.5
#           )

# plot_sprt(sample_size, lr_log,
#           seq_results@A_boundary_log,
#           seq_results@B_boundary_log,
#           labels = FALSE)
