#' findItem module UI
#'
#' @param id A character vector of length 1.
#'
#' @return A module UI.
#'
#' @examples
#' \dontrun{
#' findItemUI("city")
#' }
findItemUI <- function(id) {
  sidebarLayout(
    sidebarPanel(
      selectInput(NS(id, "select_city"),
                  label = h3("Select city"),
                  choices = japan$city_menu
      ),
      
      hr(),
      
      radioButtons(NS(id, "level"),
                   label = h3("Select item level"),
                   choices = japan$level_menu,
                   selected = 5
      ),
      
      hr(),
      
      sliderInput(NS(id, "year_range"),
                  label = h4("Select year range"),
                  min = 2007,
                  max = 2020,
                  value = c(2007, 2020),
                  sep = ""
      )
    ),
    
    # Show a table
    mainPanel(
      plotly::plotlyOutput(NS(id, "linePlot"))
      )
  )
}

#' findItem module Server
#'
#' @param id A character vector of length 1.
#'
#' @return A module server.
#'
#' @examples
#' \dontrun{
#' findItemServer("city")
#' }
findItemServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    city_data <- reactive({
      japan$expense %>%
        dplyr::filter(
          level == input$level,
          city_e == input$select_city,
          year >= input$year_range[1],
          year <= input$year_range[2]
          )
    }) %>% 
      bindCache(input$level, input$select_city, input$year_range)
    
    output$linePlot <- plotly::renderPlotly({
      hot_items <- city_data() %>% 
        dplyr::group_by(cat01_code) %>% 
        dplyr::summarize(avg_rank = mean(ranks, na.rm = TRUE)) %>% 
        dplyr::slice_min(avg_rank, n = 10)

      p <- city_data() %>%
        dplyr::semi_join(hot_items, by = "cat01_code") %>% 
        dplyr::select(year, ranks, cat01, value) %>% 
        ggplot2::ggplot(ggplot2::aes(year, ranks)) +
        ggplot2::geom_jitter(ggplot2::aes(color = cat01, alpha = value), width = 0) +
        ggplot2::scale_y_reverse() +
        ggplot2::labs(title = "10 items with high average rank in this year range",
                      x = "value: yen per year per household",
                      color = NULL, alpha = NULL)
      
      plotly::ggplotly(p)
    })
  })
}
