# An S4 class to represent the results of a sequential anova.

An S4 class to represent the results of a sequential anova.

## Arguments

- plot:

  list with all arguments for the plot_anova() function

## Slots

- `likelihood_ratio_log`:

  the logarithmic test statistic.

- `decision`:

  the test decision: "accept H1", "accept H0", or "continue sampling".

- `A_boundary_log`:

  the lower logarithmic boundary of the test.

- `B_boundary_log`:

  the upper logarithmic boundary of the test.

- `f`:

  a number indicating the specified effect size (Cohen's f).

- `effect_sizes`:

  a list with effect sizes (Cohen's f, eta squared, ...).

- `alpha`:

  the type I error. A number between 0 and 1.

- `power`:

  1 - beta (beta is the type II error probability). A number between 0
  and 1.

- `likelihood_ratio`:

  the likelihood ratio of the test without logarithm.

- `likelihood_1`:

  the likelihood of the alternative Hypothesis (H1).

- `likelihood_0`:

  the likelihood of the null Hypothesis (H0).

- `likelihood_1_log`:

  the logarithmic likelihood of the alternative Hypothesis (H1).

- `likelihood_0_log`:

  the logarithmic likelihood of the null Hypothesis (H0).

- `non_centrality_parameter`:

  parameter to calculate the likelihoods

- `F_value`:

  the F-value of the F-statistic.

- `df_1`:

  degrees of freedom.

- `df_2`:

  degrees of freedom.

- `ss_effect`:

  ss_effect.

- `ss_residual`:

  ss_residual.

- `ss_total`:

  ss_total.

- `total_sample_size`:

  total sample size.

- `data_name`:

  a character string giving the name(s) of the data.

- `verbose`:

  a logical value whether you want a verbose output or not.
