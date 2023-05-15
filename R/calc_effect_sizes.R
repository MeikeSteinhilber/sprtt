# seq_anova_arguments <- build_prototype_seq_anova_arguments(seed = 56, max_n = 1000, f = 0.40)
# seq_anova_arguments <- build_prototype_seq_anova_arguments(seed = 31, max_n = 90, f = 0)

calc_effect_sizes <- function(seq_anova_arguments, ss_effect, ss_total, F_statistic, decision = "NULL") {
  k_group <- length(unique(seq_anova_arguments@data$factor_A))

  eta_squared <- ss_effect/ss_total
  partial_eta_squared <- (F_statistic$F_value * F_statistic$df_1) / (F_statistic$F_value * F_statistic$df_1 + F_statistic$df_2)
  adjusted_eta_squared = partial_eta_squared - (1 - partial_eta_squared) * F_statistic$df_1 / F_statistic$df_2

  if (eta_squared < 0) {
    cohens_f <- 0
  } else{
    cohens_f <- sqrt(eta_squared/(1-eta_squared))
  }

  # # adjusted f using Correction: Grissom Effect Size for Research 2005
  # cohens_f_unbiased <- ((k_group-1)/seq_anova_arguments@total_sample_size)*(F_statistic$F_value-1)
  # if (cohens_f_unbiased < 0) {
  #   cohens_f_unbiased <- 0
  # }else{
  #   cohens_f_unbiased <- sqrt(cohens_f_unbiased)
  # }

  # adjusted f using Correction: Maxwell et al. 2017
  F_adust <- (seq_anova_arguments@total_sample_size - k_group - 2) / (seq_anova_arguments@total_sample_size - k_group)
  cohens_f_adj <- ((k_group-1)/seq_anova_arguments@total_sample_size)*(F_adust * F_statistic$F_value-1)
  if (cohens_f_adj < 0) {
    cohens_f_adj <- 0
  }else{
    cohens_f_adj <- sqrt(cohens_f_adj)
  }

  cohens_f_median <- MBESS::ci.srsnr(F.value = F_statistic$F_value,
                                     df.1 = F_statistic$df_1,
                                     df.2 = F_statistic$df_2,
                                     N = seq_anova_arguments@total_sample_size,
                                     alpha.lower = 0.5,
                                     alpha.upper = 0
                                     )$Lower
  # fix NA in MBESS only if Maxwell unbiased estimator is 0
  if (is.na(cohens_f_median) & cohens_f_adj == 0) {
    cohens_f_median <- 0
  }



  # # calculate Cohen's f manually
  #
  # n_group <- seq_anova_arguments@data %>%
  #   group_by(factor_A) %>%
  #   mutate(n_group = length(factor_A)) %>%
  #   group_by(n_group, factor_A) %>%
  #   summarise(.groups = "drop") %>%
  #   pull(n_group)
  # sd_group <- seq_anova_arguments@data %>%
  #   group_by(factor_A) %>%
  #   mutate(sd_group = sd(y)) %>%
  #   group_by(sd_group, factor_A) %>%
  #   summarise(.groups = "drop") %>%
  #   pull(sd_group)
  # mean_group <- seq_anova_arguments@data %>%
  #   group_by(factor_A, group_mean_A) %>%
  #   summarise(.groups = "drop") %>%
  #   pull(group_mean_A)
  # pooled_sd_group <- sqrt(
  #   sum(sd_group^2*(n_group - 1)) /
  #     (sum(n_group) - k_group)
  # )
  # sd_means <- sqrt(sum((mean_group - mean(mean_group))^2)/k_group)
  # cohens_f_manual <- sd_means/pooled_sd_group

  # Confidence Interval for the Non Centrality Parameter
  # Using a non central F distribution
  ci_non_centrality_parameter <- MBESS::conf.limits.ncf(
    F_statistic$F_value,
    conf.level = 0.95,
    F_statistic$df_1,
    F_statistic$df_2
  )
  ci_ncp_lower <- ci_non_centrality_parameter$Lower.Limit
  ci_ncp_upper <- ci_non_centrality_parameter$Upper.Limit

  # MBESS Package returns NA if the CIs are 0 -> transform them to 0
  if (is.na(ci_ncp_lower) & decision == "accept H0") {ci_ncp_lower = 0}
  if (is.na(ci_ncp_upper) &
     cohens_f < 0.005 &
     decision == "accept H0" &
     ci_ncp_lower == 0
  ) {
    ci_ncp_upper = 0
  }

  ci_cohens_f_lower <- sqrt(ci_ncp_lower/seq_anova_arguments@total_sample_size)
  ci_cohens_f_upper <- sqrt(ci_ncp_upper/seq_anova_arguments@total_sample_size)


  effect_sizes = list(
    "cohens_f" = cohens_f,
    "cohens_f_median" = cohens_f_median,
    # "cohens_f_manual" = cohens_f_manual,
    "cohens_f_adj" = cohens_f_adj,
    # "cohens_f_unbiased" = cohens_f_unbiased, # Grissom 2005
    "ci_cohens_f_lower" = ci_cohens_f_lower,
    "ci_cohens_f_upper" = ci_cohens_f_upper,
    "eta_squared" = eta_squared,
    "partial_eta_squared" = partial_eta_squared,
    "adjusted_eta_squared" = adjusted_eta_squared,
    "ci_ncp_lower" = ci_ncp_lower,
    "ci_ncp_upper" = ci_ncp_upper
  )
  effect_sizes
}


#' Calculate effect sizes.
#'
#' @param formula formula
#' @param data data set
#'
#' @return MISSING DESCRIPTION
#' @export
#'
#' @examples "no examples yet"
effect_sizes <- function(formula, data) {
  seq_anova_arguments <-
    build_seq_anova_arguments(
      formula,
      data,
      f = 0.5,
      alpha = 0.1,
      power = 0.1,
      data_name = "test_name",
      verbose = FALSE
    )
  seq_anova_arguments@data <-
    calc_group_means(
      seq_anova_arguments
    )
  ss_effect <-
    calc_ss_effect(
      seq_anova_arguments
    )
  ss_residual <-
    calc_ss_residual(
      seq_anova_arguments
    )
  ss_total <-
    calc_ss_total(
      seq_anova_arguments
    )
  F_statistic <-
    calc_F_statistic_(
      seq_anova_arguments,
      ss_effect,
      ss_residual
    )

  calc_effect_sizes(
    seq_anova_arguments,
    ss_effect,
    ss_total,
    F_statistic)

}
# data = draw_sample(k_groups = 3, f = 0.25, sd = c(1, 1, 1), max_n = 50)
# formula = y~x
# effect_sizes(formula, data)
# effectsize::cohens_f(lm(formula, data))$Cohens_f


# m <- lm(formula, data)
# parameters::model_parameters(anova(m))
