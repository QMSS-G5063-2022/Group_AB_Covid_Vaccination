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
                             p(style = 'margin-top:12px; margin-bottom:8px;',
                               "Yes, generally richer and more developed countries 
                               have better health care infrastructure to manufacture 
                               acquire and administer doses. For countries that are in the high income category, all the countries hit at least 50% of population given at least one does of vaccination.
                               Hover the bubble to highlight countries."),
                      ),
                      column(2,
                             '')
                      ),
                    fluidRow(
                      column(12,
                             div(plotlyOutput("graph3"), align = "center")
                             )
                    ),
                    fluidRow(
                      column(2,
                             ''),
                      column(8,
                             tags$div(
                               HTML("<div style = 'font-size: 0.8em; text-align: left;padding-top: 185px; margin-bottom: 10px;'>
                               Note: The bubble's size indicates the population of country. 
                               The bigger the bubble is, the more population a country has. 
                               The latest first dose and population figures are from 
                               <a style = 'background: #e2e2e2; text-decoration: none; color: #821122;' href='https://ourworldindata.org/covid-vaccinations'>Our World in Data</a>. 
                               Income classification is from 
                               <a style = 'background: #e2e2e2; text-decoration: none; color: #821122;' href='https://datahelpdesk.worldbank.org/knowledgebase/articles/378834-how-does-the-world-bank-classify-countries'>The World Bank</a>.</div>")
                             )
                      ),
                      column(2,
                             '')
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
                        p("Countries have different exposure risk to COVID-19.
                        It's a matter of vulnerability among nations facing limited margins of adaptation. 
                        Among countries that report confirmed deaths and infection cases, Faeroe Islands, Denmark, and Andorra are more vulnerable than others. 
                        Select from the drop-down list below to see detailed information for each country.")
                 ),
                 column(2,
                        ''),
                 style = "margin-bottom:8px;margin-bottom:8px"
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
                     tabPanel("Total Infections Rate", plotlyOutput("infection",height = 550)), 
                     tabPanel("Total Death Rate", plotlyOutput("death",height = 550)), 
                     tabPanel("Total Vaccination offered", plotlyOutput("vaccine",height = 550))
                 )
               )
               ),
               column(1,
                      '')
               )
             ),
             fluidRow(
               column(2,
                      ''),
               column(8,
                      tags$div(
                        HTML("<div style = 'font-size: 0.8em; text-align: left;padding-top: 10px;'>
                               Note: The number of confirmed infection cases and deaths from COVID-19 are from 
                               <a style = 'background: #e2e2e2; text-decoration: none; color: #821122;' href='https://ourworldindata.org/covid-vaccinations'>Our World in Data</a>.")
                      )
               ),
               column(2,
                      '')
             )
           )
           ),
           inverse = T
)
