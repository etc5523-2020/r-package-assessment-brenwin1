#' Provides a summary table of cases
#'
#' @param x See `?join_data` with dates and daily coronavirus cases.
#'
#' @return A summarized tibble of cases and cases per 100,000 of population.
#' @export
#'
#' @examples
summary_table <- function(x){
  x %>%
    group_by(country) %>%
    mutate(cases_per_100k = 100000*cases/population) %>%
    summarise(total_cases = sum(cases, na.rm = T),
              total_cases_per_100k = sum(cases_per_100k, na.rm = T),
              avg_cases = mean(cases, na.rm = T),
              avg_cases_per_100k = mean(cases_per_100k, na.rm = T))
}
