install.packages("httr")

library(httr)

test_url <- 'https://iss.moex.com/iss/securities/EUR_RUB__TOM.jsonp?iss.only=boards&iss.meta=off&iss.json=extended&_=1571122248546'
response <- GET(test_url)

response&$status_code
http_status(response)
http_error(response)
content(response)
response_body <- content(response, as='text', type='application/json')
json_parsed <- fromJSON(response_body)

install.packages('rjson')
library(rjson)

?GET

response <- GET(modify_url(test_url, params = list(
  iss.only ='boards',
  iss.json = 'extended',
  "_" = 1571122248546
)))

api_key <- 'a459d0996e77ce3ef957c6b2e265d33a'

datasets_url <- 'https://apidata.mos.ru/v1/datasets?api_key='
datasets_url <- paste0(datasets_url, api_key)
response <- GET(datasets_url)

datasets <- content(response, as='text')
datasets <- fromJSON(datasets)


precinct_url <- 'https://apidata.mos.ru/v1/datasets/961/rows?api_key='
precinct_url <- paste0(precinct_url, api_key)
response <- GET(precinct_url)

precincts <- content(response, as='text')
precincts <- fromJSON(precincts)

install.packages('dplyr')
library(dplyr)

clean_data <- sapply(
  precincts, function(x) {x$Cells$geoData$coordinates})

clean_data <- t(clean_data)
clean_data <- data.frame(clean_data)
colnames(clean_data) <- c('lon','lat')
 
install.packages('ggplot2')
library(ggplot2)

axes <- ggplot(data=clean_data, mapping=aes(x=lon, y=lat))

axes + geom_point()

install.packages('ggmap')
library(ggmap)
install.packages('maptools')
library(maptools)
install.packages('maps')
library(maps)
install.packages('OpenStreetMap')
library(OpenStreetMap)

axes + geom_density2d(h=0.06)

save.plot('Moscow.png')

#geocode - команда, чтобы не возиться с апи ключами

#scholar - пакет с данными гугло-=н е