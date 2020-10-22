library(ggplot2)
library(covidseasonality)
test_that("ggplot object", {
  x <- tibble::tibble(date = as.Date("2020-01-01"),
              cases = 5,
              country = "Australia")

  testthat::expect_true(is.ggplot(plot_countries_hemis(x)))
})
