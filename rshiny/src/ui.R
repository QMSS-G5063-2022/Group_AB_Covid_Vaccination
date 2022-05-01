## ui.R ##
library(shiny)



navbarPage(title = "QMSS",
           theme = bs_theme(bootswatch = "lux"),
           tabPanel(title = "Global Tracker",
                    htmlTemplate("www/globe_vaccination.html")
           ),
           tabPanel(title = "Country Rollout",
                    htmlTemplate("www/graph2.html")
                    ),
           inverse = T
)

