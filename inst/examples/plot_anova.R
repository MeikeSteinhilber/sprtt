# simulate data for the example ------------------------------------------------
set.seed(3)
data <- sprtt::draw_sample_normal(3, f = 0.25, max_n = 50)

# calculate the SPRT -----------------------------------------------------------
anova_results <- sprtt::seq_anova(y~x, f = 0.25, data = data, plot = TRUE)

# plot the results -------------------------------------------------------------
# default settings
sprtt::plot_anova(anova_results)
# variant 1
sprtt::plot_anova(anova_results,
                 labels = TRUE,
                 position_labels_x = 0.05,
                 position_lr_x = 150,
                 position_lr_y = 0,
                 highlight_color = "green"
                 )
# variant 2
sprtt::plot_anova(anova_results,
                  labels = TRUE,
                  position_labels_x = 0.15,
                  position_labels_y = 0.2,
                  position_lr_x = 60,
                  position_lr_y = 1,
                  font_size = 25,
                  line_size = 2,
                  highlight_color = "darkred"
)
# no labels
sprtt::plot_anova(anova_results,
                 labels = FALSE
                 )
# custom additions
sprtt::plot_anova(anova_results) +
  ggplot2::geom_vline(xintercept = 66, linewidth = 1, linetype = "dashed")

# further information ----------------------------------------------------------
# run this code:
vignette("one_way_anova", package = "sprtt")
