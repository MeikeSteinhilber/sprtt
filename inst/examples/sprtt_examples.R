# set seed --------------------------------------------------------------------
set.seed(333)

# load library ----------------------------------------------------------------
library(sprtt)

# t-TEST ----------------------------------------------------------------------
# one sample: numeric input ---------------------------------------------------
treatment_group <- rnorm(20, mean = 0, sd = 1)
results <- seq_ttest(treatment_group, mu = 1, d = 0.8)

# get access to the slots -----------------------------------------------------
# @ Operator
results@likelihood_ratio

# [] Operator
results["likelihood_ratio"]

# ANOVA -----------------------------------------------------------------------
# simulate data ---------------------------------------------------------------
set.seed(333)
data <- sprtt::draw_sample_normal(k_groups = 3,
                                  f = 0.25,
                                  sd = c(1, 1, 1),
                                  max_n = 25)

# calculate sequential ANOVA --------------------------------------------------
results <- sprtt::seq_anova(y ~ x, f = 0.25, data = data, plot = TRUE)
# test decision
results@decision
# test results
results

# plot results -----------------------------------------------------------------
sprtt::plot_anova(results)
