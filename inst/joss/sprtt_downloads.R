# Add this after the monthly calculation:
monthly_complete <- monthly %>%
  filter(month < floor_date(Sys.Date(), "month"))  # exclude current incomplete month

ggplot(monthly, aes(x = month, y = monthly_downloads)) +
  geom_col(fill = "#92B4D3", alpha = 0.7, width = 25) +
  # Trend line only on complete months
  geom_smooth(
    data     = monthly_complete,
    method   = "loess",
    span     = 0.75,
    se       = TRUE,
    color    = "#1E4D7B",
    fill     = "#1E4D7B",
    alpha    = 0.15,
    linewidth = 0.8
  ) +
  geom_vline(
    data     = releases,
    aes(xintercept = date),
    linetype = "dashed",
    color    = "#555555",
    linewidth = 0.4
  ) +
  geom_label(
    data       = releases,
    aes(x = date, y = max(monthly$monthly_downloads) * 1.05, label = version),
    size       = 3,
    color      = "#555555",
    label.size = 0.2,
    hjust      = 0.5
  ) +
  annotate(
    "text",
    x     = as.Date("2025-01-01"),
    y     = max(monthly$monthly_downloads) * 1.05,
    label = paste0("Total downloads: ", format(avg_monthly$total, big.mark = ","), "\n",
                   "12-month avg: ", round(avg_recent$mean_last12), "/month"),
    hjust = 0,
    vjust = 3,
    size  = 3,
    color = "#1E4D7B"
  ) +
  scale_x_date(
    date_breaks = "6 months",
    date_labels = "%b %Y",
    limits      = c(as.Date("2021-08-01"), as.Date("2026-03-31"))
  ) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    x       = NULL,
    y       = "Monthly Downloads",
    title   = "CRAN Downloads of the sprtt Package"
    # caption = "Source: CRAN logs via cranlogs."
  ) +
  theme_minimal(base_size = 12) +
  theme(
    axis.text.x        = element_text(angle = 45, hjust = 1),
    panel.grid.minor   = element_blank(),
    panel.grid.major.x = element_blank(),
    plot.title         = element_text(face = "bold", size = 13),
    plot.caption       = element_text(color = "grey50", size = 8)
  )

ggsave("./inst/joss/sprtt_downloads.png", width = 8, height = 4.5, dpi = 300)
