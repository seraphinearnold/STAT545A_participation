
library(shiny)

bcl <- read.csv("/Users/Seraphine/Documents/stat545/New participation/STAT545A_participation/bcl/bcl-data.csv/bcl-data.csv", stringsAsFactors = FALSE)


# Define UI for application that draws a histogram
ui <- fluidPage(
   "This is some text",
   "This is more text",
   tags$h1("Level 1 header, part 2"),
   HTML("<h1>Level 1 header, part 3</h1>"), # optional you can write in html code with the HTML function
   tags$b("This text is bold."),
   tags$div(
     "Some text followed by a break", 
     tags$br(),
     "Some text following a break"
   ),
   tags$blockquote("He who lives without a state must be a beast or a god.", cite = "Aristoteles"),
   a(href="https://www.google.ca", "Link to google"),
   
   titlePanel("BC Liquor price app", 
              windowTitle = "BCL app"),
   sidebarLayout(
     sidebarPanel("This text is in the sidebar."),
     mainPanel(
       #ggplot2::qplot(bcl$Price)) #we cannot put not html code in there, we need to put that to the server function
       plotOutput("price_hist"), # in quotation marks the identify id
       tableOutput("bcl_data")
    )
  )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
    output$price_hist <- renderPlot(ggplot2::qplot(bcl$Price))
    output$bcl_data <- renderTable(bcl)
}
   

# Run the application 
shinyApp(ui = ui, server = server)

