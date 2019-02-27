library(shiny)

shinyServer(function(input,output) {
  
  
  # Load data
  data.nc <- read.csv('ST542NC.csv')
  data.de <- read.csv('ST542DE.csv')
  #data.comb <- read.csv('ST542COMB.csv')
  
  names(data.nc) <- c('city', 'site', 'beetle_cnt', 'beetle_rich',
                      'sw_index', 'nn_rich', 'nat_rich', 'nonnative_perc',
                      'avg_nudds', 'avg_densio', 'litter', 'pH', 'K',
                      'dist_from_city', 'diameter')
  names(data.de) <- names(data.nc)
  
  # Combine Raleigh and Newark data into one data frame, then remove site variable
  
  data.comb <- rbind(data.nc, data.de)
  data.comb <- data.comb[,-2]
  
  
  # City and distance from city should be treated as factors, not numeric
  
  data.comb$city <- ifelse(data.comb$city == 1, 'Raleigh, NC','Newark, DE')
  data.comb$city <- as.factor(data.comb$city)
  
  data.comb$dist_from_city <- as.factor(data.comb$dist_from_city)
  
  
  
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