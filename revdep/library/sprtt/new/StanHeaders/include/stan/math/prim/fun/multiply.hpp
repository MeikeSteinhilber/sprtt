#ifndef STAN_MATH_PRIM_FUN_MULTIPLY_HPP
#define STAN_MATH_PRIM_FUN_MULTIPLY_HPP

#include <stan/math/prim/meta.hpp>
#include <stan/math/prim/err.hpp>
#include <stan/math/prim/fun/Eigen.hpp>
#include <stan/math/prim/fun/dot_product.hpp>
#include <type_traits>

namespace stan {
namespace math {

/**
 * Return specified matrix multiplied by specified scalar.
 *
 * @tparam Mat type of the matrix or expression
 * @tparam Scal type of the scalar
 *
 * @param m matrix
 * @param c scalar
 * @return product of matrix and scalar
 */
template <typename Mat, typename Scal, require_stan_scalar_t<Scal>* = nullptr,
          require_eigen_t<Mat>* = nullptr,
          require_all_not_st_var<Scal, Mat>* = nullptr>
inline auto multiply(const Mat& m, Scal c) {
#ifdef USE_STANC3
  return c * m;
#else
  return (c * m).eval();
#endif
}

/**
 * Return specified scalar multiplied by specified matrix.
 *
 * @tparam Scal type of the scalar
 * @tparam Mat type of the matrix or expression
 *
 * @param c scalar
 * @param m matrix
 * @return product of scalar and matrix
 */
template <typename Scal, typename Mat, require_stan_scalar_t<Scal>* = nullptr,
          require_eigen_t<Mat>* = nullptr,
          require_all_not_st_var<Scal, Mat>* = nullptr>
inline auto multiply(Scal c, const Mat& m) {
#ifdef USE_STANC3
  return c * m;
#else
  return (c * m).eval();
#endif
}

/**
 * Return the product of the specified matrices. The number of
 * columns in the first matrix must be the same as the number of rows
 * in the second matrix.
 *
 * @tparam Mat1 type of the first matrix or expression
 * @tparam Mat2 type of the second matrix or expression
 *
 * @param m1 first matrix or expression
 * @param m2 second matrix or expression
 * @return the product of the first and second matrices
 * @throw <code>std::invalid_argument</code> if the number of columns of m1 does
 * not match the number of rows of m2.
 */
template <typename Mat1, typename Mat2,
          require_all_eigen_vt<std::is_arithmetic, Mat1, Mat2>* = nullptr,
          require_not_eigen_row_and_col_t<Mat1, Mat2>* = nullptr>
inline auto multiply(const Mat1& m1, const Mat2& m2) {
  check_size_match("multiply", "Columns of m1", m1.cols(), "Rows of m2",
                   m2.rows());
#ifdef USE_STANC3
  return m1 * m2;
#else
  return (m1 * m2).eval();
#endif
}

/**
 * Return the scalar product of the specified row vector and
 * specified column vector.  The return is the same as the dot
 * product.  The two vectors must be the same size.
 *
 * @tparam RowVec type of the row vector
 * @tparam ColVec type of the column vector
 *
 * @param rv row vector
 * @param v column vector
 * @return scalar result of multiplying row vector by column vector
 * @throw <code>std::invalid_argument</code> if rv and v are not the same size
 */
template <typename RowVec, typename ColVec,
          require_all_not_st_var<RowVec, ColVec>* = nullptr,
          require_eigen_row_and_col_t<RowVec, ColVec>* = nullptr>
inline auto multiply(const RowVec& rv, const ColVec& v) {
  check_multiplicable("multiply", "rv", rv, "v", v);
  return dot_product(rv, v);
}

/**
 * Return product of scalars.
 *
 * @tparam Scalar1 type of first scalar
 * @tparam Scalar2 type of second scalar
 * @param m scalar
 * @param c scalar
 * @return product
 */
template <typename Scalar1, typename Scalar2,
          require_all_stan_scalar_t<Scalar1, Scalar2>* = nullptr>
inline return_type_t<Scalar1, Scalar2> multiply(Scalar1 m, Scalar2 c) {
  return c * m;
}

}  // namespace math
}  // namespace stan

#endif
