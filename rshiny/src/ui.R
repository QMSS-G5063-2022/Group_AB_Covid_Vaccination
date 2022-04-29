## ui.R ##
library(shiny)



navbarPage(title = "QMSS",
           theme = bs_theme(bootswatch = "lux"),
           tabPanel(title = "Vaccination Tracker",
                    htmlTemplate("www/globe_vaccination.html")
                    ),
           inverse = T
)

