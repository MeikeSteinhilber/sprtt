# DISCLAIMER ------------------------------------------------------------------

# This script is based on a script by Felix Schoenbrodt for the paper
# "Sequential Hypothesis Testing with Bayes Factors: Efficiently Testing Mean
# Differences" by Schoenbrodt, Wagenmakers, Zehetleitner, and Perugini (2017).
# The original script was obtained from https://osf.io/qny5x/

# DOCUMENTATION ----------------------------------------------------------------

# run this script after a huge change
# the simulation takes about 1.5 h (on Meikes Laptop)
# the simulated data are stored in the folder: "test/testthat/_simulation"
# the data are needed for the test: "test-seq_ttest_AB_simulation"
# NOTE: maybe you need to delete the previous data to get correct results

# SIMULATION -------------------------------------------------------------------
set.seed(33)
path = "tests/testthat/_simulation/paired/"
# path = "_simulation/results/"

##---- PACKAGES AND HELP FUNCTIONS ---------------------------------------------


library(foreach)
library(doParallel)
library(sprtt)

# normal data (two sample)
# draw_sample <- function(n, d) {
#   matrix(rnorm(n*2, mean=c(d,0)),
#          nrow=n, byrow = TRUE)
# }

# paired data
draw_sample <- dunction(n, d) {
  baseline <- rnorm(n, mean = 0)
  treatment <- baseline + rnorm(n, mean = d)
  matrix(c(baseline, treatment), nrow = n, byrow = FALSE)
}

# Hedges' g using the approximation for c(m) introduced by Hedges (1981),
# assuming equal sample size in both groups
hedges.g <- function(x,y,n){
  cd <- (mean(x)-mean(y))/sqrt((n-1)*(var(x)+var(y))/(2*n-2))
  cm <- 1-3/(8*n-9)
  return(cd*cm)
}


##---- SETTINGS OF THE SIMULATION --------------------------------------------------


# settings for parallel processing
numCores <- detectCores()
cl <- makeCluster(numCores)
registerDoParallel(cl)
getDoParWorkers() #check

minN <- 2				# sample size per group at start
maxN <- 100000			# maximum n (increase if reached before decision)
ns <- c(minN:9999, seq(10000,maxN, by=50))

S <- 1000			# number of repititions per parameter combination
max_s <- S/getDoParWorkers() # number of repetitions per batch

d_true <- c(1.2, 1, 0.8, 0.6, 0.5, 0.2, 0) # true effect sizes
d_hyp <- c(1.2, 1, 0.8, 0.6, 0.5, 0.2) # expected effect sizes

alpha <- c(.05, .01)
beta <- c(.1, .05)


##---- THE SIMULATION ----------------------------------------------------------

start <- Sys.time()
sink(paste0(path, "progress.txt"))
print(paste0("Simulation started at: ", start))
sink()

sim <- foreach(batch=1:getDoParWorkers(), .combine=function(...) {}) %dopar% {

  progress.counter <- 1
  # number of parameter combinations
  nCom <- length(d_true)*length(d_hyp)*length(alpha)*length(beta)

  for(d0 in d_true){ # d0 denotes the true effect size

    for (d1 in d_hyp){ #d1 denotes the expected effect size

      final <- matrix(NA,
                      nrow=length(alpha)*length(beta)*max_s,
                      ncol=14,
                      dimnames=list(
                        NULL,
                        c("d", "d_hyp", "alpha", "beta", "batch",
                          "rep", "n", "tValue", "g_est", "A", "B",
                          "LR", "Decision", "error")))
      final.counter <- 1

      for (a in alpha) {

        for (b in beta){

          final0 <- matrix(NA, nrow=max_s, ncol=14, dimnames=dimnames(final))

          A <- log((1-b)/a)
          B <- log(b/(1-a))

          for (i in 1:max_s) {

            maxsamp <- draw_sample(maxN, d0)
            finalhit <- FALSE
            error <- as.numeric(NA)
            finaldec <- -1

            for (n in ns) {

              samp <- maxsamp[1:n,]
              test <- sprtt::seq_ttest(samp[,1],
                                       samp[,2],
                                       d = d1,
                                       alpha = a,
                                       power = 1 - b,
                                       paired = TRUE)
              tVal <- test@t_value
              f <- test@df # degrees of freedom
              g <- test@non_centrality_parameter
              LR <- test@likelihood_ratio_log

              if(test@decision == "accept H0"){
                finaldec <- 0
                finalhit <- TRUE

                if(d0!=0)
                  error <- 1
                else
                  error <- 0

                break
              } else if(test@decision == "accept H1"){
                finaldec <- 1
                finalhit <- TRUE

                if(d0!=0)
                  error <- 0
                else
                  error <- 1

                break
              }

            } # end of n-iteration (single sample)

            if (!finalhit) {
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

            final0[i, ] <- c(
              d = d0,
              d_hyp = d1,
              alpha = a,
              beta = b,
              batch = batch,
              rep = i,
              n = n,
              tValue = tVal,
              g_est = hedges.g(maxsamp[1:n, 1], maxsamp[1:n, 2], n),
              A = A,
              B = B,
              LR = LR,
              Decision = finaldec,
              error = error)

          }  # end of max_s repetitions (samples per parameter combination)

          final[final.counter:(final.counter+max_s-1), ] <- final0
          final.counter <- final.counter+max_s

          rm(final0)
          gc(reset=TRUE)

          progress.counter <- progress.counter + 1

          sink(paste0(path, "progress.txt"), append = T)
          print(paste0(Sys.time(), ": batch = ", batch, "; ", progress.counter,
                       "/", nCom,
                       " steps completed (",
                       round(progress.counter/nCom, digits=2)*100,
                       "%)"))
          sink()

        } # end of beta iteration
      } #end of alpha iteration

      final <- as.data.frame(final)
      save(final, file=paste0(path, "true_", d0, "_expected_", d1,
                              "_batch_", batch, ".RData"))

      rm(final)
      gc(reset=TRUE)

    } # end of d_hyp iteration
  } # end of d_true iteration
}
stopImplicitCluster()
end <- Sys.time()

sink(paste0(path, "progress.txt"), append = T)
print(paste0("Simulation ended at: ", end))
print((end-start))
sink()

print(Sys.time())
print(end - start)


# SIMULATION RESULTS ---------------------------------------------------------------

##---- PACKAGES AND HELP FUNCTIONS ---------------------------------------------

#
library(plyr)
library(dplyr)
library(PropCIs)
library(pwr)

conf.int <- Vectorize(function(x, n, a){
  ci <- exactci(x*n, n, conf.level = 1 - a)
  return(as.numeric(ci$conf.int))
}, "x")

powerfunc <- Vectorize(function(d, a, b){
  x <- ceiling(pwr.t.test(d = d,
                          sig.level = a,
                          power = 1 - b,
                          type = "two.sample",
                          alternative = "two.sided")$n)
  return(x)
}, c("d", "a", "b"))


##---- SETTINGS ----------------------------------------------------------------

#setwd("~/sprt")
li <- list.files(
  path = path,
  pattern="*.RData",
  full.names=TRUE)


##---- COMBINE SINGLE DATA FILES -----------------------------------------------

final <- ldply(li, .fun=function(x) get(load(x)), .id=NULL, .progress = "text")
final <- na.omit(final)

# save final data set
save(final, file=paste0(path, "final_sprt.RData"))


##---- ANALYSIS ----------------------------------------------------------------

# clean data set
final <- final %>%
  select(-batch, -rep)  %>% # remove unnecessary variables
  arrange(d, d_hyp, alpha, beta)

# add new variable: Neyman-Pearson sample size (Nnp)
# nRep denotes the number of replications per parameter combination
final$nnp <- final%>%
  group_by(d, d_hyp, alpha, beta) %>%
  summarise(nRep <<- n()) %>% mutate(nnp=powerfunc(d_hyp, alpha, beta)) %>%
  ungroup() %>% select(nnp) %>% unlist() %>%
  rep(each=nRep)

# add new variable: exceed.nnp
final$exceed.nnp <- final$n > final$nnp


# Results (res) =
# Empirical error rates (and 95% confidence interval) +
# Average sample number (ASN) (and sd) +
# Ratio of ASN to fixed-n sample size (ASN.ratio)
results_sprt <- final %>%
  select(d, d_hyp, alpha, beta, n, error, nnp, exceed.nnp) %>%
  group_by(d, d_hyp, alpha, beta) %>%
  dplyr::summarise(ASN = mean(n), ASN.sd= sd(n),
                   error=mean(error), nnp=mean(nnp),
                   exceed.nnp=mean(exceed.nnp),
                   n.50 = quantile(n, probs = .5),
                   n.75 = quantile(n, probs = .75),
                   n.95 = quantile(n, probs = .95)) %>%
  dplyr::mutate(error.ll = t(conf.int(error, nRep, .05))[,1],
                error.ul = t(conf.int(error, nRep, .05))[,2],
                ASN.ratio = ceiling(ASN)/nnp) %>%
  select(d, d_hyp, alpha, beta, ASN, ASN.sd, n.50, n.75, n.95, nnp, exceed.nnp,
         ASN.ratio, error, error.ll, error.ul)

##---- SAVE RESULTS ------------------------------------------------------------

save(results_sprt, file = paste0(path, "results_sprt.RData"))
write.csv(results_sprt, file = paste0(path, "results_sprt.csv"))

##---- UNDO SET.SEED -----------------------------------------------------------
set.seed(NULL)
