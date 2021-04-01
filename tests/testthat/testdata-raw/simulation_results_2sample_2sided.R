# DOCUMENTATION ----------------------------------------------------------------


# SIMULATION -------------------------------------------------------------------
# seed
set.seed(333)

# number of repititions per parameter combination
S <- 1000				# choose 80 for quick results

##---- PACKAGES AND HELP FUNCTIONS ---------------------------------------------

library(dplyr)
library(foreach)
library(doParallel)
library(sprtt)
library(PropCIs)

# Clopper-Pearson exact CI
conf.int <- Vectorize(function(x, n, a){
  ci <- exactci(x * n, n, conf.level = 1 - a)
  return(as.numeric(ci$conf.int))
}, "x")

# draws the full sample
draw_sample <- function(n, d) {
  matrix(rnorm(n * 2, mean = c(d, 0)),
         nrow = n, byrow = TRUE)
}


##---- SETTINGS OF THE SIMULATION ----------------------------------------------


# settings for parallel processing
cl <- makeCluster(8)
registerDoParallel(cl)

minN <- 2				# sample size per group at start
maxN <- 50000			# maximum n (increase if reached before decision)
ns <- c(minN:9999, seq(10000, maxN, by = 5))
# ns <- minN:maxN

max_s <- S/getDoParWorkers() # number of repetitions per batch

d_true <- c(rep(0, 3), 0.8, 0.5, 0.2) # true effect sizes
d_hyp <- rep(c(.8, .5, .2), 2) # expected effect sizes
d_mat <- data.frame(d_true, d_hyp) # Cohen's d matrix

alpha <- .05
beta <- .05


##---- THE SIMULATION ----------------------------------------------------------

start <- Sys.time()

sim <- foreach(batch=1:getDoParWorkers(), .combine = rbind) %dopar% {

  normal_final <- matrix(
    NA,
    nrow = nrow(d_mat) * length(alpha) * length(beta) * max_s, ncol = 11,
    dimnames = list(
      NULL,
      c("d", "d_hyp", "alpha", "beta",
        "n", "tValue", "A", "B",
        "LR", "Decision", "error")
      )
  )
  normal_final.counter <- 1

  for(d_i in 1:nrow(d_mat)){ # d_i denotes the index of d_mat

    d0 <- d_mat[d_i, "d_true"]
    d1 <- d_mat[d_i, "d_hyp"]

    for (a in alpha) {

      for (b in beta){

        normal_final0 <- matrix(NA, nrow = max_s, ncol = 11,
                                dimnames = dimnames(normal_final))

        A <- log((1 - b) / a)
        B <- log(b / (1 - a))

        for (i in 1:max_s) {

          maxsamp <- draw_sample(maxN, d0)
          normal_finalhit <- FALSE
          error <- as.numeric(NA)
          normal_finaldec <- -1

          for (n in ns) {

            samp <- maxsamp[1:n,]

            test <- sprtt::seq_ttest(samp[,1],
                                     samp[,2],
                                     d = d1,
                                     alpha = a,
                                     power = 1 - b,
                                     alternative = "two.sided"
                    )
            tVal <- test@t_value
            LR <- test@likelihood_ratio_log

            if(test@decision == "accept H0"){
              normal_finaldec <- 0
              normal_finalhit <- TRUE

              if(d0!=0)
                error <- 1
              else
                error <- 0

              break
            } else if(test@decision == "accept H1"){
              normal_finaldec <- 1
              normal_finalhit <- TRUE

              if(d0!=0)
                error <- 0
              else
                error <- 1

              break
            }

          } # end of n-iteration (single sample)

          if (!normal_finalhit) {
            # nmax was reached before the test reached a decision boundary

            sink(paste0(path, "warnings.txt"), append = T)
            print(paste0("Truncated before decision: Repetition = ", i,
                         "; d = ", d0,
                         "; d_hyp = ", d1,
                         "; Alpha = ", a,
                         "; Beta = ", b,
                         "; batch = ", batch))
            sink()

          }

          normal_final0[i, ] <- c(
            d = d0,
            d_hyp = d1,
            alpha = a,
            beta = b,
            n = n,
            tValue = tVal,
            A = A,
            B = B,
            LR = LR,
            Decision = normal_finaldec,
            error = error)

        }  # end of max_s repetitions (samples per parameter combination)

        normal_final[normal_final.counter:(normal_final.counter + max_s - 1), ] <- normal_final0
        normal_final.counter <- normal_final.counter + max_s

      } # end of beta iteration
    } #end of alpha iteration

  } # end of d_i iteration
  return(normal_final)
}

end <- Sys.time()
cat("\nresults_2sample_2sided: ")
print(end - start)


# THE RESULTS ------------------------------------------------------------------

results_2sample_2sided <- sim %>%
  as_tibble() %>%
  group_by(d, d_hyp, alpha, beta) %>%
  dplyr::summarise(error = mean(error),
                   .groups = "drop") %>%
  dplyr::mutate(ci_l = t(conf.int(error, S, .1))[,1],
                alert = case_when(d == 0 & ci_l > alpha ~ 1,
                                  d > 0 & ci_l > beta ~ 1,
                                  TRUE ~ 0)
                )

# SAVE THE RESULTS -------------------------------------------------------------

testthis::use_testdata(results_2sample_2sided, overwrite = TRUE)

##---- UNDO SET.SEED -----------------------------------------------------------

set.seed(NULL)
