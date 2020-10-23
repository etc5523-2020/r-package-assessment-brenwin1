utils::globalVariables("country")
#' Determine countries to include in app's user interface
#'
#' @description Takes a list of country from inbuilt countries dataset (`Northern_hemis`, `Souther_hemis` & `Tropics`).
#' @return A drop down menu (i.e. `Shiny`'s `selectInput`) of selected countries
#' @import dplyr
#' @name countries_hemis
#' @param country A tibble filtered from `join_data`. see `?join_data`
#' @export
#' @examples
#' library(covidseasonality)
#' library(dplyr)
#' Tropics %>%
#'     filter(country == "Singapore") %>%
#'     countries_hemis()
countries_hemis <- function(country){
  if(dplyr::pull(country) %in% Southern_hemis$country){
    shiny::selectInput(inputId = "Southern",
                       label = "Southern Hemisphere",
                       choices = country,
                       selected = "Australia")
  }
  else if(dplyr::pull(country) %in% Northern_hemis$country){
    shiny::selectInput(inputId = "Northern",
                       label = "Northern Hemisphere",
                       choices = country,
                       selected = "Australia")
  }
  else if(dplyr::pull(country) %in% Tropics$country){
    shiny::selectInput(inputId = "Tropics",
                       label = "Tropics",
                       choices = country,
                       selected = "Singapore")
  }
  else{NA}
}


