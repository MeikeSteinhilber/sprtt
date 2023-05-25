set.seed(333)

data <- sprtt::draw_sample_mixture(
  k_groups = 2,
  f = 0.40,
  max_n = 10
)
data

data <- sprtt::draw_sample_mixture(
  k_groups = 4,
  f = 0.8,
  max_n = 5,
  verbose = TRUE,
  counter_n = 150
)
data
