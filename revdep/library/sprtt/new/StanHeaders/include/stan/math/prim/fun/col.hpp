#ifndef STAN_MATH_PRIM_FUN_COL_HPP
#define STAN_MATH_PRIM_FUN_COL_HPP

#include <stan/math/prim/err.hpp>
#include <stan/math/prim/fun/Eigen.hpp>

namespace stan {
namespace math {

/**
 * Return the specified column of the specified matrix
 * using start-at-1 indexing.
 *
 * This is equivalent to calling <code>m.col(i - 1)</code> and
 * assigning the resulting template expression to a column vector.
 *
 * @tparam T type of the matrix
 * @param m Matrix.
 * @param j Column index (count from 1).
 * @return Specified column of the matrix.
 * @throw std::out_of_range if j is out of range.
 */
template <typename T, typename = require_eigen_t<T>>
inline auto col(const T& m, size_t j) {
  check_column_index("col", "j", m, j);
#ifdef USE_STANC3
  return m.col(j - 1);
#else
  return m.col(j - 1).eval();
#endif
}

}  // namespace math
}  // namespace stan

#endif
