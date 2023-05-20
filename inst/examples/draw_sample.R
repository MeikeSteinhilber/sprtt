set.seed(333)

data <- sprtt::draw_sample(
  k_groups = 2,
  f = 0.20,
  max_n = 30
)
data

data <- sprtt::draw_sample(
  k_groups = 4,
  f = 0,
  max_n = 25,
  sd = c(1, 2, 1, 8)
)
data

data <- sprtt::draw_sample(
  k_groups = 3,
  f = 0.40,
  max_n = 30,
  sd = c(1, 0.8, 1),
  sample_ratio = c(1, 2, 3)
)
data
