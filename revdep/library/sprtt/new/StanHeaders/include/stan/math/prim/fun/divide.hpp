#ifndef STAN_MATH_PRIM_FUN_DIVIDE_HPP
#define STAN_MATH_PRIM_FUN_DIVIDE_HPP

#include <stan/math/prim/meta.hpp>
#include <stan/math/prim/err.hpp>
#include <stan/math/prim/fun/Eigen.hpp>
#include <cstddef>
#include <cstdlib>
#include <type_traits>

namespace stan {
namespace math {

/**
 * Return the division of the first scalar by
 * the second scalar.
 * @param[in] x Specified scalar.
 * @param[in] y Specified scalar.
 * @return Scalar divided by the scalar.
 */
template <typename Scal1, typename Scal2,
#ifdef USE_STANC3
          require_all_stan_scalar_t<Scal1, Scal2>* = nullptr>
#else
          typename = require_all_stan_scalar_t<Scal1, Scal2> >
#endif
inline return_type_t<Scal1, Scal2> divide(const Scal1& x, const Scal2& y) {
  return x / y;
}

inline int divide(int x, int y) {
  if (unlikely(y == 0)) {
    throw_domain_error("divide", "denominator is", y, "");
  }
  return x / y;
}

/**
 * Return matrix divided by scalar.
 *
 * @tparam Mat type of the matrix or expression
 * @tparam Scal type of the scalar
 * @param[in] m specified matrix or expression
 * @param[in] c specified scalar
 * @return matrix divided by the scalar
 */
template <typename Mat, typename Scal, typename = require_eigen_t<Mat>,
#ifdef USE_STANC3
          require_stan_scalar_t<Scal>* = nullptr,
          require_all_not_var_t<scalar_type_t<Mat>, Scal>* = nullptr>
#else
          typename = require_stan_scalar_t<Scal>,
          typename = require_all_not_var_t<scalar_type_t<Mat>, Scal> >
#endif
inline auto divide(const Mat& m, Scal c) {
#ifdef USE_STANC3
  return m / c;
#else
  return (m / c).eval();
#endif
}

}  // namespace math
}  // namespace stan

#endif
