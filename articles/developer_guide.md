# Developer Guide: sprtt Package

## Overview

This vignette provides technical documentation for developers who want
to maintain, extend, or contribute to the `sprtt` package. It explains
the internal architecture, code organization, computational methods, and
development workflows.

**Target audience**: R package developers, future maintainers, and
contributors

**Prerequisite knowledge**:

- R package development basics
- S4 object-oriented programming
- Statistical knowledge of Sequential Probability Ratio Tests (see
  [`vignette("sprts")`](https://meikesteinhilber.github.io/sprtt/articles/sprts.md))

## Package Architecture

### Overview

The `sprtt` package follows a modular architecture with clear separation
of concerns:

1.  **Main User-facing functions**
    ([`seq_ttest()`](https://meikesteinhilber.github.io/sprtt/reference/seq_ttest.md),
    [`seq_anova()`](https://meikesteinhilber.github.io/sprtt/reference/seq_anova.md))
    handle input validation and provide clean interfaces

2.  **Utility User-facing functions** provide supporting functionality
    (plotting, data generation, caching)

3.  **Builder functions** (`build_seq_*_arguments()`) Transform and
    validate user inputs into a structured S4 argument object. Builder
    functions act as a processing pipeline between the user-facing
    interface and the core calculation functions. They handle the task
    of parsing different input formats, validating all parameters, and
    packaging everything into a type-safe container.

4.  **Calculation functions** (`calc_seq_*()`) perform the core
    computations

5.  **Internal utility functions** (e.g., `delete_na()`,
    `extract_formula()`, `get_seq_decision()`, …) are small, focused
    helpers that handle specific tasks across the package. They follow
    the Single Responsibility Principle: Each function does one thing
    well. This design reduces code duplication, improves testability,
    and makes the codebase easier to maintain.

6.  **Result Classes** - S4 classes that store results in type-safe,
    structured containers. These classes provide controlled access to
    result components through standardized methods (`@`, `[]`, and
    `show()`), ensuring consistency and extensibility.

**Function Naming Convention:**

- `seq_*()`: User-facing main functions
- `build_*()`: Argument preparation functions  
- `calc_*()`: Computational core functions
- `*_class.R`: S4 class definitions

### Function Structure

**Table: Structure of the main
[`seq_ttest()`](https://meikesteinhilber.github.io/sprtt/reference/seq_ttest.md)
function (Level 1)**

[TABLE]

**Table: Structure of the main
[`seq_anova()`](https://meikesteinhilber.github.io/sprtt/reference/seq_anova.md)
function (Level 1)**

[TABLE]

## Test Coverage

The `sprtt` package maintains rigorous unit testing standards with a
target of 95-100% code coverage. Current coverage status can be
monitored via
[Codecov](https://app.codecov.io/gh/MeikeSteinhilber/sprtt).

All exported functions and internal utilities are tested
comprehensively. Acceptable exceptions to full coverage are:

- Code paths that require specific local environments and cannot be
  reliably tested on CI infrastructure
- Platform-specific functionality that’s only testable on certain
  operating systems
- Interactive components that depend on user input during runtime

Each pull request is automatically checked for coverage changes, and
decreases in coverage require justification before merging. This ensures
that new features come with corresponding tests and that refactoring
doesn’t inadvertently remove test coverage.

Quick guide to testing in `sprtt`:

Tests are organized in `tests/testthat/` and can be run using:

``` r
# Run all tests
devtools::test()

# Run tests with coverage report
covr::package_coverage()

# Run specific test file
testthat::test_file("tests/testthat/test-seq_anova.R")
```

When adding new functionality:

- Place tests in `tests/testthat/test-<filename>.R` corresponding to the
  R file being tested
- Use descriptive test names with
  `test_that("function handles edge case X", {...})`
- Test both expected behavior and error conditions
- For statistical functions, include tests with known results or
  theoretical properties
- For SPRT functions, consider testing against fixed random seeds for
  reproducibility

## Continuous Integration

The `sprtt` package uses multiple GitHub Actions workflows to maintain
code quality and documentation.

All workflows use r-lib/actions v2, which are pre-built,
community-maintained workflow components specifically designed for R
package development. This means you don’t have to write the CI setup
from scratch. The workflows authenticate automatically using GitHub’s
built-in `GITHUB_TOKEN`, so no manual setup of credentials is needed.
They also use public RSPM (Posit Package Manager) to download
pre-compiled package binaries, which installs packages in seconds rather
than minutes compared to compiling from source code.

### R CMD check (`R-CMD-check-windows-macOs.yaml`)

Runs comprehensive package checks across multiple platforms (Ubuntu,
macOS, Windows) and R versions (release, devel). Triggered on pushes and
pull requests to main/master/develop branches. This ensures the package
builds and passes all checks on CRAN’s target platforms.

### Test Coverage (`test-coverage-covr.yaml`)

Monitors code coverage using the `covr` package and reports to Codecov.
Runs on Ubuntu with each push to main/master and on pull requests.
Coverage reports help identify untested code paths and maintain testing
standards.

### Package Website (`pkgdown-pak.yaml`)

Automatically builds and deploys the pkgdown documentation site to
GitHub Pages. Triggered by pushes to main/master/develop, releases, and
pull requests. The workflow uses pak (a faster alternative to
install.packages) to install dependencies more quickly. When changes are
pushed directly to the repository (not from pull requests), the built
website is automatically published to the gh-pages branch, making it
available at the package’s GitHub Pages URL.

## Release Checklist

For CRAN submissions, consult these essential resources:

- **Generate checklist**:
  [`usethis::use_release_issue()`](https://usethis.r-lib.org/reference/use_release_issue.html) -
  creates a GitHub issue with package-specific checklist
- **CRAN submission portal**: <https://cran.r-project.org/submit.html>
- **Official CRAN checklist**:
  <https://cran.r-project.org/web/packages/submission_checklist.html>
- **Comprehensive guide**: <https://r-pkgs.org/release.html>

### Pre-release

Update version number in DESCRIPTION

Update NEWS.md with all changes

Run
[`devtools::check()`](https://devtools.r-lib.org/reference/check.html) -
must pass cleanly

Update documentation:
[`devtools::document()`](https://devtools.r-lib.org/reference/document.html)

Rebuild vignettes:
[`devtools::build_vignettes()`](https://devtools.r-lib.org/reference/build_vignettes.html)

Test on multiple platforms (rhub, win-builder)

Update README if needed

Check all examples run correctly

Verify all URLs in documentation are valid

Run code coverage: `covr::package_coverage()`

Update copyright year if needed

### CRAN Submission

Prepare cran-comments.md

Submit to CRAN:
[`devtools::release()`](https://devtools.r-lib.org/reference/release.html)

Monitor email for CRAN response

Check CRAN package page after acceptance

### Post-release

Create GitHub release with tag

Tweet/announce new version

Update pkgdown site:
[`pkgdown::build_site()`](https://pkgdown.r-lib.org/reference/build_site.html)

Increment development version number

Update NEWS.md with “Development version” section

## Contributing

**How to contribute:**

1.  Fork the repository
2.  Create a feature branch
3.  Make changes with tests
4.  Submit pull request
5.  Respond to review comments

**Contribution guidelines:**

- Follow existing code style
- Add tests for new features
- Update documentation
- Keep commits focused and atomic
- Write clear commit messages
