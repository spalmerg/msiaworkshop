install.packages("gapminder")

library(tidyverse)
library(gapminder)

gapminder <- read_csv("https://goo.gl/dWrc9m")

### Exploring the structure of the dataset ###
# names of the columns
names(gapminder)

# is there any missing data?
is.na(gapminder) #gives matrix of bools
sum(is.na(gapminder)) # returns zero, there are no missing values

#how many different countries are there? 
length(unique(gapminder$country)) #142 unique countries

# What is the continent name for the US? 
gapminder$continent[gapminder$country == "United States"][1] # Americas

# Does the number of countries in the data change over time?
# no, it's 142 every year...
gapminder %>%
  group_by(year) %>%
  count() 

gapminder %>%
  group_by(year) %>%
  summarize(n())

### Selecting and Filtering
# Show observations where life expectancy is greater than 80
gapminder %>%
  filter(lifeExp > 80)

# Show only population and GDP per captia for Kenya for years before 1970
gapminder %>%
  filter(country == "Kenya" & year < 1970)

# Show the observation that has the maximum life expectancy
# this just returns the maximum value
gapminder %>%
  summarise(max(lifeExp))

# this gives the whole row with the maximum value
gapminder %>%
  filter(lifeExp == max(lifeExp))

### Transforming data
gapminder$milpop = gapminder$pop/1000000

# Separate North and South America
northamerica <- c("Canada", "Costa Rica", "Cuba", "Dominican Republic", 
                  "El Salvador", "Guatemala", "Haiti", "Honduras",
                  "Jamaica", "Mexico", "Nicaragua", "Panama",
                  "Trinidad and Tobago", "United States")
gapminder$continent[gapminder$country %in% northamerica] <- "North America"
gapminder$continent[gapminder$continent == "Americas"] <- "South America"

gapminder <- gapminder %>%
  mutate(country = ifelse(country == "TBD TBD", NA, instructorname))

### Grouping and Summarizing
# Finding the average life expectancy per country
gapminder %>%
  group_by(country) %>%
  summarise(mean(lifeExp))

# Finding the maximum and minimum life expectancy 
gapminder %>%
  filter(lifeExp == max(lifeExp) | lifeExp == min(lifeExp))









