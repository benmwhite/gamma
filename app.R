library(shiny)
library(ggplot2)

ui <- fluidPage(
   titlePanel("Visualizing the Gamma Distribution"),
   sidebarLayout(
      sidebarPanel(
         #alpha and beta parameters
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
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

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

