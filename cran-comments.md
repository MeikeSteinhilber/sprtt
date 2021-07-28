## Test environments
* local R installation (on windows), R 4.1.0
* ubuntu-16.04 (on GitHub Actions), R 4.0.0
* ubuntu-20.04 (on GitHub Actions)
* macOS-latest (on GitHub Actions)
* windows-latest (on GitHub Actions)
* R-hub
- Windows Server 2008 R2 SP1, R-devel, 32/64 bit
- Ubuntu Linux 20.04.1 LTS, R-release, GCC
- Fedora Linux, R-devel, clang, gfortran
* win builder using R version 4.1.0 (2021-05-18), using platform: x86_64-w64-mingw32 (64-bit)

## R CMD check results
> On windows-x86_64-devel (r-devel), ubuntu-gcc-release (r-release), fedora-clang-devel (r-devel)
  checking CRAN incoming feasibility ... NOTE
  Maintainer: 'Meike Steinhilber 
  
New submission

Version contains large components (0.1.0.9000)

Possibly mis-spelled words in DESCRIPTION:
  Erdfelder (31:34)
  Hajnal (25:5)
  Rushton (24:49)
  SPRT (22:54, 25:33, 31:5)
  Schnuerch (31:22)

Found the following (possibly) invalid URLs:
  URL: 
    From: README.md
    Message: Empty URL
  URL: https://doi.org/10.1214/aoms/1177731118
    From: inst/doc/sequential_testing.html
    Status: 500
    Message: Internal Server Error
  URL: https://doi.org/10.2307/2332385
    From: inst/doc/sequential_testing.html
    Status: 403
    Message: Forbidden
  URL: https://doi.org/10.2307/2333131
    From: inst/doc/sequential_testing.html
    Status: 403
    Message: Forbidden
  URL: https://doi.org/10.2307/2334026
    From: inst/doc/sequential_testing.html
    Status: 403
    Message: Forbidden

0 errors √ | 0 warnings √ | 1 note x
