library(shiny)

shinyServer(function(input,output) {
  
  
  #####################################################
  # PRIOR TO RUNNING APP, PLEASE RUN THE FOLLOWING CODE
  #####################################################
  
  # Load data
  data.nc <- read.csv('ST542NC.csv')
  data.de <- read.csv('ST542DE.csv')
  #data.comb <- read.csv('ST542COMB.csv')
  
  
  #################################################
  # PRIOR TO RUNNING APP, PLEASE RUN THE ABOVE CODE
  #################################################
  
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
})