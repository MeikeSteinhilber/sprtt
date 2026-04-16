## Test environments
* GitHub Action
macos-latest (release)
windows-latest (release)
ubuntu-latest (devel)
ubuntu-latest (release)

* macOS builder
* win-builder

R CMD check results on CRAN's r-oldrelease Windows builder
One check showed: Package required but not available: 'MBESS'
This appears to be a transient issue on that builder — MBESS is available
on CRAN and passes checks locally and on win-builder r-release/r-devel.

## R CMD check results
── R CMD check results ──────────────────────────────────────────────────── sprtt 0.3.0 ────
Duration: 7m 27.2s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

## Reverse Dependencies
0 reverse dependencies

## Name change of the maintainer
From Meike Steinhilber to Meike Snijder-Steinhilber
