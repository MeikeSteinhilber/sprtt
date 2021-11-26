# simulate data ----------------------------------------------------------------
# Set coefficients
alpha = 10
# beta1 = .3
beta1 = .0
beta2 = -.5
beta3 = -1.1

# Generate 200 trials
A = c(rep(c(0), 100), rep(c(1), 100), rep(c(2), 100)) # '0' 100 times, '1' 100 times
# B = rep(c(rep(c(0), 50), rep(c(1), 50)), 2) # '0'x50, '1'x50, '0'x50, '1'x50
e = rnorm(300, 0, sd = 1) # Random noise, with standard deviation of 1

# Generate your data using the regression equation
# y = alpha + beta1*A + beta2*B + beta3*A*B + e
y = alpha + beta1*A  + e

# Join the variables in a data frame
# data = data.frame(cbind(A, B, y))
data = data.frame(cbind(A, y))

# Check the data with a regression
# lin.model = lm(y ~ A*B, data = data)
# lin.model = lm(y ~ A, data = data)
# summary(lin.model)


# calculate sequential ANOVA ---------------------------------------------------
results <- sprtt::seq_anova(y ~ A, f = 0.2, data = data )
results@decision
