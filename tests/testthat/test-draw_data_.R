set.seed(3333)

# null effect ------------------------------------------------------------------
k_groups <- 4
f <- 0
sd <- c(1,1,1,1)
sample_ratio <-  c(1,1,1,1)
max_n <- 200
rep_n <- 100

data <- matrix(
  data = 0,
  nrow = max_n*sum(sample_ratio),
  ncol = rep_n*2
)
f_estimated <- double(rep_n)

a = 1
b = a + 1
for (i in 1:rep_n) {
  if (i == 1) {
    sample <- draw_sample_normal(k_groups = k_groups,
                                  f = f,
                                  sd = sd,
                                  sample_ratio = sample_ratio,
                                  max_n = max_n)
    data[, a] <- as.numeric(sample$x)
    data[, b] <- sample$y
    f_estimated[i] <- effect_sizes(y~x, sample)$cohens_f
    a = b + 1
    b = a + 1
  } else{
    sample <- draw_sample_normal(k_groups = k_groups,
                                  f = f,
                                  sd = sd,
                                  sample_ratio = sample_ratio,
                                  max_n = max_n)
    f_estimated[i] <- effect_sizes(y~x, sample)$cohens_f
    data[, a] <- sample$y
    a = a + 1
  }
}

mean_f_est <- mean(f_estimated)
mean_f_est


# small effect -----------------------------------------------------------------

k_groups <- 4
f <- 0.10
sd <- c(1,1,1,1)
sample_ratio <-  c(1,1,1,1)
max_n <- 200
rep_n <- 100

data <- matrix(
  data = 0,
  nrow = max_n*sum(sample_ratio),
  ncol = rep_n*2
)
f_estimated <- double(rep_n)

a = 1
b = a + 1
for (i in 1:rep_n) {
  if (i == 1) {
    sample <- draw_sample_normal(k_groups = k_groups,
                                 f = f,
                                 sd = sd,
                                 sample_ratio = sample_ratio,
                                 max_n = max_n)
    data[, a] <- as.numeric(sample$x)
    data[, b] <- sample$y
    f_estimated[i] <- effect_sizes(y~x, sample)$cohens_f
    a = b + 1
    b = a + 1
  } else{
    sample <- draw_sample_normal(k_groups = k_groups,
                                 f = f,
                                 sd = sd,
                                 sample_ratio = sample_ratio,
                                 max_n = max_n)
    f_estimated[i] <- effect_sizes(y~x, sample)$cohens_f
    data[, a] <- sample$y
    a = a + 1
  }
}

mean_f_est <- mean(f_estimated)
mean_f_est


# large effect -----------------------------------------------------------------

k_groups <- 4
f <- 0.80
sd <- c(1,1,1,1)
sample_ratio <-  c(1,1,1,1)
max_n <- 200
rep_n <- 100

data <- matrix(
  data = 0,
  nrow = max_n*sum(sample_ratio),
  ncol = rep_n*2
)
f_estimated <- double(rep_n)

a = 1
b = a + 1
for (i in 1:rep_n) {
  if (i == 1) {
    sample <- draw_sample_normal(k_groups = k_groups,
                                 f = f,
                                 sd = sd,
                                 sample_ratio = sample_ratio,
                                 max_n = max_n)
    data[, a] <- as.numeric(sample$x)
    data[, b] <- sample$y
    f_estimated[i] <- effect_sizes(y~x, sample)$cohens_f
    a = b + 1
    b = a + 1
  } else{
    sample <- draw_sample_normal(k_groups = k_groups,
                                 f = f,
                                 sd = sd,
                                 sample_ratio = sample_ratio,
                                 max_n = max_n)
    f_estimated[i] <- effect_sizes(y~x, sample)$cohens_f
    data[, a] <- sample$y
    a = a + 1
  }
}

mean_f_est <- mean(f_estimated)
mean_f_est


# MIXED ------------------------------------------------------------------------

# large effect -----------------------------------------------------------------
set.seed(333)
k_groups <- 4
f <- 0.70
sd <- c(1,1,1,1)
# sd <- c(40,40,40,40)
sample_ratio <-  c(1,1,1,1)
max_n <- 200
rep_n <- 100

data <- matrix(
  data = 0,
  nrow = max_n*sum(sample_ratio),
  ncol = rep_n*2
)
f_estimated <- double(rep_n)

a = 1
b = a + 1
for (i in 1:rep_n) {
  if (i == 1) {
    sample <- draw_sample_mixture(k_groups = k_groups,
                                 f = f,
                                 max_n = max_n)
    data[, a] <- as.numeric(sample$x)
    data[, b] <- sample$y
    f_estimated[i] <- effect_sizes(y~x, sample)$cohens_f
    a = b + 1
    b = a + 1
  } else{
    sample <- draw_sample_mixture(k_groups = k_groups,
                                 f = f,
                                 max_n = max_n)
    f_estimated[i] <- effect_sizes(y~x, sample)$cohens_f
    data[, a] <- sample$y
    a = a + 1
  }
}

mean_f_est <- mean(f_estimated)
mean_f_est
sd_f_est
