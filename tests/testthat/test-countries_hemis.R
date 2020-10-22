test_that("countries_hemis returns NA for non-countries input", {
  x <- tibble::tibble("Mars")
  testthat::expect_equal(
    countries_hemis(x), # test results
    NA) # expectations
 })

test_that("countries_hemis returns shiny input container",{
  x <- tibble::tibble("Singapore")
  testthat::expect_match(
    as.character(countries_hemis(tibble::tibble("Singapore"))),
    "<div class=\"form-group shiny-input-container\">\n", 1
  )
})

