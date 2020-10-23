library(hexSticker)
library(ggplot2)
library(dplyr)

map_sticker <- ggplot2::map_data("world") %>%
  ggplot() +
  geom_polygon(aes(x = long, y = lat, group = group),
               fill = "grey70") +
  # fill = absolute/cases)) + # fill by case
  geom_hline(yintercept = 0,
             colour = "red") %>%
  geom_hline(yintercept = 0,
             colour = "red") +
  annotate("rect",
           ymin = -23.44, ymax = 23.44,
           xmin = -Inf, xmax = Inf,
           fill = "red", alpha = 0.2) +
  ggthemes::theme_map() +
  theme(panel.background = element_rect(fill = "grey20"),
        plot.background = element_rect(fill = "grey20")) +
  theme(legend.position = "right",
        legend.background = element_rect(fill = "grey20"),
        legend.text = element_text(colour = "white"),
        legend.title = element_text(colour = "white")) +
  theme(plot.title = element_text(size = 20, face = "bold", colour = "orange"),
        plot.subtitle = element_text(size = 16, colour = "orange"))

sticker(map_sticker,
        # pic
        package = "covidseasonality",
        p_size = 4,
        p_y = 1.60,
        p_color = "white",
        p_family = "serif",
        # plot
        s_x = 1, s_y = 1, # position
        s_width = 1.7, s_height = 1, # size
        h_fill = "#008080",
        h_color = "black",
        filename = file.path("man/figures/CSsticker.png"))
