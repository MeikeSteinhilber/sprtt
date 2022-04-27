set.seed(333)
data <- sprtt::draw_sample()
data

data <- sprtt::draw_sample(
  k_groups = 4,
  sd = c(1, 0.8, 1, 1),
  max_n = 30
)
data

