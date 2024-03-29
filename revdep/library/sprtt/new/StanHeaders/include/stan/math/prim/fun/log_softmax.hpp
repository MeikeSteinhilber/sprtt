#ifndef STAN_MATH_PRIM_FUN_LOG_SOFTMAX_HPP
#define STAN_MATH_PRIM_FUN_LOG_SOFTMAX_HPP

#include <stan/math/prim/meta.hpp>
#include <stan/math/prim/err.hpp>
#include <stan/math/prim/fun/Eigen.hpp>
#include <stan/math/prim/fun/log_sum_exp.hpp>
#ifdef USE_STANC3
#include <stan/math/prim/fun/to_ref.hpp>
#endif
#include <stan/math/prim/functor/apply_vector_unary.hpp>

namespace stan {
namespace math {

/**
 * Return the natural logarithm of the softmax of the specified
 * vector.
 *
 * \f$
 * \log \mbox{softmax}(y)
 * \ = \ y - \log \sum_{k=1}^K \exp(y_k)
 * \ = \ y - \mbox{log\_sum\_exp}(y).
 * \f$
 *
 * For the log softmax function, the entries in the Jacobian are
 * \f$
 * \frac{\partial}{\partial y_m} \mbox{softmax}(y)[k]
 * = \left\{
 * \begin{array}{ll}
 * 1 - \mbox{softmax}(y)[m]
 * & \mbox{ if } m = k, \mbox{ and}
 * \\[6pt]
 * \mbox{softmax}(y)[m]
 * & \mbox{ if } m \neq k.
 * \end{array}
 * \right.
 * \f$
 *
 * @tparam Container type of input vector to transform
 * @param[in] x vector to transform
 * @return log unit simplex result of the softmax transform of the vector.
 */
#ifdef USE_STANC3
template <typename Container, require_st_arithmetic<Container>* = nullptr>
inline auto log_softmax(const Container& x) {
  check_nonzero_size("log_softmax", "v", x);
  return make_holder(
      [](const auto& a) {
        return apply_vector_unary<ref_type_t<Container>>::apply(
            a, [](const auto& v) { return v.array() - log_sum_exp(v); });
      },
      to_ref(x));
}
#else
/**
 * Note: The return must be evaluated otherwise the Ref object falls out
 * of scope
 */
template <typename Container, require_st_arithmetic<Container>* = nullptr>
inline auto log_softmax(const Container& x) {
  check_nonzero_size("log_softmax", "v", x);
  return apply_vector_unary<Container>::apply(x, [](const auto& v) {
    const Eigen::Ref<const plain_type_t<decltype(v)>>& v_ref = v;
    check_nonzero_size("log_softmax", "v", v_ref);
    return (v_ref.array() - log_sum_exp(v_ref)).eval();
  });
}
#endif
}  // namespace math
}  // namespace stan
#endif
