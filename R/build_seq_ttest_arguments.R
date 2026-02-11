build_seq_ttest_arguments <- function(
  input1,
  y = NULL,
  data = NULL,
  mu, d, alpha, power, alternative, paired, data_name, na.rm
){

  if (inherits(input1,"formula")) {
    # formula input
    check_formula_ttest(formula = input1, data = data, paired = paired)
    data <- extract_formula_ttest(formula = input1, data = data, wanted = "data")
    one_sample <- ifelse(length(unique(data$x)) == 1, TRUE, FALSE)

  } else if (is.numeric(input1)) {
    # numeric input
    one_sample <- get_one_sample(y)

    if (one_sample) {
      # one sample case
      data = data.frame(
        y = input1,
        x = rep(1,length(input1))
      )
    } else{
      # two sample case
      data = get_long_data(input1,y)

    }
  } else {
    stop(
      "The class of the input1 argument hast to be either 'formula' or 'numeric'."
      )
  }

  # check_data_ttest(data$x, data$y, paired)
  total_sample_size = nrow(data)

  # check data and handle NA
  # data$x <- delete_na(x, y, one_sample, paired, na.rm, wanted = "x")
  # data$y <- delete_na(x, y, one_sample, paired, na.rm, wanted = "y")

  seq_ttest_arguments <-
    new(
      "seq_ttest_arguments",
      # x = x,
      # y = y,
      data = data,
      mu = mu,
      d = d,
      alpha = alpha,
      power = power,
      alternative = alternative,
      paired = paired,
      one_sample = one_sample,
      total_sample_size = total_sample_size,
      data_name = data_name,
      na.rm = na.rm
    )
  seq_ttest_arguments
}


# data <- draw_sample_normal(2, 0.2, max_n = 30)
# colnames(data) <- c("y_t", "x_t")
# formula = input1 = as.formula("y_t ~ x_t"); paired = FALSE; na.rm = TRUE

# input1 = rnorm(20); y = NULL; paired = FALSE; na.rm = TRUE

# data <- draw_sample_normal(2, 0, max_n = 30)
# formula = input1 = as.formula("y ~ 1"); paired = FALSE; na.rm = TRUE
