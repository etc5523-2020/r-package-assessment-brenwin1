
<!-- README.md is generated from README.Rmd. Please edit that file -->

# covidseasonality <img src='man/figures/logo.png' align="right" height="139" />

# covidseasonality

<!-- badges: start -->

<!-- badges: end -->

`covidseasonality` package contains all the tools needed to make the its
corresponding `Shiny` app. This package aims to improve the app’s
accessibility and readability. It also provides a means to review
seasonal change in cases across the world.

## Installation

<!-- You can install the released version of covidseasonality from [CRAN](https://CRAN.R-project.org) with: -->

<!-- ``` r -->

<!-- install.packages("covidseasonality") -->

<!-- ``` -->

You could install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("etc5523-2020/r-package-assessment-brenwin1")
```

## Example

This is a basic example what the package includes

inbuilt datasets with countries in the Tropics, Northern and Southern
Hemisphere.

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

Takes data frame and plots daily cases against date with shaded area
indicating winter months. Now you can extend this to include countries
in the world.

``` r
library(dplyr)
join_data <- left_join(filter(covidseasonality::covid_data, country == "Australia"), 
                       filter(covidseasonality::world, region == "Australia"), 
                       by = c("country" = "region"))

join_data %>% 
  filter(country == "Australia") %>% 
  covidseasonality::plot_countries_hemis()
```

<img src="man/figures/README-plot-eg-1.png" width="100%" />
