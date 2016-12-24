suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(ggplot2))

airline <- read.csv('C:/Users/Anirudh/Desktop/Udacity_Data_Viz_final/data/airline_delay.csv')

airline <- airline[, !(colnames(airline) %in% c("X"))]
colnames(airline)[which(names(airline) = "X.month")] <- "month"
colnames(airline)[which(names(airline) = "X.weather_ct")] <- "weather_ct"
colnames(airline)[which(names(airline) = "X.arr_delay")] <- "arr_delay"
colnames(airline)[which(names(airline) = "X.carrier_delay")] <- "carrier_delay"

#----------------------------------------------

#airline_delay <- airline %>%
# group_by(year , month ,  carrier_name ) %>%
#  summarise(total_delay = mean(arr_delay) ,
#            delay_carrier = mean(carrier_delay) ,
#            delay_weather = mean(weather_delay),
#            delay_nas = mean(nas_delay) ,
#            delay_security = mean(security_delay) ,
#            delay_late = mean(late_aircraft_delay)) %>%
#  ungroup(month,year)

#This part is covered!-------------------------

airline.temp <- na.omit(airline)

#airline_monthly_delay <- airline.temp %>%
#                          group_by(year , month) %>%
#                          summarise(delay_carrier = sum(carrier_delay) ,
#                          delay_weather = sum(weather_delay),
#                          delay_nas = sum(nas_delay) ,
#                          delay_security = sum(security_delay) ,
#                          delay_late = sum(late_aircraft_delay))

#write.csv(airline_monthly_delay , file = 'airline_monthly_delay.csv')

airline.temp$airport_name <- as.character(airline.temp$airport_name)

#x <- strsplit(airline.temp$airport_name , ",")

#strsplit(trimws(x[[1]][[2]]) , ":")[[1]]

getCity <- function(x)
{
  y = NA;
  temp = trimws(strsplit(x , ",")[[1]][[2]]);
  temp = (strsplit(temp , ":")[[1]][[1]]);
  return(temp);
}

airline.temp$state_name <- lapply(airline.temp$airport_name , getCity)

#data(state)

#state.name(airline_temp$state_name)

rm(getCity)

#Function to convert state FIPS codes to full state names or vice-versa [as factor levels for downstream grouping]:
#x is a vector of state abbreviations, or full state names.
#direction (name to code, or code to name) is determined automatically based on the supplied data
#depending on ultimate use of the returned set, users may wish to retain factor levels for all states (default) or only those states for which data was passed to the function. factor levels (faclevs) should be indicated ('all' or 'selected') so as to return the desired state factors for downstream use (default is to supply factor levels only for those states supplied in the dataset).

stateConversion <- function(x) {
  
  st.codes <- data.frame(state = as.factor(c("AL", "AK","AS", "AZ", "AR", "CA", "07", "CO", "CT", "DE", "DC", "FL", 
                                             "GA","14" ,  "HI", 
                                             "ID", "IL", "IN", "IA", "KS", "KY",  "LA", "ME", "MD", "MA", "MI",
                                             "MN", "MS",  "MO","MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC" , "ND", "OH",
                                             "OK", "OR", "PA", "43", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "52" ,
                                             "WA", "WV", "WI", "WY")),
                         full = as.factor(c("Alabama" , "Alaska","American Samoa","Arizona", "Arkansas", "California" ,"Canal Zone", "Colorado" ,
                                            "Connecticut", "Delaware" , "District of Columbia",  "Florida" , "Georgia" , "Guam",
                                            "Hawaii" , "Idaho" , "Illinois" , "Indiana" , "Iowa" ,   "Kansas" ,
                                            "Kentucky" , "Louisiana" , "Maine" , "Maryland" , "Massachusetts", 
                                            "Michigan" ,"Minnesota" ,"Mississippi" , "Missouri" ,  "Montana" , 
                                            "Nebraska" , "Nevada" , "New Hampshire" , "New Jersey" ,  "New Mexico" ,
                                            "New York" , "North Carolina" , "North Dakota", "Ohio" , "Oklahoma" ,
                                            "Oregon" , "Pennsylvania" , "Puerto Rico", "Rhode Island" , "South Carolina", "South Dakota" ,
                                            "Tennessee" , "Texas" , "Utah" ,"Vermont" ,  "Virginia", "Virgin Islands of US" ,
                                            "Washington" ,  "West Virginia" ,"Wisconsin", "Wyoming"))
  )
  
  st.x<-data.frame(state=x)
  #match source codes with codes from 'st.codes' local variable and use to return the full state name
  refac.x<-st.codes$full[match(st.x$state,st.codes$state)]
  #return the full state names in the same order in which they appeared in the original source
  return(refac.x[1])
  
}
full = as.factor(c("Alabama" , "Alaska","American Samoa","Arizona", "Arkansas", "California" ,"Canal Zone", "Colorado" ,
                   "Connecticut", "Delaware" , "District of Columbia",  "Florida" , "Georgia" , "Guam",
                   "Hawaii" , "Idaho" , "Illinois" , "Indiana" , "Iowa" ,   "Kansas" ,
                   "Kentucky" , "Louisiana" , "Maine" , "Maryland" , "Massachusetts", 
                   "Michigan" ,"Minnesota" ,"Mississippi" , "Missouri" ,  "Montana" , 
                   "Nebraska" , "Nevada" , "New Hampshire" , "New Jersey" ,  "New Mexico" ,
                   "New York" , "North Carolina" , "North Dakota", "Ohio" , "Oklahoma" ,
                   "Oregon" , "Pennsylvania" , "Puerto Rico", "Rhode Island" , "South Carolina", "South Dakota" ,
                   "Tennessee" , "Texas" , "Utah" ,"Vermont" ,  "Virginia", "Virgin Islands of US" ,
                   "Washington" ,  "West Virginia" ,"Wisconsin", "Wyoming"))

cities = data.frame(full)

rm(full)

airline.temp$full_state_name <- lapply(airline.temp$state_name , stateConversion)

airline.temp$full_state_name <- as.numeric(airline.temp$full_state_name)

return_state_name <- function(x)
{
  y = NA
  y = as.character(cities$full[x[1]])
  return(y)
}



airline.temp$full_state_name_alpha <- lapply(airline.temp$full_state_name , return_state_name)

airline.temp$full_state_name_alpha <- trimws(airline.temp$full_state_name_alpha)

rm(stateConversion)
#airline.temp$full_state_name <- lapply(airline.temp$full_state_name , conversion)

#rm(conversion)

if(false)
{
convertToCode <- function(x)
{
  y = "US"
  
  if(x == 1)
  {
  y = paste(y , '01' ,sep = "")
  }
  if(x == 2)
  {
    y = paste(y , '02',sep = "")
  }
  if(x == 3)
  {
    y = paste(y ,'03',sep = "")
  }
  else if(x == 4)
  {
    y = paste(y , '04',sep = "")
  }
  else if(x == 5)
  {
    y = paste(y , '05',sep = "")
  }
  else if(x == 6)
  {
    y = paste(y , '06',sep = "")
  }
  else if(x == 7)
  {
    y = paste(y , '07',sep = "")
  }
  else if(x == 8)
  {
    y = paste(y , '08',sep = "")
  }
  else if(x == 9)
  {
    y = paste(y , '09',sep = "")
  }
  else
  {
    y = paste(y , as.character(x),sep = "")
  }
  return(y)
}

airline.temp$full_state_name <- as.numeric(airline.temp$full_state_name)

airline.temp$full_state_name_temp <- convertToCode(airline.temp$full_state_name)

rm(convertToCode)

change <- function(x)
{
  y = x
  if(x=='US1')
  {
    y = 'US01'
  }
  if(x == 'US2')
  {
    y = 'US02'
  }
  if(x == 'US3')
  {
    y = 'US03'
  }
  if(x == 'US4')
  {
    y = 'US04'
  }
  if(x == 'US5')
  {
    y = 'US05'
  }
  if(x == 'US6')
  {
    y = 'US06'
  }
  if(x == 'US7')
  {
    y = 'US07'
  }
  if(x == 'US8')
  {
    y = 'US08'
  }
  if(x == 'US9')
  {
    y = 'US09'
  }
  return(y)
}

airline.temp$full_state_name_temp <- lapply(airline.temp$full_state_name_temp,change)

airline.temp$state_name <- as.character(airline.temp$state_name)

airline.temp$full_state_name <- as.character(airline.temp$full_state_name_temp)
}

airline.state.wise.delay <- airline.temp %>%
                            group_by(full_state_name_alpha) %>%
                            summarise(delay = mean(X.arr_delay) ,
                                      flight_numbers = mean(arr_flights))

airline.state.wise.delay$flight_wise_delay <- airline.state.wise.delay$delay / airline.state.wise.delay$flight_numbers



write.csv(airline.state.wise.delay ,
          file = 'C:/Users/Anirudh/Desktop/Udacity_Data_Viz_final/data/state_wise_delay_non_geo.csv')
