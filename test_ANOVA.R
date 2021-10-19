# simulate ANOVA data ----------------------------------------------------------
# Set coefficients
alpha = 10
# beta1 = .3
beta1 = .0
beta2 = -.5
beta3 = -1.1

# Generate 200 trials
# A = c(rep(c(0), 100), rep(c(1), 100), rep(c(2), 100)) # '0' 100 times, '1' 100 times
A = c(rep(c(0), 150), rep(c(1), 150)) # '0' 100 times, '1' 100 times
# B = rep(c(rep(c(0), 50), rep(c(1), 50)), 2) # '0'x50, '1'x50, '0'x50, '1'x50
e = rnorm(300, 0, sd = 1) # Random noise, with standard deviation of 1

# Generate your data using the regression equation
# y = alpha + beta1*A + beta2*B + beta3*A*B + e
y = alpha + beta1*A  + e

# Join the variables in a data frame
# data = data.frame(cbind(A, B, y))
data = data.frame(y, A = as.factor(A))

# Check the data with a regression
# lin.model = lm(y ~ A*B, data = data)
# lin.model = lm(y ~ A, data = data)
# summary(lin.model)



# calculate ANOVA --------------------------------------------------------------

# Typ I (bad if groups are unbalanced)
model = stats::aov(y ~ A, data = data)
summary(model)

# Typ II and III (best way?)
car::Anova(lm(y ~ A), data = data)

# calculate group means --------------------------------------------------------
library(dplyr)
data %>%
  group_by(A) %>%
  summarise_at(vars(y), list(mean = mean))


aggregate(data$y, list(data$A), FUN=mean)

# calculate SS residual --------------------------------------------------------
# n_factors <- ncol(seq_anova_arguments@data) - 1 # remove y column
levels_factor_A <- as.numeric(levels(as.factor(seq_anova_arguments@data$factor_A)))
# n_levels_factor_A <- length(levels_factor_A)
level <- 0

ss_function <- function(data, level, group_means_A){
  level_mean <- group_means_A %>% filter(factor_A == level) %>% select(means) %>% as.double()
  y <- data %>% select(y) %>% as.vector()
  sum((y - level_mean)^2)
}

ss_residual <- length(3)
i = 1

for (level in levels_factor_A) {
  seq_anova_arguments@data %>%
    filter(seq_anova_arguments@data$factor_A == level) %>%
    select(y)  %>%
    summarise(sum_y = ss_function) -> test
  ss_residual[i] < test
  i = i + 1
}


# test shit --------------------------------------------------------------------
formula = y ~ A
seq_anova_arguments = build_seq_anova_arguments(formula, data, 0.1, 0.05, 0.95, "test name", TRUE)
seq_anova_arguments

extract_formula_seq_anova(formula, data)

seq_anova_arguments = build_prototype_seq_anova_arguments()

seq_anova_arguments@data <- calc_group_means(seq_anova_arguments)
# level <- 0# seq_anova_arguments@data %>%
#   filter(seq_anova_arguments@data$factor_A == level)  -> data
#

#
# ss_function(data, level, group_means_A)



calc_ss_residual(seq_anova_arguments, group_means_A)
calc_ss_effect(seq_anova_arguments, group_means_A)



# calc sequential ANOVA --------------------------------------------------------
system.time(sprtt::seq_anova(y ~ A, f = 0.3, data = data))

system.time(sprtt::seq_ttest(y ~ A, d = 0.3, data = data))

profvis::profvis({
  sprtt::seq_anova(y ~ A, f = 0.1, data = data)
})


system.time(stats::aov(y ~ A, data = data))
profvis({
  stats::aov(y ~ A, data = data)
})



a@decision
a@likelihood_ratio

















