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

get_latlong <- function(data.url){
  the_location <- gsub(".*stationdata/|data.txt", "", data.url)
  loc_data <- scan(file = data.url,
       n = 10, what = "character")
  lat_longs <- loc_data[!grepl("[a-z]|[A-Z]", loc_data)][1:2]
  tibble(
    location = the_location,
    lat = lat_longs[1],
    lng = lat_longs[2]
  )
}


invisible(the_locs <- lapply(locations, function(x)get_latlong(x)))

weather_station_location <- enframe(the_locs) %>%
  unnest() %>%
  filter(grepl(",", lng)) %>%
  mutate(lng = gsub(",","",lng)) %>%
  mutate(lat = as.numeric(lat),
         lng = as.numeric(lng)) %>%
  select(-name)

location_info <- read_csv("data-raw/locations-info.csv")

location_info <- weather_station_locs %>%
  full_join(location_info) %>%
  filter(!is.na(region))

location_info[location_info$location == "ballypatrick", ] <- c("ballypatrick", 55.181, -6.153, "Northern Ireland", TRUE)

location_info <- location_info %>%
  mutate(lat = as.numeric(lat),
         lng = as.numeric(lng))


write_csv(location_info, path = "data/locations.csv")
