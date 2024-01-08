# simulate data for the example ------------------------------------------------
set.seed(333)
data <- sprtt::draw_sample_normal(3, f = 0.25, max_n = 30)

# calculate the SPRT -----------------------------------------------------------
anova_results <- sprtt::seq_anova(y~x, f = 0.25, data = data, plot = TRUE)

# plot the results -------------------------------------------------------------
sprtt::plot_anova(anova_results)

sprtt::plot_anova(anova_results,
                 labels = TRUE,
                 position_labels_x = 0.5,
                 position_labels_y = 0.1,
                 position_lr_x = -0.5,
                 font_size = 25,
                 line_size = 2,
                 highlight_color = "green"
                 )

sprtt::plot_anova(anova_results,
                 labels = FALSE
                 )

# further information ----------------------------------------------------------
# run this code:
vignette("one_way_anova", package = "sprtt")
