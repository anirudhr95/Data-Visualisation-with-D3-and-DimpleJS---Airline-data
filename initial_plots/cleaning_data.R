suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(ggplot2))

airline <- read.csv('airline_delay.csv')
airline <- airline[, !(colnames(airline) %in% c("X"))]
colnames(airline)[which(names(airline) == "X.month")] <- "month"
colnames(airline)[which(names(airline) == "X.weather_ct")] <- "weather_ct"
colnames(airline)[which(names(airline) == "X.arr_delay")] <- "arr_delay"
colnames(airline)[which(names(airline) == "X.carrier_delay")] <- "carrier_delay"

airline_delay <- airline %>%
                 group_by(year , month ,  carrier_name ) %>%
                 summarise(total_delay = mean(arr_delay) ,
                           delay_carrier = mean(carrier_delay) ,
                           delay_weather = mean(weather_delay),
                           delay_nas = mean(nas_delay) ,
                           delay_security = mean(security_delay) ,
                           delay_late = mean(late_aircraft_delay)) %>%
                 ungroup(month,year)

airline_delay <- na.omit(airline_delay)

airline_delay$total_delay = round(airline_delay$aircraft_delay , 0)
airline_delay$delay_carrier = round(airline_delay$delay_carrier , 0)
airline_delay$delay_weather = round(airline_delay$delay_weather , 0)
airline_delay$delay_nas = round(airline_delay$delay_nas , 0)
airline_delay$delay_security = round(airline_delay$delay_security , 0)
airline_delay$delay_late = round(airline_delay$delay_late , 0)


write.csv(airline_delay,  file  = 'aircraft_delay.csv' )

airline_delay_year <- airline %>%
                      group_by(year) %>%
                      summarise(total_delay = n())

airline_delay_year$year <- as.character(airline_delay_year$year)
airline_delay_year$total_delay <- as.numeric(airline_delay_year$total_delay)
write.csv(airline_delay_year , file = 'airline_delay_yearwise.csv')

  
rm(airline_delay)
