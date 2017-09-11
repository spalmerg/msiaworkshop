library(tidyverse)
library(stringr)
library(readxl)
library(purrr)

#exercise: https://rawgit.com/izahn/R-data-cleaning/master/dataCleaning.html

#set working directory
setwd("~/z/msiaworkshop/R-data-cleaning-exercise") 

# list all excel spreasheet names/location 
boy.file.names <- list.files("babyNamesData/boys", full.names = TRUE)

# lists all of the separate tabs on each excel spreasheet
# this excel_sheets function is used in the following custom function
map(boy.file.names, excel_sheets)

# custom function that takes an excel spreasheet and returns the tab we want 
findTable1 <- function(x){
  str_subset(excel_sheets(x), "Table 1")
}

# takes the excel spreadsheet locations and finds the table we want on each of them
# reurns a list with the tab names that we want, we don't use this
boysNames <- map(boy.file.names, findTable1)

# make a custom function that reads the tab we want on the excel files
# uses read_excel

readTable1 <- function(file){
  read_excel(file, sheet = findTable1(file), skip = 6)
}

boysNames <- map(boy.file.names, readTable1)

# Let's clean up the names of the columns b/c they're in "bad shape"








