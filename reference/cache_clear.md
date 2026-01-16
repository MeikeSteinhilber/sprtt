# Clear cached simulation data

**\[experimental\]**

Removes locally cached simulation data. Data will be re-downloaded on
next use.

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
