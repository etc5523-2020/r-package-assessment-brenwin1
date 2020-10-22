#' Determine countries to include in app's user interface
#'
#' @description Takes a list of country from inbuilt countries dataset (`Northern_hemis`, `Souther_hemis` & `Tropics`).
#' @return A drop down menu (i.e. `Shiny`'s `selectInput`) of selected countries
#' @name countries_hemis
#' @export
#' @examples
#' library(covidseasonality)
#' library(dplyr)
#' Tropics %>%
#'     filter(country == "Singapore") %>%
#'     countries_hemis()
countries_hemis <- function(country){
  if(pull(country) %in% Southern_hemis$country){
    shiny::selectInput(inputId = "Southern",
                       label = "Southern Hemisphere",
                       choices = country,
                       selected = "Australia")
  }
  else if(pull(country) %in% Northern_hemis$country){
    shiny::selectInput(inputId = "Northern",
                       label = "Northern Hemisphere",
                       choices = country,
                       selected = "Australia")
  }
  else if(pull(country) %in% Tropics$country){
    shiny::selectInput(inputId = "Tropics",
                       label = "Tropics",
                       choices = country,
                       selected = "Singapore")
  }
}



