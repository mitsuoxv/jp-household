#' showMap module UI
#'
#' @param id A character vector of length 1.
#'
#' @return A module UI.
#'
#' @examples
#' \dontrun{
#' showMapUI("item")
#' }
showMapUI <- function(id) {
  sidebarLayout(
    sidebarPanel(
      radioButtons(NS(id, "level"),
                   label = h3("Select item level"),
                   choices = japan$level_menu,
                   selected = 1
      ),
      
      hr(),
      
      selectInput(NS(id, "select"),
                  label = h3("Select item"),
                  choices = NULL
      ),
      
      hr(),
      
      # Sidebar with a slider input for year
      sliderInput(NS(id, "year"),
                  label = h3("Select year"),
                  min = 2007,
                  max = 2024,
                  value = 2024,
                  sep = "",
                  animate = TRUE
      ),
      
      hr(),
      
      # Show source and Shiny app creator
      a(
        href = "https://www.stat.go.jp/english/data/kakei/",
        "Source: Statistics Bureau of Japan, Japan Family Income and Expenditure Survey"
      ),
      br(),
      a(
        href = "https://mitsuoxv.rbind.io/",
        "Shiny app creator: Mitsuo Shiota"
      )
    ),
    
    # Show a plot of the generated bar chart
    mainPanel(
      plotOutput(NS(id, "mapPlot"), height = "400px"),
      plotOutput(NS(id, "barPlot"), height = "700px")
    )
  )
}

#' showMap module Server
#'
#' @param id A character vector of length 1.
#'
#' @return A module server.
#'
#' @examples
#' \dontrun{
#' showMapServer("item")
#' }
showMapServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    observe({
      updateSelectInput(session, "select",
                        choices = japan$cat01_code_level[[as.numeric(input$level)]]
      )
    })
    
    data <- reactive({
      req(input$select, input$year)
      
      japan$expense %>%
        dplyr::filter(
          cat01_code == input$select,
          year == input$year
        )
    }) %>% 
      bindCache(input$select, input$year)
    
    output$barPlot <- renderPlot(draw_col(data()), res = 96)
    
    output$mapPlot <- renderPlot(draw_map(
      data() %>% 
        dplyr::filter(!area_code %in% c("00000", "14004", "14150", "22004", "27004", "40003")) %>% 
        # exclude 全国、川崎市、相模原市、浜松市、堺市、北九州市
        dplyr::pull(value)
      ), res = 96)
  })
}