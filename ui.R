
library(shiny)
airlines <- c("AA" ,"AS" ,"B6" ,"DL" ,"EV" ,"F9" ,"HA" ,"NK" ,"OO" ,"UA" ,"VX" ,"WN")

fluidPage(
  
  titlePanel("TBD"),
  
  sidebarLayout(
    # tabsetPanel(
    #   "tab1",
      sidebarPanel(
        selectInput("DepAP", "Departure Airport", sort(airports$airport_name)),
        selectInput("ArrAP", "Arrival Airport", sort(airports$airport_name)),
        selectInput("Var", "Metric", c("elapsed", "fares", "delay")),
        submitButton()
      ),
      mainPanel(
        # "Please be patient while the decision tree results generate",
        # verbatimTextOutput("myData")
        plotOutput('myPlot')
        # verbatimTextOutput('myPlot')
      )
    # )
  )
)