library(covidseasonality)
test_that("data frame requires cases column", {
  data <- country_list %>%
    dplyr::filter(country == "Australia") %>%
    covidseasonality::join_data() %>%
    select(-cases)

  expect_error(data %>% summary_table)
})
