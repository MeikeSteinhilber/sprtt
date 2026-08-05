library(dplyr)
library(ggplot2)
library(lubridate)
library(cranlogs)

# --- Data -------------------------------------------------------------------

raw <- cran_downloads("sprtt", from = "2021-08-01", to = Sys.Date())

monthly <- raw %>%
  mutate(month = floor_date(date, "month")) %>%
  group_by(month) %>%
  summarise(monthly_downloads = sum(count), .groups = "drop")

monthly_complete <- monthly %>%
  filter(month < floor_date(Sys.Date(), "month"))

releases <- tribble(
  ~version, ~date,
  "v0.1.0",  as.Date("2021-08-11"),
  "v0.2.0",  as.Date("2023-07-06"),
  "v0.3.1",  as.Date("2026-05-06")
)

avg_monthly <- monthly_complete %>%
  summarise(total = sum(monthly_downloads))

avg_recent <- monthly_complete %>%
  slice_tail(n = 12) %>%
  summarise(mean_last12 = mean(monthly_downloads))


# --- Global font scaling ------------------------------------------------
FONT_SCALE <- 1.4   # increase/decrease to scale all plot text proportionally
base_size  <- 12 * FONT_SCALE

# --- Plot -------------------------------------------------------------------

ggplot(monthly, aes(x = month, y = monthly_downloads)) +
  geom_col(fill = "#92B4D3", alpha = 0.7, width = 25) +
  geom_smooth(
    data      = monthly,
    method    = "loess",
    span      = 0.75,
    se        = TRUE,
    color     = "#1E4D7B",
    fill      = "#1E4D7B",
    alpha     = 0.15,
    linewidth = 0.8
  ) +
  geom_vline(
    data      = releases,
    aes(xintercept = date),
    linetype  = "dashed",
    color     = "#555555",
    linewidth = 0.4
  ) +
  geom_label(
    data        = releases,
    aes(x = date, y = max(monthly$monthly_downloads) * 1.05, label = version),
    size        = 3 * FONT_SCALE,
    color       = "#555555",
    label.size  = 0.2,
    hjust       = 0.5
  ) +
  annotate(
    "text",
    x     = as.Date("2024-09-01"),
    y     = max(monthly$monthly_downloads) * 1.05,
    label = paste0("Total downloads: ", format(avg_monthly$total, big.mark = ","), "\n",
                   "12-month avg: ", round(avg_recent$mean_last12), "/month"),
    hjust = 0,
    vjust = 3,
    size  = 3 * FONT_SCALE,
    color = "#1E4D7B"
  ) +
  scale_x_date(
    date_breaks = "6 months",
    date_labels = "%b %Y",
    limits      = c(as.Date("2021-08-01"), Sys.Date())
  ) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    x     = NULL,
    y     = "Monthly Downloads",
    title = "CRAN Downloads of the sprtt Package"
  ) +
  theme_minimal(base_size = base_size) +
  theme(
    axis.text.x        = element_text(angle = 45, hjust = 1),
    panel.grid.minor   = element_blank(),
    panel.grid.major.x = element_blank(),
    plot.title         = element_text(face = "bold", size = rel(13 / 12)),
    plot.caption       = element_text(color = "grey50", size = rel(8 / 12))
  )

ggsave(
  glue::glue("./inst/joss/figures/sprtt_downloads_{Sys.Date()}.png"),
  width = 8, height = 4.5, dpi = 300
)


peers <- cran_downloads(
  c("sprtt", "SPRT", "Sequential", "safestats"),
  from = Sys.Date() - 365,
  to   = Sys.Date()
) %>%
  group_by(package) %>%
  summarise(mean_monthly = sum(count) / 12)
peers
