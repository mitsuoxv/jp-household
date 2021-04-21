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
  ui <- navbarPage(
    "City competition to consume",
  
    tags$head(includeHTML(("google-analytics.html"))),
    
    selected = "By item",
    tabPanel("By item", showMapUI("item")),
    tabPanel("By city", findItemUI("city")
    )
  )
  
  # Define server logic required to draw a bar chart
  server <- function(input, output, session) {
    showMapServer("item")
    findItemServer("city")
  }
  
  # Run the application
  shinyApp(ui = ui, server = server)
}
