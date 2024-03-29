#ifndef STAN_MATH_PRIM_FUN_ROW_HPP
#define STAN_MATH_PRIM_FUN_ROW_HPP

#include <stan/math/prim/err.hpp>
#include <stan/math/prim/fun/Eigen.hpp>

namespace stan {
namespace math {

/**
 * Return the specified row of the specified matrix, using
 * start-at-1 indexing.
 *
 * This is equivalent to calling <code>m.row(i - 1)</code> and
 * assigning the resulting template expression to a row vector.
 *
 * @tparam T type of the matrix
 * @param m Matrix.
 * @param i Row index (count from 1).
 * @return Specified row of the matrix.
 * @throw std::out_of_range if i is out of range.
 */
#ifdef USE_STANC3
template <typename T, require_eigen_t<T>* = nullptr>
#else
template <typename T, typename = require_eigen_t<T> >
#endif
inline auto row(const T& m, size_t i) {
  check_row_index("row", "i", m, i);

#ifdef USE_STANC3
  return m.row(i - 1);
#else
  return m.row(i - 1).eval();
#endif
}

}  // namespace math
}  // namespace stan

#endif
