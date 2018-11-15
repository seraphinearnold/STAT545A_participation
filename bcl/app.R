
library(shiny)

bcl <- read.csv("/Users/Seraphine/Documents/stat545/New participation/STAT545A_participation/bcl/bcl-data.csv/bcl-data.csv", stringsAsFactors = FALSE)


# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("BC Liquor price app", 
             windowTitle = "BCL app"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Select your desired price range.",
                  min = 0, max = 100, value = c(15, 30), pre="$"),
      radioButtons("typeInput", "Select your alcohol baverage",
                   choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                   selected = "WINE")
    ),
    mainPanel(
      #ggplot2::qplot(bcl$Price)) #we cannot put not html code in there, we need to put that to the server function
      plotOutput("price_hist"), # in quotation marks the identify id
      tableOutput("bcl_data")
    )
  )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
  observe(print(input$priceInput))
  bcl_filtered <- reactive ({
    bcl %>% 
      filter(Price < input$priceInput[2],
             Price > input$priceInput[1],
             Type == input$TypeInput)
  })
  
  output$price_hist <- renderPlot({
    bcl_filtered() %>% 
      ggplot2(aes(Price)) +
      geom_histogram()
  })
  output$bcl_data <- renderTable({
  bcl_filtered()
})
}


# Run the application 
shinyApp(ui = ui, server = server)

