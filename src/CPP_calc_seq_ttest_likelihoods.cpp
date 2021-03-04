#include <Rcpp.h>
#include <boost/math/distributions/non_central_f.hpp>

using namespace Rcpp;


// [[Rcpp::export]]
int test(int a, int b) {
  return a + b;
}

// [[Rcpp::export]]
long double dnf_cpp(double x, double df1, double df2, double ncp, bool log = false) {
  return R::dnf(x, df1, df2, ncp, log);
}

// [[Rcpp::export]]
long double dnt_cpp(double x, double df, double ncp, bool log = false) {
  return R::dnt(x, df, ncp, log);
}


/*** R
# CPP
f <- dnf_cpp(2.3,2,40,2.0)
print(f, digits = 21)
t <- dnt_cpp(2.3,2,40,2.0)
print(t, digits = 21)

# R
f <- df(2.3,2,40,2.0)
print(f, digits = 21)
t <- dt(2.3,2,40,2.0)
print(t, digits = 21)

# R with Rmpfr
library(Rmpfr)
f_50 <- mpfr(df(2.3,2,40,2.0), 50)

# PRINT
# print(test(6,6))
# print(f_50*5, digits = 50)
# print(f, digits = 21)

*/
