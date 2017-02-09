#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Visualizing the Gamma Distribution"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("alpha",
                     "Alpha (shape parameter):",
                     min = 0,
                     max = 10,
                     value = 4,
                     step = 0.01),
         sliderInput("beta",
                    "Beta (scale parameter)",
                    min = 0,
                    max = 10,
                    value = 4,
                    step = 0.01)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
     x <- seq(from = 0, to = 40, by = 0.05)
     y <- dgamma(x, shape = input$alpha, scale = input$beta)
     qplot(x, y, geom = "line", xlim = c(0, 40),
           ylim = c(0, 0.3), 
           main = paste("Gamma distribution, alpha =", 
                        as.character(input$alpha), " beta =",
                        as.character(input$beta)),
           xlab = "x", ylab = "f(x)") +
           theme_minimal() 
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

