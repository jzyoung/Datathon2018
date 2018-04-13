library(shiny)

library(dplyr)
library(ggplot2)

data <- read.csv('Ross_Datathon_Files/PRIMARY_flight_traffic.csv')


function(input, output) {

  output$myPlot <- renderPlot({
    p <- filter(data, 
            origin_airport == as.character(airports[airports$airport_name==input$DepAP,]$airport_id), 
            destination_airport == as.character(airports[airports$airport_name==input$ArrAP,]$airport_id)) %>%
          group_by(airline_id) %>%
          summarize(taxiout = mean(taxi_out, na.rm = T))

    baseplot <- ggplot(data=p, aes(x=airline_id, y=taxiout))
    baseplot + geom_bar(stat = "identity")
  })  

}

