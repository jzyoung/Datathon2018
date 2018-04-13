library(dplyr)
library(magrittr)

# Import Data
data <- read.csv('PRIMARY_flight_traffic.csv')

# Clean Data
data$diverted %<>% as.factor()
data$cancelled %<>% as.factor()