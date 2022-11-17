#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(bslib)

# Define UI for application that draws a histogram
ui <- fluidPage(
  theme = bs_theme(
    bootswatch = "darkly"),
  titlePanel("Foreign Students by Nationality"),
  
  # Create a new Row in the UI for selectInputs
  fluidRow(
    column(3,
           selectInput("Üniversite Adı",
                       "Üniversite Adı",
                       c("All",
                         unique(as.character(foreign_students$`Üniversite Adı`))), width="450px")
    ),
    column(3,
           selectInput("Üniversite Türü",
                       "Üniversite Türü",
                       c("All",
                         unique(as.character(foreign_students$`Üniversite Türü`))), width="450px")
    ),
    column(3,
           selectInput("İl Adı",
                       "İl Adı",
                       c("All",
                         sort(unique(as.character(foreign_students$`İl Adı`)))), width="450px")
    ),
    
    column(3,
           selectInput("Uyruk",
                       "Uyruk",
                       c("All",
                         sort(unique(as.character(foreign_students$Uyruk)))), width="450px")
    ),
    
  ),
  # Create a new row for the table.
  column(12, DT::dataTableOutput("table"))
  
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # Filter data based on selections
  output$table <- DT::renderDataTable(DT::datatable({
    data <- foreign_students
    if (input$`Üniversite Adı` != "All") {
      data <- data[data$`Üniversite Adı` == input$`Üniversite Adı`,]
    }
    if (input$`İl Adı` != "All") {
      data <- data[data$`İl Adı` == input$`İl Adı`,]
    }
    if (input$`Üniversite Türü` != "All") {
      data <- data[data$`Üniversite Türü` == input$`Üniversite Türü`,]
    }
    if (input$Uyruk != "All") {
      data <- data[data$Uyruk == input$Uyruk,]
    }
    
    data
  }, options = list(dom = 't')))
  
}
# Run the application 
shinyApp(ui = ui, server = server)
