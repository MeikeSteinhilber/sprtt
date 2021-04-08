# set seed --------------------------------------------------------------------
set.seed(333)

# load library ----------------------------------------------------------------
library(sprtt)

# one sample: numeric input ---------------------------------------------------
treatment_group <- rnorm(20, mean = 0, sd = 1)
results <- seq_ttest(treatment_group, mu = 1, d = 0.8)

# get access to the slots -----------------------------------------------------
# @ Operator
results@likelihood_ratio

# [] Operator
results["likelihood_ratio"]

# two sample: numeric input----------------------------------------------------
treatment_group <- stats::rnorm(20, mean = 0, sd = 1)
control_group <- stats::rnorm(20, mean = 1, sd = 1)
seq_ttest(treatment_group, control_group, d = 0.8)

# two sample: formula input ---------------------------------------------------
stress_level <- stats::rnorm(20, mean = 0, sd = 1)
sex <- as.factor(c(rep(1, 10), rep(2, 10)))
seq_ttest(stress_level ~ sex, d = 0.8)

# NA in the data --------------------------------------------------------------
stress_level <- c(NA, stats::rnorm(20, mean = 0, sd = 2), NA)
sex <- as.factor(c(rep(1, 11), rep(2, 11)))
seq_ttest(stress_level ~ sex, d = 0.8, na.rm = TRUE)

# work with dataset (data are in the package included) ------------------------
seq_ttest(monthly_income ~ sex, data = df_income, d = 0.8)
