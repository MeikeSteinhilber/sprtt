# An S4 class to represent the results of a sequential t-test.

An S4 class to represent the results of a sequential t-test.

## Slots

- `likelihood_ratio_log`:

  the logarithmic test statistic.

- `decision`:

  the test decision: "accept H1", "accept H0", or "continue sampling".

- `A_boundary_log`:

  the lower logarithmic boundary of the test.

- `B_boundary_log`:

  the upper logarithmic boundary of the test.

- `d`:

  a number indicating the specified effect size (Cohen's d).

- `mu`:

  a number indicating the true value of the mean (or difference in means
  if you are performing a two sample test).

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

- `t_value`:

  the t-value of the t-statistic.

- `p_value`:

  the p-value of the t-test.

- `df`:

  degrees of freedom.

- `mean_estimate`:

  the estimated mean or difference in means depending on whether it was
  a one-sample test or a two-sample test.

- `alternative`:

  a character string specifying the alternative hypothesis: "two.sided"
  (default), "greater" or "less".

- `one_sample`:

  "true" if it is a one-sample test, "false" if it is a two-sample test.

- `ttest_method`:

  a character string indicating what type of t-test was performed.

- `data_name`:

  a character string giving the name(s) of the data.

- `verbose`:

  a logical value whether you want a verbose output or not.
