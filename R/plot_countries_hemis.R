utils::globalVariables(c("cases", "country"))
#' Line plot of cases against date with shaded area representing winter
#' @import ggplot2
#' @param x Data set containing a `country` column
#' @return a `ggplot` object
#' @export
#'
plot_countries_hemis <- function(x){
  base <- x %>%
    ggplot2::ggplot() +
    geom_line(aes(x = .data$date,
                  y = .data$cases)) +
    scale_x_date(date_breaks = "1 month", # 1 month break in date
                 date_labels = format("%b"), # label month; abbrev.
                 limits = as.Date(c("2020-01-01", "2020-12,31"))) + # x-axis scale: Jan - Dec
    scale_y_continuous(labels = scales::comma) +
    labs(x = "Date",
         y = "cases",
         title = "New confirmed cases of Covid-19",
         subtitle = "01/01/20 - Present") +
    theme_bw()

  # adding respective sky-blue shdaed rectangles representing winter
  if(unique(x$country) %in% Northern_hemis$country){
    p <- base +
      annotate("rect",
               xmin = as.Date("2020-12-01"),
               xmax = as.Date("2020-12-31"),
               ymin = -Inf, ymax = Inf,
               fill = "sky blue", alpha = 0.3) +
      annotate("rect",
               xmin = as.Date("2020-01-01"),
               xmax = as.Date("2020-02-28"),
               ymin = -Inf, ymax = Inf,
               fill = "sky blue", alpha = 0.3)

    p
  }
  else if(unique(x$country) %in% Southern_hemis$country){
    p <- base +
      annotate("rect",
               xmin = as.Date("2020-06-01"),
               xmax = as.Date("2020-08-31"),
               ymin = -Inf, ymax = Inf,
               fill = "sky blue", alpha = 0.3)

    p
  }
  else if(unique(x$country) %in% Tropics$country){
    p <- base
    p
  }
  else{NA}
}
