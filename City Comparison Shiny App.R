########################################################

# App to visualize differences in dependent variables
# between forest fragments in Newark, DE and Raleigh, NC

# Drew Hunter, North Carolina State University

# February-April 2019

########################################################


##########################
# DATA PREPARATION FOR APP
##########################

# Bring data sets in R

setwd('~/Desktop/School/Grad School/R/ST542')
data.nc <- read.csv('ST542NC.csv')
data.de <- read.csv('ST542DE.csv')
data.imperv <- read.csv('imperv.csv')


# Renaming columns for simplicity

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


########################################
# BEGIN CODE FOR SHINY APP UI AND SERVER
########################################

library(shiny)

ui <- fluidPage(
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

server <- function(input, output, session) {
  
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

shinyApp(ui, server)






