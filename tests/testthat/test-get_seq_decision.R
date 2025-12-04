# * @testing get_seq_decision
test_that("get_seq_decision", {
  likelihood_ratio <- 4
  A <- 17
  B <- 1
  A_log <- log(A)
  B_log <- log(B)
  boundaries <- list(A = A,
                    B = B,
                    A_log = A_log,
                    B_log = B_log
                    )
  decision <- get_seq_decision(likelihood_ratio, boundaries)
  expect_equal(decision, "continue sampling")

  likelihood_ratio <- 17
  decision <- get_seq_decision(likelihood_ratio, boundaries)
  expect_equal(decision, "accept H1")


  likelihood_ratio <- 1
  decision <- get_seq_decision(likelihood_ratio, boundaries)
  expect_equal(decision, "accept H0")


})

