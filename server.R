library(shiny)

shinyServer(function(input,output) {
  output$CityComp <- renderPlot({
    plot(data.comb$city, data.comb[,input$field], 
         main=paste('Box Plot Comparison of', input$field, 'by City', sep=' '))
  })
  
  output$NCSummary <- renderPrint({
    summary(data.nc[, input$field])
  })
  
  output$DESummary <- renderPrint({
    summary(data.de[, input$field])
  })
}