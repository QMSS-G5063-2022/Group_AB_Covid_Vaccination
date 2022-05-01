## ui.R ##
library(shiny)

navbarPage(title = "QMSS",
           
           theme = bs_theme(bootswatch = "lux"),
           tabPanel(title = "Global Vaccination",
                    htmlTemplate("www/globe_vaccination.html")
           ),
           tabPanel(title = "Country Rollout",
                    htmlTemplate("www/graph2.html")
           ),
           tabPanel(title = "Country Advantage",
                    fluidRow(
                      column(12,
                             h1("Do some countries have an advantage?",align = "center"),
                             div(plotlyOutput("graph3"), align = "center")
                      ),
                      )
           ),
           inverse = T
)

