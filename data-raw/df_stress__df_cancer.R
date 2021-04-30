library(stats)

# settings
set.seed(4653284)
n <- 120

# generate data
treatment_group <- rnorm(n, mean = 5, sd = 1)
control_group <- rnorm(n, mean = 4, sd = 1)
#
baseline_stress <- rnorm(n, mean = 5, sd = 1)
one_year_stress <- baseline_stress + rnorm(n, mean = 0.3, sd = 1)


# build data.frame
df_cancer <- data.frame(
  treatment_group = treatment_group,
  control_group = control_group
)
df_stress <- data.frame(
  baseline_stress = baseline_stress,
  one_year_stress = one_year_stress
)

# save data frame
# write.csv(df_stress, "data-raw/df_stress.csv")
usethis::use_data(df_stress, overwrite = TRUE, compress = 'xz')
usethis::use_data(df_cancer, overwrite = TRUE, compress = 'xz')
