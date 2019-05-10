#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# libraries
library(shiny)
library(tidyverse)

# read data
expense <- readRDS("data/expense.rds")

# create level list
level_list <- function(i) {
  temp <- expense %>% 
    filter(level == i) %>% 
    select(cat01, cat01_code) %>% 
    unique()
  
  split(temp$cat01_code, temp$cat01)
}

cat01_code_level <- vector("list", 5)

for (i in seq_along(cat01_code_level)) {
  temp <- expense %>% 
    filter(level == i) %>% 
    select(cat01, cat01_code) %>% 
    unique()
  
  cat01_code_level[[i]] <- split(temp$cat01_code, temp$cat01)
}

# create city list
temp <- expense %>% 
  select(city, city_e) %>% 
  unique()

city_list <- split(temp$city_e, temp$city)

# test
area_ranks <- expense %>% 
  filter(level == 5) %>% 
  filter(area_code != "00000") %>% 
  group_by(year, cat01_code) %>% 
  mutate(ranks = rank(desc(value), ties.method = "average")) %>% 
  ungroup()

# Define UI for application that draws a histogram
ui <- navbarPage("City competition to consume",
    tabPanel("By item",
    sidebarLayout(
        sidebarPanel(
            radioButtons("radio", label = h3("Select item level"),
                         choices = list("level 1" = 1, "level 2" = 2, "level 3" = 3,
                                        "level 4" = 4, "level 5" = 5), 
                         selected = 1),
            
            hr(),
            
            selectInput("select", label = h3("Select item"), 
                        choices = NULL),

            hr(),
            
            # Sidebar with a slider input for year 
            sliderInput("year",
                        label = h3("Select year"), 
                        min = 2007,
                        max = 2018,
                        value = 2018,
                        sep = "")
        ),

        # Show a plot of the generated bar chart
        mainPanel(
           plotOutput("barPlot", height = "600px")
        )
    )
    ),
    tabPanel("By city",
             sidebarLayout(
               sidebarPanel(
                 selectInput("select_city", label = h3("Select city"), 
                             choices = city_list),
                 
                 hr(),
                 
                 # Sidebar with a slider input for ranks 
                 sliderInput("select_rank",
                             label = h3("Select ranks"), 
                             min = 1,
                             max = 52,
                             value = 1,
                             sep = "")               ),
               
               # Show a table
               mainPanel(
                 DT::dataTableOutput("table")
               )
             )
    )
)

# Define server logic required to draw a bar chart
server <- function(input, output, session) {
  observe({
    # Change values for input$select
    updateSelectInput(session, "select",
                      choices = cat01_code_level[[as.numeric(input$radio)]]
    )
  
    output$barPlot <- renderPlot({
        # draw the bar chart with the specified year
        national_average <- expense %>% 
            filter(cat01_code == input$select, year == input$year,
                   area_code == "00000") %>% 
            select(value) %>% 
            as.numeric()

        # draw the bar chart with the specified year
        expense %>% 
            filter(cat01_code == input$select, year == input$year,
                   area_code != "00000") %>% 
            mutate(loser = (value != max(value))) %>% 
            ggplot(aes(x = reorder(city_e, desc(city_e)), y = value, fill = loser)) +
            geom_bar(stat = "identity", width = 1) +
            geom_hline(yintercept = national_average, color = "white", size = 1) +
            annotate("text", x = "26100 Kyoto", y = national_average,
                     label = "National average") +
            guides(fill = "none") +
            coord_flip() +
            labs(
                x = "", y = "annual expenditure per household (yen)"
            )
    })
    
    output$table <- DT::renderDataTable({
      area_ranks %>% 
        filter(city_e == input$select_city, ranks <= input$select_rank) %>% 
        select(year, ranks, cat01) %>% 
        arrange(desc(year), ranks, cat01) %>% 
        DT::datatable()
    })
  })  
}

# Run the application 
shinyApp(ui = ui, server = server)
