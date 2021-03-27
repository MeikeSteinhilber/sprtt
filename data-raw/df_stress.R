library(stats)

# settings
# set.seed(4653284)
n <- 30

# generate data
treatment_group <- rnorm(n, mean = 5, sd = 1)
control_group <- rnorm(n, mean = 4, sd = 1)
#
baseline_stress <- rnorm(n, mean = 5, sd = 1)
one_year_stress <- baseline_stress + rnorm(n, mean = 0, sd = 0.5)


# build data.frame
df_stress <- data.frame(
  treatment_group = treatment_group,
  control_group = control_group,
  baseline_stress = baseline_stress,
  one_year_stress = one_year_stress
)

# save data frame
# write.csv(df_stress, "data-raw/df_stress.csv")
usethis::use_data(df_stress, overwrite = TRUE, compress = 'xz')
