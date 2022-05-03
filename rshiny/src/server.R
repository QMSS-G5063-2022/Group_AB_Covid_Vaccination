server<-function(input, output, session) {
  output$graph3 <- renderPlotly({
    plot_ly(graph3_data, 
            x = ~first, 
            y = ~Income, 
            type = 'scatter', 
            mode = 'markers', 
            size = ~size,  
            width = 1200, 
            height = 560, 
            color = ~Income, 
            colors = 'Paired',
            sizes = c(min(graph3_data$size)+2, max(graph3_data$size)-2),
            marker = list(opacity = 0.5, sizemode = 'diameter'),
            hoverinfo = 'text',
            text = ~paste('Country:', country, '<br>Population (M):', pop,'<br>First dose percentage:', per)) %>% 
      layout(xaxis = list(autotick = F, 
                          dtick = 0.2,
                          showgrid = TRUE,
                          title = 'Percent of population given at least one dose of vaccination',
                          titlefont = list(family='Cardo'),
                          tickfont = list(family='Cardo'),
                          ticktext = list("0%", "20%", "40%", "60%", "80%", "100%","120%"), 
                          tickvals = list(0,0.2,0.4,0.6,0.8,1.0,1.2),
                          tickmode = "array",
                          zeroline=FALSE),
             yaxis = list(showgrid = FALSE,title = '',
                          tickfont = list(family='Cardo',weight='normal',size = 14),
                          ticklabelposition ="inside top",
                          categoryorder = "array",
                          categoryarray = c("Low income", 
                                            "Lower middle income", 
                                            "Upper middle income",
                                            "High income")),
             showlegend = FALSE)
  })
  d <- reactive({input$country})
  l <- reactive({subset(graph4_data,location==d())})
  
  output$infection <- renderPlotly({
    g<-ggplot(l(),aes(x=date,y=infection_rate,text=paste("Country:",location,"\nDate: ",date,"\nInfection rate: ",infection_rate)))+
      geom_line(aes(group = 1),color = "#9fd09a", size = 1)+
      labs(x="Date (2022)",y="")+
      scale_x_date(date_labels = "%b %d",date_breaks = "4 weeks")+
      scale_y_continuous(labels = scales::percent_format(accuracy = 0.01))+
      theme_minimal()+
      theme(axis.text.x=element_text(hjust=1,size=10,family="Cardo"),
            axis.text.y=element_text(size=10, family="Cardo"),
            axis.title.x=element_text(size=12, family="Cardo", hjust=0.5))
    
    fig1<-ggplotly(g,tooltip = "text")
    fig1
    
  })
  
  output$death <-renderPlotly({
    p<-ggplot(l(),aes(x=date,y=death_rate,text=paste("Country:",location,"\nDate: ",date,"\nDeath rate: ",death_rate)))+
      geom_line(aes(group = 1),color = "#82A5C0", size = 1)+
      labs(x="Date (2022)",y="")+
      scale_x_date(date_labels = "%b %d",date_breaks = "4 weeks")+
      scale_y_continuous(labels = scales::percent_format(accuracy = 0.001))+
      theme_minimal()+
      theme(axis.text.x=element_text(hjust=1,size=10,family="Cardo"),
            axis.text.y=element_text(size=10, family="Cardo"),
            axis.title.x=element_text(size=12, family="Cardo", hjust=0.5)) 
    options(scipen = 999)
    
    fig2<-ggplotly(p,tooltip="text")
    fig2
    
  })
  
  output$vaccine <-renderPlotly({
    v<-ggplot(l(),aes(x=date,y=vaccines_offered,text=paste(
      "Country:",location,"\nDate: ",date,"\nTotal Vaccinations offered: ",vaccines_offered)))+
      geom_line(aes(group = 1),color = "#fce587", size = 1)+
      labs(x="Date (2022)",y="")+
      scale_x_date(date_labels = "%b %d",date_breaks = "4 weeks")+
      scale_y_continuous(labels = scales::unit_format(unit = "M", scale = 1e-6))+
      theme_minimal()+
      theme(axis.text.x=element_text(hjust=1,size=10,family="Cardo"),
            axis.text.y=element_text(size=10, family="Cardo"),
            axis.title.x=element_text(size=12, family="Cardo", hjust=0.5)) 
    fig3<-ggplotly(v,tooltip="text")
    fig3
    
  })
}