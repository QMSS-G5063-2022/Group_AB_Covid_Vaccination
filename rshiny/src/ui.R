## ui.R ##
library(shiny)

navbarPage(title = "QMSS",
           
           theme = bs_theme(bootswatch = "lux"),
           tabPanel(title = "Global Vaccination",
                    htmlTemplate("www/globe_vaccination.html")
           ),
           tabPanel(title = "Country Rollouts",
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
           tabPanel(
             title = "Country's Vulnerability",
             fluidPage(
               titlePanel(h1("More about impacts of Covid-19",
                             style={'margin-bottom: 20px'})),
               sidebarLayout(
                 sidebarPanel(
                   selectInput("country",
                               "Select country:",
                               choices = graph4_country$location,
                               selected = "United States")
                   
                 ),
                 mainPanel(
                   tabsetPanel(
                     tabPanel("Total Infections Rate", plotlyOutput("infection",height = 500)), 
                     tabPanel("Total Death Rate", plotlyOutput("death",height = 500)), 
                     tabPanel("Total Vaccination offered", plotlyOutput("vaccine",height = 500))
                 )
               )
             )
           )
           ),
           inverse = T
)
