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
* win builder
- using R version 4.1.0 (2021-05-18), using platform: x86_64-w64-mingw32 (64-bit)
- using R Under development (unstable) (2021-07-25 r80663), using platform: x86_64-w64-mingw32 (64-bit)


## R CMD check results
New submission
==> This is my first submission

Possibly mis-spelled words in DESCRIPTION:
  Erdfelder (31:34)
  Hajnal (25:5)
  Rushton (24:49)
  SPRT (22:54, 25:33, 31:5)
  Schnuerch (31:22)
==> spelling is correct

Found the following (possibly) invalid DOIs:
  DOI: 10.2307/2332385
    From: DESCRIPTION
    Status: Forbidden
    Message: 403
  DOI: 10.2307/2333131
    From: DESCRIPTION
    Status: Forbidden
    Message: 403
  DOI: 10.2307/2334026
    From: DESCRIPTION
    Status: Forbidden
    Message: 403

==> DOIs are correct!

0 errors √ | 0 warnings √ | 1 note x

## last CRAN feedback
Please add () behind all function names in the description texts (DESCRIPTION file). e.g: 'seq_ttest' --> seq_ttest()
==> DONE

Please write references in the description of the DESCRIPTION file in the form authors (year) <doi:...> 
==> DONE

Please add \value to .Rd files regarding exported methods and explain the functions results in the documentation. 
==> DONE
