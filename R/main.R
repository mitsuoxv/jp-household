#' Shiny app to show Japanese household expenditures by prefecture
#'
#' @return A Shiny app.
#' @import shiny
#' @export
#'
#' @examples
#' \dontrun{
#' mainApp()
#' }
mainApp <- function() {
  level_menu <- 1:5
  names(level_menu) <- paste0("level ", 1:5)
  
  # Define UI for application that draws a histogram
  ui <- navbarPage(
    "City competition to consume",
  
    tags$head(includeHTML((
      "google-analytics.html"
    ))),
    
    selected = "By item",
  
    tabPanel("By item",
      sidebarLayout(
        sidebarPanel(
          radioButtons("radio",
            label = h3("Select item level"),
            choices = level_menu,
            selected = 1
          ),
  
          hr(),
  
          selectInput("select",
            label = h3("Select item"),
            choices = NULL
          ),
  
          hr(),
  
          # Sidebar with a slider input for year
          sliderInput("year",
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
          plotOutput("mapPlot", height = "500px"),
          plotOutput("barPlot", height = "600px")
        )
      )
    ),
    tabPanel(
      "By city",
      sidebarLayout(
        sidebarPanel(
          selectInput("select_city",
            label = h3("Select city"),
            choices = japan$city_menu
          ),
  
          hr(),
  
          # Sidebar with a slider input for ranks
          sliderInput("select_rank",
            label = h3("Select ranks"),
            min = 1,
            max = 52,
            value = 1,
            sep = ""
          )
        ),
  
        # Show a table
        mainPanel(DT::dataTableOutput("table"))
      )
    )
  )
  
  # Define server logic required to draw a bar chart
  server <- function(input, output, session) {
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
    })
  
    output$barPlot <- renderPlot(draw_col(data()), res = 96)
  
    output$mapPlot <- renderPlot(draw_map(data()), res = 96)
  
    output$table <- DT::renderDataTable({
      japan$area_ranks %>%
        dplyr::filter(city_e == input$select_city, ranks <= input$select_rank) %>%
        dplyr::select(year, ranks, cat01) %>%
        dplyr::arrange(desc(year), ranks, cat01) %>%
        DT::datatable()
    })
  }
  
  # Run the application
  shinyApp(ui = ui, server = server)
}
