# ========== FULL APP
# ---------- load libraries
library(shiny)
library(tidyverse)
library(colorspace)
library(tidycovid19)
library(plotly)
library(shinyWidgets)
library(DT)
library(shinycssloaders)
library(here)
library(covidseasonality) # my package!

options(spinner.color="#d3d3d3")

# ---------- join data
data <- covidseasonality::covid_data

join_data <- left_join(covidseasonality::covid_data,
                       covidseasonality::world,
                       by = c("country" = "region"))

Northern_hemis <- covidseasonality::Northern_hemis

Southern_hemis <- covidseasonality::Southern_hemis

Tropics <- covidseasonality::Tropics

# ========================== App =============================

ui <- navbarPage(
  title = "Covid19 Seasonality",
  theme = shinythemes::shinytheme("cyborg"),


  tabPanel("About",
           tags$h1("About This App"),
           p("My name is Brenwin. I am a Masters of Business Analytics Student at Monash
             Business School.
             I created this app as part of unit's (ETC5523 Communicating with Data)
             assignment but also seeks provide insights of the novel coronavirus' seasonality."),
           br(),
           p("The motivation of this topic is contentious, however, it is reasonable and justifiable that
             health officials around the globe concerned about colder seasons(winter).
             Astonishingly, a good",
             tags$a(href = "https://journeys.maps.com/what-countries-are-in-the-northern-hemisphere/",
                    "90% of human population lives in the Northern Hemisphere!"),
             "As Southern hemisphere",
             tags$a(href = "https://www.abc.net.au/news/science/2017-09-01/seasons-and-their-changes-explained/8858776",
                    "whose cold season recently ended (Winter from Jun-Aug)"),
             "and the weather migrates across the hemisphere. It is an opportunity to take an early
                    glimpse of what awaits Northern countries. For example, here in Melbourne, we" ,
             tags$a(href = "https://www.bloombergquint.com/coronavirus-outbreak/melbourne-is-living-the-cold-weather-virus-surge-experts-fear",
                    "experienced a virus resurgence that dwarfed the 1st outbreak in March"),
             "Furthermore, in recent weeks,",
             tags$a(href = "https://www.cnbc.com/2020/09/02/coronavirus-and-winter-health-experts-wary-about-a-possible-new-wave.html",
                    "Europe face a sharp increase in cases as government eases restrictions - the
             first time EU had more cases than US")),
           br(),
           p("There are various stipulations as to why cold weather might accelerate an outbreak. Based on experience of
             other respiratory diseases,",
             tags$a(href = "https://www.washingtonpost.com/health/2020/04/21/coronavirus-secondwave-cdcdirector/",
                    "the novel coronavirus has seasonal properties and tend to thrive in cooler conditions."),
             "Furthermore, social factors come into play. During winter, people tend to gather indoors with less ventilation as
             they shut windows etc. Furthermore, people immune system weakens in winter and are more vulnerable to the influenza.
             Importantly, government factors play an important role in curbing the virus. With that
             being said however, the virus is still relatively new there has been" ,
             tags$a(href = "https://www.cnbc.com/2020/09/02/coronavirus-and-winter-health-experts-wary-about-a-possible-new-wave.html",
                    "no concrete evidence of seasonality's impact on
             the virus.")),

           p("The app is split into 2 topics (in which order does not matter) to Comparisons within countries &
             Comparisons Across countries. On Earth, there are 2 hemispheres namely, the Northern and Southern
             hemispheres (corresponding half of the planet split by the equator). "),
           br(),
           p("*Disclaimer: This virus is a complex disease and this app by no means is able to capture all its
             complexities. ")),



  tabPanel("Comparing Within Countries",
           tags$h2("Within Countries"),
           p("This tab seeks to compare new covid-19 cases across countries in Southern, Northern & Tropical countries
           respectively. These graphs are deliberately set to vertically align to facilitate comparison."),
           br(),
           p("The sky blue shaded area represents winter where we (might) expect a higher number of cases.
           Due to the many factors surrounding spread of covid-19, we can use Tropics as a sort of 'control' group."),
           hr(),
           fluidRow(
             # Southern Hemisphere Selection
             column(3, countries_hemis(Southern_hemis)),
             column(9, plotOutput("southern", height = 250) %>%
                      withSpinner(type = 7))
           ),

           fluidRow(
             # Northern Hemisphere selection
             column(3, countries_hemis(Northern_hemis)),
             column(9, plotOutput("northern", height = 250) %>%
                      withSpinner(type = 7))
           ),

           fluidRow(
             # Tropics Selection
             column(3, countries_hemis(Tropics)),
             column(9, plotOutput("tropics", height = 250) %>%
                      withSpinner(type = 7))
           )),

  tabPanel("Comparing Across Countries",
           sidebarLayout(
             mainPanel(tags$style(type = "text/css", "#map {height: calc(100vh - 80px) !important;}"),
                       plotly::plotlyOutput("map", width = "100%", height = "100%") %>%
                         withSpinner(type = 7),

                       absolutePanel(bottom = 30, left = 10, draggable = TRUE,
                                     dateRangeInput(inputId = "date_range",
                                                    label = "Select Date",
                                                    start = "2020-01-01", end = "2020-12-31"),

                                     radioGroupButtons(
                                       inputId = "indicator",
                                       label = "Select Indicator",
                                       choices = c("New cases over Period", "New cases over Period per 100,000 population"),
                                       direction = "vertical",
                                       selected = "New cases over Period"),

                                     pickerInput(
                                       inputId = "across_countries",
                                       label = "Select Countries",
                                       multiple = TRUE,
                                       choices = list(
                                         Northern = Northern_hemis$country,
                                         Southern = Southern_hemis$country,
                                         Tropic = Tropics$country),
                                       options = list(`actions-box` = TRUE),
                                       selected = "Australia"
                                     ),

                                     actionButton(inputId = "update",
                                                  label = "Show")),
             ),

             sidebarPanel(
               p("This page provides a broader overview of cases in countries around the world.
        Feel free to toggle to your desired dates, indicator and select countries('Select all' option is available) to show.
          The map is filled by the number of cases(based on indicator) and red line indicates the Equator."),
               br(),
               p("A corresponding interactive line plot is also produced along with a table to enable
          a convenient way for looking into different factors."),
               hr(),
               plotly::plotlyOutput("across_plot", height = 300) %>%
                 withSpinner(type = 7),
               br(),
               br(),
               DT::dataTableOutput("dt_table", height = 300) %>%
                 withSpinner(type = 7))
           )
  ),

  tabPanel("References",
           tags$h2("References"),
           "C. Sievert. Interactive Web-Based Data Visualization with R, plotly, and shiny. Chapman and Hall/CRC
  Florida, 2020.",
           tags$br(),
           tags$br(),
           "Gross, S., & Gale, J. (2020). Winter Virus Surge Down Under Shows U.S., Europe What May Come.
  Retrieved 9 October 2020, from https://www.bloombergquint.com/coronavirus-outbreak/melbourne-is-living-the-cold-weather-virus-surge-experts-fear",
           tags$br(),
           tags$br(),
           "H. Sun, L. (2020). CDC director warns second wave of coronavirus is likely to be even more devastating. Retrieved 9 October 2020,
  from https://www.washingtonpost.com/health/2020/04/21/coronavirus-secondwave-cdcdirector/",
           tags$br(),
           tags$br(),
           "Hobbs, B. (2020). Spring, summer, autumn and winter — why do we have seasons?. Retrieved 9 October 2020,
  from https://www.abc.net.au/news/science/2017-09-01/seasons-and-their-changes-explained/8858776",
           tags$br(),
           tags$br(),
           "Joachim Gassen (2020). tidycovid19: Download, Tidy and Visualize Covid-19 Related Data. R package
  version 0.0.0.9000.",
           tags$br(),
           tags$br(),
           "Meredith, S. (2020). Health experts sound the alarm on a possible new coronavirus wave this winter. Retrieved 9 October 2020,
  from https://www.cnbc.com/2020/09/02/coronavirus-and-winter-health-experts-wary-about-a-possible-new-wave.html",
           tags$br(),
           tags$br(),
           "Victor Perrier, Fanny Meyer and David Granjon (2020). shinyWidgets: Custom Inputs Widgets for Shiny.
  R package version 0.5.3. https://CRAN.R-project.org/package=shinyWidgets",
           tags$br(),
           tags$br(),
           "What Countries are in the Northern Hemisphere? - Journeys by Maps.com. (2020). Retrieved 9 October 2020,
  from https://journeys.maps.com/what-countries-are-in-the-northern-hemisphere/",
           tags$br(),
           tags$br(),
           "Wickham et al., (2019). Welcome to the tidyverse. Journal of Open Source Software, 4(43), 1686,
  https://doi.org/10.21105/joss.01686",
           tags$br(),
           tags$br(),
           "Winston Chang, Joe Cheng, JJ Allaire, Yihui Xie and Jonathan McPherson (2020). shiny: Web Application
  Framework for R. R package version 1.5.0. https://CRAN.R-project.org/package=shiny",
           tags$br(),
           tags$br(),
           "Yihui Xie, Joe Cheng and Xianying Tan (2020). DT: A Wrapper of the JavaScript Library 'DataTables'. R
  package version 0.15. https://CRAN.R-project.org/package=DT",
           tags$br(),
           tags$br(),
           "Zeileis A, Fisher JC, Hornik K, Ihaka R, McWhite CD, Murrell P, Stauffer R, Wilke CO (2019).
“colorspace: A Toolbox for Manipulating and Assessing Colors and Palettes.” arXiv 1903.06490, arXiv.org
E-Print Archive. <URL: http://arxiv.org/abs/1903.06490>."
  )

)




server <- function(input, output){
  output$southern <- renderPlot({
    # southern
    southern <- join_data %>%
      filter(country == input$Southern) %>%
      plot_countries_hemis()

    southern
  })

  output$northern <- renderPlot({
    # northern plot
    northern <- join_data %>%
      filter(country == input$Northern) %>%
      plot_countries_hemis()

    northern
  })

  output$tropics <- renderPlot({
    tropics <- join_data %>%
      filter(country == input$Tropics) %>%
      plot_countries_hemis()

    tropics
  })

  rv <- reactiveValues(data = data)

  observeEvent(input$indicator,{
    input_indicator <- input$indicator
    if(input_indicator == "New cases over Period"){
      rv$data <- data
    } else{
      rv$data <- data %>%
        mutate(cases = 100000*cases/population)
    }
  })

  across_data <- eventReactive(input$update, { # update; only when `update` clicked
    rv$data %>%
      filter(date >= input$date_range[1],
             date <= input$date_range[2],
             country %in% input$across_countries)
  })


  map_data <- reactive({
    across_data() %>%
      group_by(country) %>%
      summarize(cases = sum(cases, na.rm = TRUE)) %>%
      distinct(country,
               .keep_all = TRUE) %>%
      right_join(., world, by = c("country" = "region"))
  })

  output$across_plot <- renderPlotly({
    g1 <- ggplot(data = across_data()) +
      geom_line(aes(x = date,
                    y = cases,
                    colour = country,
                    group = country,
                    text = paste("</br> Date: ", date,
                                 "</br> Country:", country,
                                 "</br> Cases:", round(cases, digits = 2)))) +
      theme(legend.position = "none")

    ggplotly(g1,
             tooltip = "text") %>%
      config(displayModeBar = F)
  })

  output$map <- renderPlotly({
    g2 <- map_data() %>%
      ggplot() +
      geom_polygon(aes(x = long,
                       y = lat,
                       group = group,
                       fill = cases,
                       text = paste("</br> Country:", country,
                                    "</br> Cases:", round(cases,
                                                          digits = 2)))) +
      colorspace::scale_fill_continuous_sequential("YlOrRd",
                                                   label = scales::comma) +
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

    ggplotly(g2,
             tooltip = "text") %>%
      config(displayModeBar = F)
  })

  output$dt_table <- DT::renderDataTable({
    DT::datatable(across_data(),
                  extensions = c("Scroller",
                                 "FixedColumns"),
                  options = list(scrollY = "200px", # enable scrolling
                                 scrollX = T)) %>%
      DT::formatStyle(
        columns = c("date", "iso3c", "country", "confirmed", "cases", "lockdown", "region", "population"),
        color = "black"
      ) %>%
      formatCurrency("cases", currency = "", interval = 3, mark = ",", digits = 2) %>%
      formatCurrency("population", currency = "", interval = 3, mark = ",", digits = 0)
  })
}

shinyApp(ui = ui,
         server = server)
