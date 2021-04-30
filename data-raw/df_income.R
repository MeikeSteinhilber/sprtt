library(stats)

# set.seed(4653284)
n <- 120

# generate data
sex <- as.factor(c(rep(c("female","male" ), n/2)))
monthly_income <- rnorm(n, mean = 3000, sd = 500)

# build data.frame
df_income <- data.frame(
  monthly_income = monthly_income,
  sex = sex
)

# save data frame
# write.csv(df_income, "data-raw/df_income.csv")
usethis::use_data(df_income, overwrite = TRUE, compress = 'xz')
