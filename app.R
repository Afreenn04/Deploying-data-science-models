#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(caret)
model5 = readRDS("model5.rds")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Predicting Cause of escapes"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            
            selectInput("Season", "Select season", c("Autumn", "Spring", "Summer", "Winter")),
            sliderInput("Number","Enter Number:",min = 1,max = 3400000,value = 1000),
            sliderInput("Cu","Enter Cu:",min = -5,max = 10,value = 1),
            sliderInput("N","Enter N:",min = -110,max = 700,value = 50),
            sliderInput("Org","Enter Org:",min = 60,max = 1100,value = 50)
            #selectInput("Species", "Select Species", c("Other", "Salmon", "Salmon.Brood", "Salmon.Fresh"))
            #selectInput("region", "Select region", c("northeast", "northwest", "southwest", "southeast"))
        ),

        # Show a plot of the generated distribution
        mainPanel(
        ## static content uses HTML format via "tags" function
           tags$h3("Prediction for Cause is:"), ## tags$h3 is header size level 3
           
           tags$p("Prediction for charges based on the LR model is:"), # tags$p creates a paragraph of text
           textOutput("modelCalcLR"),
           
           tags$br(), # tags$br creates line break
           
          # tags$p("Prediction for charges based on the RF model is:"), # tags$p creates a paragraph of text
           textOutput("modelCalcRF"),
           
           tags$br(), # tags$br creates line break
           tags$br(), # tags$br creates line break
           tags$a(href = "https://shiny.rstudio.com/", "See R Shiny docs for more") # tags$a creates a hyperlink
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$modelCalcLR <- renderText({
       
        Season = input$Season
        Number = input$Number
        Cu = input$Cu
        N = input$N
        Org = input$Org
        newData= data.frame(Season = Season, Number = Number, Cu = Cu, N = N, Org = Org)

        prediction1 = predict(model5, newData)
    })
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
