#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

server <- function(input, output) {
    d <- reactive({input$country})
    l <- reactive({subset(data,location==d())})
    
    output$infection <- renderPlotly({
        g<-ggplot(l(),aes(x=date,y=infection_rate,text=paste("Country:",location,"\nDate: ",date,"\nInfection rate: ",infection_rate)))+
            geom_line(aes(group = 1),color = "#00AFBB", size = 1)+
            ggtitle("Total Infection Rate")+
            labs(x="Date (2022)",y="infection rate")+
            scale_x_date(date_labels = "%b %d",date_breaks = "4 weeks")+
            scale_y_continuous(labels = scales::percent_format(accuracy = 0.01))+
            theme_minimal()+
            theme(axis.text.x=element_text(angle=45, hjust=1))
        
        fig1<-ggplotly(g,tooltip = "text")
        fig1
        
    })
    
    output$death <-renderPlotly({
        p<-ggplot(l(),aes(x=date,y=death_rate,text=paste("Country:",location,"\nDate: ",date,"\nDeath rate: ",death_rate)))+
            geom_line(aes(group = 1),color = "#E7B800", size = 1)+
            ggtitle("Total Death Rate")+
            labs(x="Date (2022)",y="Death rate")+
            scale_x_date(date_labels = "%b %d",date_breaks = "4 weeks")+
            scale_y_continuous(labels = scales::percent_format(accuracy = 0.001))+
            theme_minimal()+
            theme(axis.text.x=element_text(angle=45, hjust=1)) 
        options(scipen = 999)
        
        fig2<-ggplotly(p,tooltip="text")
        fig2
        
    })
    
    output$vaccine <-renderPlotly({
        v<-ggplot(l(),aes(x=date,y=vaccines_offered,text=paste(
            "Country:",location,"\nDate: ",date,"\nTotal Vaccinations offered: ",vaccines_offered)))+
            geom_line(aes(group = 1),color = "#FC4E07", size = 1)+
            ggtitle("Total Vaccination offered")+
            labs(x="Date (2022)",y="Total Vaccination offered")+
            scale_x_date(date_labels = "%b %d",date_breaks = "4 weeks")+
            scale_y_continuous(labels = unit_format(unit = "M", scale = 1e-6))+
            theme_minimal()+
            theme(axis.text.x=element_text(angle=45, hjust=1)) 
        fig3<-ggplotly(v,tooltip="text")
        fig3
        
    })
}