#ifndef STAN_MATH_PRIM_FUN_DIAGONAL_HPP
#define STAN_MATH_PRIM_FUN_DIAGONAL_HPP

#include <stan/math/prim/fun/Eigen.hpp>
#include <stan/math/prim/meta.hpp>

namespace stan {
namespace math {

/**
 * Return a column vector of the diagonal elements of the
 * specified matrix.  The matrix is not required to be square.
 *
 * @tparam T type of the matrix
 * @param m Specified matrix.
 * @return Diagonal of the matrix.
 */
template <typename T, typename = require_eigen_t<T>>
inline auto diagonal(const T& m) {
#ifdef USE_STANC3
  return m.diagonal();
#else
  return m.diagonal().eval();
#endif
}

}  // namespace math
}  // namespace stan

#endif
