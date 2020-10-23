#' Provides a summary table of cases
#'
#' @param data See `?join_data` with dates and daily coronavirus cases.
#'
#' @return A summarized tibble of cases and cases per 100,000 of population.
#' @export
#' @importFrom magrittr %>%
#' @examples
#' # NOT RUN:
#' # library(dplyr)
#' # join_data %>%
#'     # summary_table()
summary_table <- function(data){
  x <- data

  x %>%
    group_by(country) %>%
    mutate(cases_per_100k = 100000*cases/population) %>%
    summarise(total_cases = scales::comma(sum(cases, na.rm = T)),
              total_cases_per_100k = scales::comma(sum(cases_per_100k, na.rm = T)),
              avg_cases = scales::comma(mean(cases, na.rm = T)),
              avg_cases_per_100k = scales::comma(mean(cases_per_100k, na.rm = T))) %>%
    knitr::kable(table.attr = "class='summary_table'",
                 digits = 2,
                 col.names = c("Country", "Total cases", "Total cases per 100k", "average cases", "average cases per 100k" ),
                 align = "lrrrr") %>%
    kableExtra::kable_styling(bootstrap_options = c("striped", "hover", "border"),
                              fixed_thead = list(enabled = T, background = "blue"))
}
