# run script in terminal to perform preprocessing of info to be sent into python

library(fitzRoy)
library(dplyr)
library(jsonlite)
library(lubridate)

preprocess_fixture <- function(fixture) {
    # create new column for each state. 
    fixture_clean <- fixture %>% mutate(region = case_when(
        venue %in% c('Adelaide Hills', 'Adelaide Oval', 'Norwood Oval', 'Football Park') ~ "SA",
        venue %in% c('M.C.G.', 'Docklands', 'Eureka Stadium', 'Kardinia Park', 'Marvel Stadium', 
                     'GMHBA Stadium', 'Mars Stadium') ~ "VIC",
        venue %in% c('Carrara', 'Gabba', "Cazaly's Stadium", "Riverway Stadium") ~ "QLD",
        venue %in% c('S.C.G.', 'Sydney Showground', 'Stadium Australia', 'Blacktown') ~ "NSW",
        venue %in% c('Marrara Oval', 'Traeger Park') ~ 'NT',
        venue %in% c('Bellerive Oval', 'York Park', 'University of Tasmania Stadium') ~ "TAS",
        venue %in% c('Manuka Oval', 'UNSW Canberra Oval') ~ 'ACT',
        venue %in% c('Perth Stadium', 'Optus Stadium', 'Subiaco') ~ 'WA',
        venue %in% c('Jiangwan Stadium', 'Adelaide Arena at Jiangwan Stadium') ~ 'CHN',
        venue %in% c('Wellington') ~ 'NZL',
        TRUE ~ NA_character_  # set NA for all other observations
    ))
    
    
    fixture_clean$date <- as.Date(fixture_clean$localtime)
    fixture_clean$time <- format(ymd_hms(fixture_clean$localtime), "%H:%M:%S")
    fixture_clean$home_win <- ifelse(fixture_clean$hscore > fixture_clean$ascore, 1, 0) 
    fixture_clean$hdiff <- fixture_clean$hscore - fixture_clean$ascore
    
    # select specific rows
    fixture_clean <- select(fixture_clean, year, round, date, time, region, venue, hteam, ateam, hscore, ascore, 
                            is_grand_final, is_final, home_win, hdiff)
    
    return(fixture_clean)
}


fixture_12 <- fetch_fixture_squiggle(2012)
fixture_13 <- fetch_fixture_squiggle(2013)
fixture_14 <- fetch_fixture_squiggle(2014)
fixture_15 <- fetch_fixture_squiggle(2015)
fixture_16 <- fetch_fixture_squiggle(2016)
fixture_17 <- fetch_fixture_squiggle(2017)
fixture_18 <- fetch_fixture_squiggle(2018)
fixture_19 <- fetch_fixture_squiggle(2019)
fixture_20 <- fetch_fixture_squiggle(2020)
fixture_21 <- fetch_fixture_squiggle(2021)
fixture_22 <- fetch_fixture_squiggle(2022)
fixture_23 <- fetch_fixture_squiggle(2023)

fixture = rbind(fixture_12, fixture_13, fixture_14, fixture_15, fixture_16, fixture_17, fixture_18, fixture_19, fixture_20, fixture_21, fixture_22, fixture_23)

fixture = preprocess_fixture(fixture)

write.csv(fixture, file='fixture.csv', row.names=FALSE)