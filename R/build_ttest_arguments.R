build_ttest_arguments <- function(input1, y = NULL, data = NULL,
                                  mu, d, alpha, power, alternative, paired){
  if(class(input1) == "formula"){
    x <- extract_formula(formula = input1, data = data, paired = paired, wanted = "x")
    y <- extract_formula(formula = input1, data = data, paired = paired, wanted = "y")
    check_data(input1, x, y, paired)

  }else if(class(input1) == "numeric"){
    x <- input1
    check_data(input1, x, y, paired)
  } else {
    stop("The class of the input1 argument hast to be either 'formula' or 'numeric'.")
  }

  one_sample <- get_one_sample(y)
  one_sided <- get_one_sided(alternative)
  x <- delete_na(x, y, one_sample, paired, wanted = "x")
  y <- delete_na(x, y, one_sample, paired, wanted = "y")

  ttest_arguments <- new("ttest_arguments",
                         x = x,
                         y = y,
                         mu = mu,
                         d = d,
                         alpha = alpha,
                         power = power,
                         alternative = alternative,
                         paired = paired,
                         one_sample = one_sample,
                         one_sided = one_sided
  )
  ttest_arguments
}
