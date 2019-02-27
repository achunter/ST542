


# Run app

library(shiny)
fluidPage(
  titlePanel('Forest Fragment Visualization App'),
  sidebarLayout(
    sidebarPanel(
      selectInput('field', 'Select variable of interest:', 
                  choices=names(data.comb[,c(2:12,14)]))
    ),
    
    mainPanel(
      h5('Newark, DE - Summary Statistics'),
      verbatimTextOutput('DESummary'),
      
      h5('Raleigh, NC - Summary Statistics'),
      verbatimTextOutput('NCSummary'),
      
      plotOutput('CityComp')
    )
  )
)