library(doParallel)
library(foreach)

path_expected <- tempfile(fileext = ".txt")
sink(path_expected)

# set up parallel backend
n_cores <- detectCores()
cluster = parallel::makeCluster(n_cores - 1)
registerDoParallel(cluster)

N_sample <- 20:30
p_values <- double(length(N_sample))
i <- 1
t_test <- double(140)
sim <-
  foreach(N = 30:100,  .combine = 'cbind') %dopar% {
    x <- rnorm(N)
    for (mu in 0:2) {
      t_test[i] <- t.test(x, mu = mu)$p.value
      i <- i + 1
      print(i)
    }
    return(t_test)
}
sim

  # for (N in N_sample) {
  #   x <- rnorm(N)
  #   p_values[i] <- t.test(x, )$p.value
  #   for (j in 1:10) {
  #     j
  #   }
  #   i <- i + 1
  # }


# x <- matrix(0, length(3), length(3))
# avec <- 1:3
# bvec <- 1:3
# z <- double(3)
# x <- foreach(b= 1:3, .combine='cbind') %:%
#   z <- rnorm(3)
#   foreach(a= 1:3, .combine='c') %do% {
#     sum(a, b, z)
#   }
# x

sink(file = NULL) # STOP sink
file <- read.csv(path_expected, sep = ";", header = FALSE)


# shut down workers
parallel::stopCluster(cluster)
