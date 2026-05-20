# Clear cached simulation data

**\[experimental\]**

Removes locally cached simulation data (~70 MB) used by
[`plan_sample_size()`](https://meikesteinhilber.github.io/sprtt/reference/plan_sample_size.md).
Data will be automatically re-downloaded on next use of sample size
planning functions.

This function is useful when:

- You want to free up disk space

- The cached data may be outdated and you want to force a fresh download

- Troubleshooting cache-related issues

## Usage

``` r
cache_clear()
```

## Value

Invisibly returns `TRUE` if cache was cleared, `FALSE` if no cache
existed.

## Examples

``` r
if (FALSE) { # \dontrun{
# Clear cache
cache_clear()
} # }
```
