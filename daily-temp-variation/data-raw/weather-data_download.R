library("tidyverse")

locations <- c(
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/cambornedata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/hurndata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/eastbournedata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/chivenordata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/yeoviltondata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/southamptondata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/manstondata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/heathrowdata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/cardiffdata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/oxforddata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/aberporthdata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/cwmystwythdata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/cambridgedata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/lowestoftdata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/shawburydata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/suttonboningtondata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/waddingtondata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/durhamdata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/newtonriggdata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/armaghdata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/ballypatrickdata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/eskdalemuirdata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/paisleydata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/leucharsdata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/dunstaffnagedata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/tireedata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/braemardata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/nairndata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/wickairportdata.txt",
  "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/stornowaydata.txt"
  )
locations <- unique(locations)




add_weather_data <- function(existing.data, data.url) {
  the_location <- gsub(".*stationdata/|data.txt", "", data.url)
  
  print(the_location)
  
  data <- read_table(file = data.url,
                     skip = 5,
                     col_names = TRUE)
  
  if(is.null(existing.data)) {
    data %>%
      slice(-1) %>%
      mutate(
        sun = gsub("\\**", "", sun),
        sun = gsub("Provisional", "", sun),
        sun = gsub("---", NA, sun),
        sun = as.numeric(sun)
      ) %>%
      mutate_if(is.character, as.numeric) %>%
      mutate(location = the_location)
  } else {
    if(all(
      colnames(data) %in% c("yyyy", "mm", "tmax", "tmin", "af", "rain", "sun", "location")
    )) {
      data %>%
        slice(-1) %>%
        mutate(
          sun = gsub("\\**", "", sun),
          sun = gsub("Provisional", "", sun),
          sun = gsub("---", NA, sun),
          sun = as.numeric(sun)
        ) %>%
        mutate_if(is.character, as.numeric) %>%
        mutate(location = the_location) %>%
        full_join(existing.data)
    } else {
      existing.data
    }
  }
}

british_weather <- add_weather_data(existing.data = NULL, locations[[1]])

suppressMessages(invisible(lapply(locations[2:length(locations)],
       function(x){
         british_weather <<- add_weather_data(british_weather, x)
       })))

## =========== Add in local info

location_info <- read_csv("data-raw/locations-info.csv")
library("plyr")

british_weather <- british_weather %>%
  mutate(region = mapvalues(
    location,
    from = location_info$location,
    to = location_info$region
  ),
  seaside = mapvalues(
    location,
    from = location_info$location,
    to = location_info$seaside
  ))

british_weather <- british_weather %>%
  mutate(mm = mapvalues(
    mm,
    from = 1:12,
    to = c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
  )) %>%
  mutate(mm = factor(mm, c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"))) %>%
  mutate(seaside = as.logical(seaside))
  
save(british_weather, file = "data/british_weather.rdata")


