# setGeneric("build_input_arguments",
#            function(input1, ...)
#              standardGeneric("build_input_arguments"))
#
# setMethod("build_input_arguments",
#           signature(input1 = "numeric"),
#           function(input1,
#                    y,
#                    mu,
#                    d,
#                    alpha,
#                    power,
#                    alternative,
#                    paired,
#                    ...) {
#             input_arguments <- new(
#               "input_arguments",
#               x = delete_na(x = input1, y, wanted = "x"),
#               y = delete_na(x = input1, y, wanted = "y"),
#               mu = mu,
#               d = d,
#               alpha = alpha,
#               power = power,
#               alternative = alternative,
#               paired = paired,
#               one_sample = get_one_sample(y, alternative),
#               one_sided = get_one_sided(alternative)
#             )
#             input_arguments
#           })
#
#
# setMethod("build_input_arguments",
#           signature(input1 = "formula"),
#           function(input1,
#                    data,
#                    mu,
#                    d,
#                    alpha,
#                    power,
#                    alternative,
#                    paired,
#                    ...) {
#             x = extract_formula(formula = input1, data = data, paired = paired, wanted = "x")
#             y = extract_formula(formula = input1, data = data, paired = paired, wanted = "y")
#
#             input_arguments <- new(
#               "input_arguments",
#               x = delete_na(x, y, wanted = "x"),
#               y = delete_na(x, y, wanted = "y"),
#               mu = mu,
#               d = d,
#               alpha = alpha,
#               power = power,
#               alternative = alternative,
#               paired = paired,
#               one_sample = get_one_sample(y, alternative),
#               one_sided = get_one_sided(alternative)
#             )
#             input_arguments
#
#           })
