#' Join covid and map data for covidseasonality App
#'
#' @param countries countries included in datasets `Northern_hemis`, `Southern_hemis` & `Tropics`
#'
#' @return A tibble containing map coordinates and dates
#' @export
#'
#'
join_data <- function(countries){
  countries <- countries %>% pull(country)

  covid_data1 <- covidseasonality::covid_data %>%
    dplyr::filter(country %in% countries)

  world1 <- covidseasonality::world %>%
    dplyr::filter(region %in% countries)

  dplyr::left_join(covid_data1, world1,
            by = c("country" = "region"))

}
