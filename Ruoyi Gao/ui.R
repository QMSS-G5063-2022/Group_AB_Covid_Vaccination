#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

ui <- fluidPage(
    
    titlePanel("Covid-19 country level information"),
    
    sidebarLayout(
        sidebarPanel(
            selectInput("country",
                        "Select country:",
                        choices = country$location,
                        selected = "United States")
            
        ),
        
        mainPanel(
            plotlyOutput("infection"),
            plotlyOutput("death"),
            plotlyOutput("vaccine")
        )
    )
)