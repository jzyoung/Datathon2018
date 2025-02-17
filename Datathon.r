library(dplyr)
library(magrittr)

# Import Main Data
data <- read.csv('PRIMARY_flight_traffic.csv')

# Clean Data
data$diverted %<>% as.factor()
data$cancelled %<>% as.factor()

# Fare data 
fares <- read.csv('fares.csv')

costs <- (as.numeric(substring(colnames(fares)[6:255], 2)) + 5) 
fares$avgPrice <- apply(fares[,6:255],1, function(x){sum(x*costs)/sum(x)})
# head(fares$avgPrice)


# Stock data
stock <- read.csv('stock_prices.csv')

# Airport data
airport <- read.csv('airports.csv')

# Event data
events <- read.csv('events_US.csv')

# Weather data
weather <- read.csv('weather.csv')

611, 2232