
<!-- README.md is generated from README.Rmd. Please edit that file -->

# covidseasonality

<!-- badges: start -->

<!-- badges: end -->

The goal of `covidseasonality` package is to improve the accessibility
and readability of its corresponding Shiny app.

## Installation

<!-- You can install the released version of covidseasonality from [CRAN](https://CRAN.R-project.org) with: -->

<!-- ``` r -->

<!-- install.packages("covidseasonality") -->

<!-- ``` -->

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("etc5523-2020/r-package-assessment-brenwin1")
```

## Example

This is a basic example what the package includes

inbuilt datasets with countries in each hemisphere

``` r
library(covidseasonality)
library(tibble)

Northern_hemis # countries in the Northern Hemisphere
#> # A tibble: 100 x 1
#>    country             
#>    <chr>               
#>  1 Afghanistan         
#>  2 Albania             
#>  3 Andorra             
#>  4 United Arab Emirates
#>  5 Armenia             
#>  6 Austria             
#>  7 Azerbaijan          
#>  8 Belgium             
#>  9 Bangladesh          
#> 10 Bulgaria            
#> # … with 90 more rows
```

Takes data frame and plots daily cases against date. With shaded area
indicating winter months.

``` r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
join_data <- left_join(filter(covidseasonality::covid_data, country == "Australia"), 
                       filter(covidseasonality::world, region == "Australia"), 
                       by = c("country" = "region"))

join_data %>% 
  filter(country == "Australia") %>% 
  plot_countries_hemis()
#> Warning: Removed 1804 row(s) containing missing values (geom_path).
```

<img src="man/figures/README-plot-eg-1.png" width="100%" />
