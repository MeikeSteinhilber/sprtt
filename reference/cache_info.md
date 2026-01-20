# Cache information

**\[experimental\]**

Displays information about cached simulation data (~70 MB) used by
[`plan_sample_size()`](https://meikesteinhilber.github.io/sprtt/reference/plan_sample_size.md).
Shows the cache directory location, whether data is cached, and file
size if present.

The simulation data is automatically downloaded on first use of sample
size planning functions and stored locally for faster subsequent access.

## Usage

``` r
cache_info()
```

## Value

Invisibly returns a list with:

- `cache_dir`: Character string with the cache directory path

- `data_cached`: Logical indicating if simulation data is cached

- `file_size_mb`: Numeric file size in MB (or `NA` if not cached)

## See also

- [`cache_clear()`](https://meikesteinhilber.github.io/sprtt/reference/cache_clear.md)
  to remove cached data

- [`download_sample_size_data()`](https://meikesteinhilber.github.io/sprtt/reference/download_sample_size_data.md)
  to manually download simulation data

- [`plan_sample_size()`](https://meikesteinhilber.github.io/sprtt/reference/plan_sample_size.md)
  which uses the cached data
