#
# setGeneric("test_function",
#            function(object, ..., verbose = FALSE) standardGeneric("test_function"),
#            signature = "object"
# )
#
#
# setMethod("test_function",
#           signature = "seq_ttest_arguments",
#           function(object, data_, verbose) {
#             print(object@paired)
#             print(data_)
#             print(verbose)
# })
# setMethod("test_function",
#           signature = "seq_anova_arguments",
#           function(object, verbose) {
#             print(object@f)
#             print(verbose)
#
# })
#
# seq_ttest_arguments <- build_prototype_seq_ttest_arguments()
# seq_anova_arguments <- build_prototype_seq_anova_arguments()
#
# data <- rnorm(10)
# test_function(seq_ttest_arguments, data, )
# test_function(seq_anova_arguments, verbose = "TRUES")
#

# Test messwiederholte ANOVA Daten -----------------------------------------------

# tdef <- defData(varname = "T", dist = "binary", formula = 0.5)
# tdef <- defData(tdef, varname = "Y0", dist = "normal", formula = 10, variance = 1)
# tdef <- defData(tdef, varname = "Y1", dist = "normal", formula = "Y0 + 5 + 5 * T", variance = 1)
# # tdef <- defData(tdef, varname = "Y2", dist = "normal", formula = "Y0 + 10 + 5 * T", variance = 1)
# dtTrial <- genData(5, tdef)
# dtTrial
# dtTime <- addPeriods(dtTrial,
#                      nPeriods = 2, idvars = "id",
#                      timevars = c("Y0", "Y1"), timevarName = "Y"
# )
# dtTime$period <- as.factor(dtTime$period)
#
# results <- sprtt::seq_ttest(Y~period, data = dtTime, d = 0.2, paired = TRUE)
# results
