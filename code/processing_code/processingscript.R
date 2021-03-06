###############################
# processing script
#
#this script loads the raw data, processes and cleans it 
#and saves it as Rds file in the processed_data folder

#load needed packages. make sure they are installed.
library(readxl) #for loading Excel files
library(dplyr) #for data processing
library(here) #to set paths
library(tidyverse)
#path to data
#note the use of the here() package and not absolute paths
data_location <- here::here("data","raw_data","Impaired_Driving_2012.csv")

#load data. 
#note that for functions that come from specific packages (instead of base R)
# I often specify both package and function like so
#package::function() that's not required one could just call the function
#specifying the package makes it clearer where the function "lives",
#but it adds typing. You can do it either way.
rawdata <- read.csv(data_location)

#take a look at the data
dplyr::glimpse(rawdata)

# data cleaning

# death rate has to be a number btw 0 and 100
processeddata <- rawdata %>% dplyr::filter( `All.Ages..2012` > 0 & `All.Ages..2012` < 100) %>% 
                             dplyr::filter( `Female..2012` > 0 & `Female..2012` < 100)
# drop rows with NA in any entry
processeddata <- processeddata %>% drop_na()

# save data as RDS
# I suggest you save your processed and cleaned data as RDS or RDA/Rdata files. 
# This preserves coding like factors, characters, numeric, etc. 
# If you save as CSV, that information would get lost.
# See here for some suggestions on how to store your processed data:
# http://www.sthda.com/english/wiki/saving-data-into-r-data-format-rds-and-rdata

# location to save file
save_data_location <- here::here("data","processed_data","processeddata.rds")

saveRDS(processeddata, file = save_data_location)


