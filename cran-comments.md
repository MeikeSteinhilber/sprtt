## Test environments
* local R installation, R 4.0.3
* ubuntu 16.04 (on travis-ci), R 4.0.3
* win-builder (devel)

## R CMD check results
> On windows-x86_64-devel (r-devel)
  checking tests ...
    Running 'testthat.R'
   ERROR
  Running the tests in 'tests/testthat.R' failed.
  Last 13 lines of output:
     12.   | \-base::asNamespace(ns)
     13.   \-base::loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]])
     14.     +-base::namespaceImportFrom(...)
     15.     | \-base::asNamespace(ns)
     17.       +-base::namespaceImportFrom(...)
     18.       | \-base::asNamespace(ns)
     19.       \-base::loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]])
     20.         \-base::withRestarts(stop(cond), retry_loadNamespace = function() NULL)
     21.           \-base:::withOneRestart(expr, restarts[[1L]])
     22.             \-base:::doWithOneRestart(return(expr), restart)
     16.     \-base::loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]])
    
    [ FAIL 1 | WARN 0 | SKIP 0 | PASS 156 ]
    Error: Test failures
    Execution halted

> On windows-x86_64-devel (r-devel), ubuntu-gcc-release (r-release), fedora-clang-devel (r-devel)
  checking CRAN incoming feasibility ... NOTE
  
  New submission
  
  Version contains large components (0.0.0.9001)
  
  Possibly mis-spelled words in DESCRIPTION:
    Erdfelder (27:34)
  Maintainer: 'Meike Steinhilber <Meike.Steinhilber@aol.com>'
    Hajnal (21:5)
    Rushton (20:46)
    SPRT (18:40, 21:33, 27:5)
    Schnuerch (27:22)

> On windows-x86_64-devel (r-devel), ubuntu-gcc-release (r-release), fedora-clang-devel (r-devel)
  checking top-level files ... NOTE
  Non-standard file/directory found at top level:
    'README.Rmd'

1 error x | 0 warnings √ | 2 notes x

* This is a new release.
