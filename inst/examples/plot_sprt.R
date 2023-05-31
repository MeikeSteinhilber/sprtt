# simulate data for the example ------------------------------------------------
set.seed(333)
k_groups = 2
df <- sprtt::draw_sample_normal(k_groups, f = 0.25, max_n = 55)

seq_steps <- seq(k_groups*2, nrow(df), k_groups)
lr_log <- double(length(seq_steps))
sample_size <- double(length(seq_steps))
i = 1

# calculate the sequential ANOVA on the data -----------------------------------
for (step in seq_steps) {
  data <- df[1:step, ]
  seq_results <- sprtt::seq_anova(y~x, f = 0.15, data = data)
  lr_log[i] <- seq_results@likelihood_ratio_log
  sample_size[i] <- step
  i <- i + 1
}

# use the sprt_plot function ---------------------------------------------------
sprtt::plot_sprt(sample_size, lr_log,
          seq_results@A_boundary_log,
          seq_results@B_boundary_log
          )

sprtt::plot_sprt(sample_size, lr_log,
          seq_results@A_boundary_log,
          seq_results@B_boundary_log,
          labels = TRUE,
          position_labels_x = 1,
          position_labels_y = 0.1,
          font_size = 20,
          line_size = 1.5
          )
