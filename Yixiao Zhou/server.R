graph3_data <- read_csv('www/data/graph3.csv')

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
            sizes = c(min(graph3_data$size)+2, max(graph3_data$size)),
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
                          tickfont = list(family='Cardo',size = 14),
                          ticklabelposition ="inside top",
                          categoryorder = "array",
                          categoryarray = c("Low income", 
                                            "Lower middle income", 
                                            "Upper middle income",
                                            "High income")),
             showlegend = FALSE)
  })
}