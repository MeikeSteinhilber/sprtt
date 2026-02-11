get_long_data <- function(x,y) {
  n_x <- length(x)
  n_y <- length(y)
  n_max <- max(n_x, n_y)

  data <- data.frame(
    values = c(rbind(
      c(x, rep(NA, n_max - n_x)),
      c(y, rep(NA, n_max - n_y))
    )),
    ind = rep(c(1, 2), times = n_max)
  )

  data <- data[!is.na(data$values), ]
  colnames(data) <- c("y", "x")
  data
}
