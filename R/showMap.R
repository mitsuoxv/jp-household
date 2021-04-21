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
  level_menu <- 1:5
  names(level_menu) <- paste0("level ", 1:5)
  
  sidebarLayout(
    sidebarPanel(
      radioButtons(NS(id, "radio"),
                   label = h3("Select item level"),
                   choices = level_menu,
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
                  max = 2020,
                  value = 2020,
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
      plotOutput(NS(id, "mapPlot"), height = "500px"),
      plotOutput(NS(id, "barPlot"), height = "600px")
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
                        choices = japan$cat01_code_level[[as.numeric(input$radio)]]
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
    
    output$mapPlot <- renderPlot(draw_map(data()), res = 96)
  })
}