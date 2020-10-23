test_that("test input data frame requires country column", {
  x <- tibble(countries = "Singapore")

  testthat::expect_error(join_data(x))
})

test_that("test input data frame requires country column", {
  x <- tibble(country = "Singapore")

  testthat::expect_equal(is.data.frame(join_data(x)),
                         TRUE)
})

