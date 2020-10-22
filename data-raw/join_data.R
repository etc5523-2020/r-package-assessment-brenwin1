## code to prepare `join_data` dataset goes here

library(tidycovid19)
library(readr)
library(dplyr)

# ----------- Read in data sets
# coronavirus
data <- tidycovid19::download_merged_data(cached = TRUE)

# tropical countries
tropical <- readr::read_csv("data-raw/tropical_countries.csv") %>%
  dplyr::select(country)

# world data (with coordinates)
world <- ggplot2::map_data("world")

# ---------- syncing countries in data sets to one data set (used throughout app)

# coronavirus data set
data <- data %>%
  dplyr::select(date, iso3c, country, confirmed, lockdown, region, population) %>%
  # change NAs to 0
  mutate(confirmed = tidyr::replace_na(confirmed, 0)) %>%
  group_by(country) %>%
  # found new cases count
  mutate(cases = confirmed - lag(confirmed)) %>%
  # rearrange columns
  select(1:4, 8, 5:7) %>%  # relocate function
  ungroup() %>%
  # remove last date (no data)
  filter(date != max(date))

covid_data <- data %>%
  # filter countries w/o cases
  dplyr::filter(!country %in% c("Caribbean Netherlands",
                                "Gibraltar",
                                "St. Kitts & Nevis",
                                "British Virgin Islands",
                                "U.S. Virgin Islands")) %>%
  mutate(country = case_when(
    country == "Côte d’Ivoire" ~ "Ivory Coast",
    country == "Congo - Kinshasa" ~ "Democratic Republic of the Congo",
    country == "Congo - Brazzaville" ~ "Republic of Congo",
    country == "Curaçao" ~ "Curacao",
    country == "Czechia" ~ "Czech Republic",
    country == "North Macedonia" ~ "Macedonia",
    country == "Myanmar (Burma)" ~ "Myanmar",
    country == "Palestinian Territories" ~ "Palestine",
    country == "São Tomé & Príncipe" ~ "Sao Tome and Principe",
    country == "Eswatini" ~ "Swaziland",
    country == "Trinidad & Tobago" ~ "Trinidad",
    country == "St. Vincent & Grenadines" ~ "Saint Vincent",
    TRUE ~ country
  ))

# World data set
world <- world %>%
  mutate(region = case_when(
    region  == "Antigua" ~ "Antigua & Barbuda",
    region == "Bosnia and Herzegovina" ~ "Bosnia & Herzegovina",
    region == "UK" ~ "United Kingdom",
    region == "Saint Lucia" ~ "St. Lucia",
    region == "Turks and Caicos Islands" ~ "Turks & Caicos Islands",
    region == "USA" ~ "United States",
    region == "Vatican" ~ "Vatican City",
    TRUE ~ region
  ))

# pull tropical countries vector
tropical <- tropical %>%
  mutate(country = case_when(
    country == "DR Congo" ~ "Democratic Republic of the Congo",
    country == "Republic of the Congo" ~ "Republic of Congo",
    country == "Trinidad and Tobago" ~ "Trinidad",
    country == "Saint Lucia" ~ "St. Lucia",
    country == "Saint Vincent and the Grenadines" ~ "Saint Vincent",
    country == "United States Virgin Islands" ~ "Virgin Islands",
    country == "Antigua and Barbuda" ~ "Antigua & Barbuda",
    country == "Turks and Caicos Islands" ~ "Turks & Caicos Islands",
    TRUE ~ country
  )) %>% pull()

# add hemisphere column
world <- world %>%
  # add hemisphere
  mutate(hemisphere = case_when(
    lat > 0 ~ "N", # Northern Hemisphere
    lat < 0 ~ "S" # Southern Hemisphere
  )) %>%
  # countries in tropics
  mutate(hemisphere = case_when(
    region %in% tropical ~ "T",
    TRUE ~ hemisphere
  ))

join_data <- left_join(covid_data, world,
                       by = c("country" = "region")) %>%
  select(-c(iso3c, order, subregion, region))

# countries in Northern hemisphere
Northern_hemis <- join_data %>%
  filter(hemisphere == "N") %>%
  distinct(country)

usethis::use_data(Northern_hemis, overwrite = TRUE)

# countries in Southern hemisphere
Southern_hemis <- join_data %>%
  filter(hemisphere == "S") %>%
  distinct(country)

usethis::use_data(Southern_hemis, overwrite = TRUE)

# countries in Tropics
Tropics <- join_data %>%
  filter(hemisphere == "T") %>%
  distinct(country)

usethis::use_data(Tropics, overwrite = TRUE)

usethis::use_data(covid_data, overwrite = TRUE)
usethis::use_data(world, overwrite = TRUE)




