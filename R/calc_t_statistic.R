calc_t_statistic <- function(ttest_arguments) {

  if(ttest_arguments@one_sample == TRUE){
    t_statistic <- t.test(x = ttest_arguments@x,
                          mu = ttest_arguments@mu)

  } else if(ttest_arguments@one_sample == FALSE && ttest_arguments@paired == FALSE){
    t_statistic <- t.test(x = ttest_arguments@x,
                          y = ttest_arguments@y,
                          mu = ttest_arguments@mu,
                          var.equal = T)

  } else if(ttest_arguments@one_sample == FALSE && ttest_arguments@paired == TRUE){
    t_statistic <- t.test(x = ttest_arguments@x,
                          y = ttest_arguments@y,
                          mu = ttest_arguments@mu,
                          paired = TRUE)
  } else{
    stop("t-value could not be calculated. Is the input correct?")
  }

  if(ttest_arguments@alternative == "less"){
    t_statistic$statistic <- t_statistic$statistic * -1
  }

  t_statistic
}


