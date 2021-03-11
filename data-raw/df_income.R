library(stats)

# settings
# set.seed(4653284)
n <- 30

# generate data
sex <- as.factor(c(rep(c(1,2 ), n/2)))
age <- rnorm(n, mean = 45, sd = 10)
in_debt <- as.factor(sample(0:1, size = n, replace = TRUE))
monthly_income <- sample(700:6000, size = n, replace = FALSE)
whith_children <- as.factor(sample(0:1, size = n, replace = TRUE))

# build data.frame
df_income <- data.frame(
  sex = sex,
  age = age,
  in_debt = in_debt,
  monthly_income = monthly_income,
  whith_children = whith_children
)

# save data frame
write.csv(df_income, "data-raw/df_income.csv")
usethis::use_data(df_income, overwrite = TRUE, compress = 'xz')
