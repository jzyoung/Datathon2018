library(shiny)

library(dplyr)
library(ggplot2)

data <- read.csv('Ross_Datathon_Files/PRIMARY_flight_traffic.csv')

fares <- read.csv('Ross_Datathon_Files/fares.csv')

# Clean Data
major <- c("UA", "AA", "DL", "US", "AS")
budget <- c("F9", "B6", "NK", "WN")
regional <- c("OO", "EV", "HA", "MQ", "VX")
fares$airline_type <- as.factor(ifelse(fares$airline_id %in% major, "Major", 
                                ifelse(fares$airline_id %in% budget, "Budget", 
                                ifelse(fares$airline_id %in% regional, "Regional", NA))))

airlines <- c("AA" ,"AS" ,"B6" ,"DL" ,"EV" ,"F9" ,"HA" ,"NK" ,"OO" ,"UA" ,"VX" ,"WN")
fares <- fares[fares$airline_id %in% airlines, ]
# summary(fares$airline_type)

costs <- (as.numeric(substring(colnames(fares)[6:255], 2)) + 5) 
fares$avgPrice <- apply(fares[,6:255],1, function(x){sum(x*costs)/sum(x)})

function(input, output) {

  output$myPlot <- renderPlot({
    dep <- as.character(airports[airports$airport_name==input$DepAP,]$airport_id)
    dest <- as.character(airports[airports$airport_name==input$ArrAP,]$airport_id)
    
    if(input$Var == "elapsed"){
      p <- filter(data, origin_airport == dep, destination_airport == dest) %>%
        group_by(airline_id) %>%
        summarize(elapsed = mean(actual_elapsed, na.rm = T))

      baseplot <- ggplot(data=p, aes(x=airline_id, y=elapsed))

      baseplot + geom_bar(stat = "identity", fill = "#bc20b7")
    }

    else if(input$Var == "fares"){
      #fares - order and color

      p <- filter(fares, origin_airport == dep, destination_airport == dest) %>%
        group_by(airline_id) %>%
        summarize(avgFare = mean(avgPrice, na.rm = T))

      baseplot2 <- ggplot(data = p, aes(x = airline_id, y = avgFare))
      baseplot2 + geom_bar(stat = "identity", fill = "#28c122")
    }

    else if(input$Var == "delay"){
      data$airline_delay <- ifelse(is.na(data$airline_delay), 0, data$airline_delay)
      data$weather_delay <- ifelse(is.na(data$weather_delay), 0, data$weather_delay)
      data$air_system_delay <- ifelse(is.na(data$air_system_delay), 0, data$air_system_delay)
      data$security_delay <- ifelse(is.na(data$security_delay), 0, data$security_delay)
      data$aircraft_delay <- ifelse(is.na(data$aircraft_delay), 0, data$aircraft_delay)
      data$total_delay <- data$airline_delay + data$weather_delay + data$air_system_delay + data$security_delay + data$aircraft_delay

      p <- filter(data, origin_airport == dep, destination_airport == dest)%>%
        group_by(airline_id) %>%
        summarize(average_delay = mean(total_delay, na.rm = T))

      baseplot <- ggplot(data=p, aes(x=airline_id, y=average_delay))

      baseplot + geom_bar(stat = "identity", fill = "#d64d3e") 
    }





  }) 
}

