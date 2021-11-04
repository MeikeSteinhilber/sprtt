library(doParallel)
library(foreach)


# start sink -------------------------------------------------------------------
name_file_output <- "output.txt"
name_file_message <- "message.txt"
file_output <- file(name_file_output, open = "wt")
file_message <- file(name_file_message, open = "wt")
sink(file_output, type = "output")
sink(file_message, type = "message")
stop("TEST ERROR")
stop("TEST ERROR")
1234

# close sink -------------------------------------------------------------------
## reset message sink and close the file connection
sink(type = "output")
sink(type = "message")
close(file_output)
close(file_message)
# file.show(name_file_output)
# file.show(name_file_message)

file_output <- read.csv(name_file_output, sep = ";", header = FALSE)
string_output <- toString(read.csv(name_file_output, sep = ";", header = FALSE))
file <- read.csv(name_file_message, sep = ";", header = FALSE)
string_message <- toString(read.csv(name_file_message, sep = ";", header = FALSE))


# simulation -------------------------------------------------------------------

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





