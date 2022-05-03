## ui.R ##
library(shiny)


navbarPage(title = "QMSS",
           
           theme = bs_theme(bootswatch = "lux"),
           tabPanel(title = "Global Vaccination",
                    htmlTemplate("www/globe_vaccination.html"),
           ),
           tabPanel(title = "Country Rollouts",fluidPage(
               htmlTemplate("www/graph2.html")
           )
           ),
           tabPanel(use_googlefont("Cardo"),
                    title = "Country Advantage",
                    fluidPage(
                    fluidRow(
                      column(2,
                             ''),
                      column(8,
                             h1("Do some countries have an advantage?"),
                             p("Yes, generally richer and more developed countries have better health care infrastructure to manufacture acquire and administer doses. Hover the bubble to highlight countries.",style = "margin-top:12px; margin-bottom:8px;"),
                      ),
                      column(2,
                             '')
                      ),
                    fluidRow(
                      column(12,
                             div(plotlyOutput("graph3"), align = "center")
                             )
                    )
           )
           ),
           tabPanel(
             title = "Country's Vulnerability",
             fluidPage(
               use_googlefont("Cardo"),
               fluidRow(
                 column(2,
                        ''),
                 column(8,
                        h1("More about impacts of Covid-19"),
                        p("Countries have different exposure risk to COVID-19.It's a matter of vulnerability among nations facing limited margins of adaptation.
Select from the drop-down list below to see detailed information for each country.")
                 ),
                 column(2,
                        ''),
                 style = "margin-bottom:8px"
               ),
               fluidRow(
                column(1,
                       ''),
                 column(10,
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
               ),
               column(1,
                      '')
               )
             )
           )
           ),
           inverse = T
)
