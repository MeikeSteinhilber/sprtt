# simulate data ----------------------------------------------------------------
set.seed(333)
data <- sprtt::draw_sample(k_groups = 3,
                    f = 0.25,
                    sd = c(1, 1, 1),
                    max_n = 50)


# calculate sequential ANOVA ---------------------------------------------------
results <- sprtt::seq_anova(y ~ x, f = 0.25, data = data )
# test decision
results@decision
# test results
results
