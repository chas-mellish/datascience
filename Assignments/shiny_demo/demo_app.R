#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
theme_set(theme_minimal())


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Sepal Length Histogram"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
      ## Content in the sidebarPanel
      sliderInput("user_bins",             ### The value will be stored in input$user_bins
                  "Number of bins:",  ### Text prompt for user
                  min = 1,            ### Minimum value allowed from user
                  max = 50,           ### Maximum value allowed from user
                  value = 30),        ### Default value
     
       ### input$which_species
      selectInput(inputId = "which_species",
                  label = "Which species would you like to view?",
                  choices = c("setosa", "virginica", "versicolor"),
                  selected = "setosa"),
      
      radioButtons("make_it_facet",
                   "Should we facet SECOND PLOT by species?",
                   choices = c("No", "Yes"),
                   selected = "No")
      
    ), # HAS A COMMA since next code line is a function THIS CLOSES SIDEBARPANEL
    
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      plotOutput("secondPlot", height = "300px") # DOES NOT HAVE A COMMA since next code line is )  <- closing paranthesis
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  ## NOT ALLOWEED TO HAVE REGULAR R CODE
  ## subset_iris <- filter(iris, Species == input$which_species)
  
  ## REACTIVE CONSTRUCTS. use as subset_iris
  subset_iris <- reactive({
    iris %>%
      filter(Species == input$which_species)
  })
  
  
  output$distPlot <- renderPlot({
    subset_iris() %>% ## Use reactive variable
      ggplot(aes(x = Sepal.Length)) + 
      geom_histogram(bins = input$user_bins, ## Aha!!!! 
                     fill = "hotpink", 
                     color = "navyblue",
                     alpha = 0.6) + 
      labs(x = "Sepal Length (cm)", y = "Count")
  })
  
  output$secondPlot <- renderPlot({
    iris %>%
      ggplot(aes(x = Sepal.Length)) + 
      geom_histogram(bins = input$user_bins, ## Aha!!!! 
                     fill = "palegoldenrod", 
                     color = "forestgreen",
                     alpha = 0.6) + 
      labs(x = "Sepal Length (cm)", y = "Count") -> second_hist
    
    if (input$make_it_facet == "Yes"){
      second_hist <- second_hist + facet_wrap(~Species)
    }
    second_hist
  })
}







# Run the application 
shinyApp(ui = ui, server = server)