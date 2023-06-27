set.seed(333)

data <- sprtt::draw_sample_mixture(
  k_groups = 2,
  f = 0.40,
  max_n = 2
)
data

data <- sprtt::draw_sample_mixture(
  k_groups = 4,
  f = 1.2, # very large effect size
  max_n = 2,
  counter_n = 1000, # increase of counter is necessary
  verbose = TRUE # prints more information to the console
)
data
