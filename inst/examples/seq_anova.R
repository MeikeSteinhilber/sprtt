# simulate data ----------------------------------------------------------------
set.seed(333)
data <- sprtt::draw_sample_normal(k_groups = 3,
                    f = 0.25,
                    sd = c(1, 1, 1),
                    max_n = 50)


# calculate sequential ANOVA ---------------------------------------------------
results <- sprtt::seq_anova(y ~ x, f = 0.25, data = data)
# test decision
results@decision
# test results
results

# calculate sequential ANOVA ---------------------------------------------------
results <- sprtt::seq_anova(y ~ x,
                            f = 0.25,
                            data = data,
                            alpha = 0.01,
                            power = .80,
                            verbose = TRUE)
results

# calculate sequential ANOVA ---------------------------------------------------
results <- sprtt::seq_anova(y ~ x,
                            f = 0.15,
                            data = data,
                            alpha = 0.05,
                            power = .80,
                            verbose = FALSE)
results
