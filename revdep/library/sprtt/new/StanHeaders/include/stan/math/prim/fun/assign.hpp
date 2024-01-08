#ifndef STAN_MATH_PRIM_FUN_ASSIGN_HPP
#define STAN_MATH_PRIM_FUN_ASSIGN_HPP

#include <stan/math/prim/err.hpp>
#include <stan/math/prim/fun/Eigen.hpp>
#include <iostream>
#include <sstream>
#include <stdexcept>
#include <string>
#include <vector>

namespace stan {
namespace math {

/**
 * Helper function to return the matrix size as either "dynamic" or "1".
 *
 * @tparam N Eigen matrix size specification
 * @param o output stream
 */
template <int N>
inline void print_mat_size(std::ostream& o) {
  if (N == Eigen::Dynamic) {
    o << "dynamically sized";
  } else {
    o << N;
  }
}

/**
 * Copy the right-hand side's value to the left-hand side
 * variable.
 *
 * The <code>assign()</code> function is overloaded.  This
 * instance will match arguments where the right-hand side is
 * assignable to the left and they are not both
 * <code>std::vector</code> or <code>Eigen::Matrix</code> types.
 *
 * @tparam T_lhs Type of left-hand side.
 * @tparam T_rhs Type of right-hand side.
 * @param x Left-hand side.
 * @param y Right-hand side.
 */
#ifdef USE_STANC3
template <typename T_lhs, typename T_rhs,
          require_all_stan_scalar_t<T_lhs, T_rhs>* = nullptr>
#else
template <typename T_lhs, typename T_rhs>
#endif
inline void assign(T_lhs& x, const T_rhs& y) {
  x = y;
}

/**
 * Copy the right-hand side's value to the left-hand side
 * variable.
 *
 * The <code>assign()</code> function is overloaded.  This
 * instance will be called for arguments that are both
 * <code>Eigen::Matrix</code> types.
 *
 * @tparam T_lhs type of the left-hand side matrix
 * @tparam T_rhs type of the right-hand side matrix
 *
 * @param x Left-hand side matrix.
 * @param y Right-hand side matrix.
 * @throw std::invalid_argument if sizes do not match.
 */
#ifdef USE_STANC3
template <typename T_lhs, typename T_rhs,
          require_all_eigen_t<T_lhs, T_rhs>* = nullptr>
inline void assign(T_lhs&& x, const T_rhs& y) {
  check_matching_dims("assign", "left-hand-side", x, "right-hand-side", y);
  x = y.template cast<value_type_t<T_lhs>>();
}
#else
template <typename T_lhs, typename T_rhs, int R, int C>
inline void assign(Eigen::Matrix<T_lhs, R, C>& x,
                   const Eigen::Matrix<T_rhs, R, C>& y) {
  check_matching_dims("assign", "left-hand-side", x, "right-hand-side", y);
  for (int i = 0; i < x.size(); ++i) {
    assign(x(i), y(i));
  }
}

/**
 * Copy the right-hand side's value to the left-hand side
 * variable.
 *
 * <p>The <code>assign()</code> function is overloaded.  This
 * instance will be called for arguments that are both
 * <code>Eigen::Matrix</code> types and whose shapes match.  The
 * shape of the right-hand side matrix is specified in the row and
 * column shape template parameters.
 *
 * <p>The left-hand side is intentionally not a reference, because
 * that won't match generally enough;  instead, a non-reference is
 * used, which still holds onto a reference to the contained
 * matrix and thus still updates the appropriate values.
 *
 * @tparam T_lhs Type of matrix block elements.
 * @tparam T Type of right-hand side matrix elements.
 * @tparam R Row shape for right-hand side matrix.
 * @tparam C Column shape for right-hand side matrix.
 * @param x Left-hand side block view of matrix.
 * @param y Right-hand side matrix.
 * @throw std::invalid_argument if sizes do not match.
 */
template <typename T_lhs, typename T, int R, int C>
inline void assign(Eigen::Block<T_lhs> x, const Eigen::Matrix<T, R, C>& y) {
  check_size_match("assign", "left-hand side rows", x.rows(),
                   "right-hand side rows", y.rows());
  check_size_match("assign", "left-hand side cols", x.cols(),
                   "right-hand side cols", y.cols());
  for (int n = 0; n < y.cols(); ++n) {
    for (int m = 0; m < y.rows(); ++m) {
      assign(x(m, n), y(m, n));
    }
  }
}
#endif

/**
 * Copy the right-hand side's value to the left-hand side
 * variable.
 *
 * The <code>assign()</code> function is overloaded.  This
 * instance will be called for arguments that are both
 * <code>std::vector</code>, and will call <code>assign()</code>
 * element-by element.
 *
 * For example, a <code>std::vector&lt;int&gt;</code> can be
 * assigned to a <code>std::vector&lt;double&gt;</code> using this
 * function.
 *
 * @tparam T_lhs type of elements in the left-hand side vector
 * @tparam T_rhs type of elements in the right-hand side vector
 * @param x Left-hand side vector.
 * @param y Right-hand side vector.
 * @throw std::invalid_argument if sizes do not match.
 */
template <typename T_lhs, typename T_rhs>
inline void assign(std::vector<T_lhs>& x, const std::vector<T_rhs>& y) {
  check_matching_sizes("assign", "left-hand side", x, "right-hand side", y);
  for (size_t i = 0; i < x.size(); ++i) {
    assign(x[i], y[i]);
  }
}

}  // namespace math
}  // namespace stan

#endif
