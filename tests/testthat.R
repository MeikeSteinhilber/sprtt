library(testthat)
library(sprtt)
Sys.setenv(SPRTT_CONSENT_DOWNLOAD = "true")
test_check("sprtt")
