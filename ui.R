
library(shiny)
library(emojifont)

airlines <- c("AA" ,"AS" ,"B6" ,"DL" ,"EV" ,"F9" ,"HA" ,"NK" ,"OO" ,"UA" ,"VX" ,"WN")

fluidPage(
  
  titlePanel("Flight Compare by sANNjeev.rmd"),
  
  sidebarLayout(
    # tabsetPanel(
    #   "tab1",
      sidebarPanel(
        selectInput("DepAP", "Departure Airport", sort(airports$airport_name)),
        selectInput("ArrAP", "Arrival Airport", sort(airports$airport_name)),
        selectInput("Var", "Metric", c("Elapsed", "Fares", "Delay")),
        submitButton()
      ),
      mainPanel(
        "If this panel is empty, that means the data is loading. Thank you for your patience!",
        img(src='emoji.png', align = "center"),
        # "Please be patient while the decision tree results generate",
        # verbatimTextOutput("myData")
        plotOutput('myPlot')
        # verbatimTextOutput('myPlot')
      )
    # )
  )
)