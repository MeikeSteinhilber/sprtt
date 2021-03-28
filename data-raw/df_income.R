library(stats)

# settings
# set.seed(4653284)
n <- 30

# generate data
sex <- as.factor(c(rep(c("female","male" ), n/2)))
age <- rnorm(n, mean = 45, sd = 10)
in_debt <- as.factor(sample(0:1, size = n, replace = TRUE))
monthly_income <- rnorm(n, mean = 3000, sd = 500)
whith_children <- as.factor(sample(0:1, size = n, replace = TRUE))

# build data.frame
df_income <- data.frame(
  monthly_income = monthly_income,
  # in_debt = in_debt,
  sex = sex
  # age = age
)

# save data frame
# write.csv(df_income, "data-raw/df_income.csv")
usethis::use_data(df_income, overwrite = TRUE, compress = 'xz')
