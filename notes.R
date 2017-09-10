library(tidyverse)

babynames <- read.csv("~/team/bootcamp/R/babynames.csv")

# %>% this is a pipe character
babynames %>% names()
names(babynames) #this is the same but without piping

###
# filter is used for selecting certain rows
filter(babynames, name == "Mary" & year < 1900) %>%
  select(year, sex, name, n)
  # select(-prop)
  # select(year:n)

#this is the same as above... style choice
babynames %>%
  filter(name == "Mary" & year < 1900) %>%
  select(year, sex, name, n)
###
#mutate is for creating new columns or for updating existing columns
babynames <- babynames %>%
  mutate(length = nchar(as.character(name))) 

###
# mean proportion of females with the name Mary of all time
babynames %>%
  filter(name == "Mary" & sex == "F") %>%
  summarize(meanprop = mean(prop))

# different summary stats can be added in summarize and they'll be columns in output
babynames %>%
  filter(name == "Mary" & sex == "F") %>%
  summarize(meanprop = mean(prop), 
            medianprop = median(prop),
            maxprop = max(prop), 
            minprop = min(prop))

# really want above for EVERY name, by gender
babynames %>%
  group_by(name, sex) %>%
  summarize(meanprop = mean(prop), 
            medianprop = median(prop),
            maxprop = max(prop), 
            minprop = min(prop))

###

initialprops <- babynames %>%
  mutate(initial = substring(name, 1, 1)) %>%
  group_by(year, sex, initial) %>%
  summarize(count = sum(n), 
            totalprop = sum(prop)) %>%
  ungroup() #gets rid of the variable (initial) we made on the fly so things aren't confused in the future

### most common initials for the year 2000

initialprops %>%
  filter(year == 2000) %>%
  arrange(desc(count))

### common data manipulation and cleaning paths

schooldata <- read_csv("~/team/bootcamp/R/schooldata.csv")
table(schooldata$studentid)

# lol you can do table on a table
table(table(schooldata$studentid))

schooldata %>%
  group_by(studentid) %>%
  summarize(n()) # n means number of observations in the current group

length(unique(schooldata$studentid))

nrow(schooldata) # 888
unique(schooldata[, c("studentid", "courseid")]) # 885 which means there are 3 duplicates

# duplicated function
duplicated(schooldata[, c("studentid", "courseid")]) #this produces a vector of true and false
schooldata[duplicated(schooldata[, c("studentid", "courseid")]),] # uses vector from above to find the duplicated values
schooldata[duplicated(schooldata[, c("studentid", "courseid")], fromLast = TRUE),] # searching from the end

# alld uplicate values
alldupes <-
  rbind(schooldata[duplicated(schooldata[, c("studentid", "courseid")]),], # uses vector from above to find the duplicated values
        schooldata[duplicated(schooldata[, c("studentid", "courseid")], fromLast = TRUE),])
# above isn't foolproof, better to do schooldata[dupicated forward | duplicated backwards]

schooldata[duplicated(schooldata[,c("studentid", "courseid")]) |
             duplicated(schooldata[,c("studentid", "courseid")], fromLast = TRUE),]

# we're going to be generous and give the students the higher grade

schooldata$student_course <-paste(schooldata$studentid, schooldata$courseid)
dups <- schooldata$student_course[duplicated((schooldata$student_course))]
dups
schooldata[schooldata$student_course %in% dups,]

schooldata %>%
  group_by(studentid, courseid) %>%
  filter(n() > 1)

schooldata <- schooldata[order(schooldata$grade), ]
dups <- duplicated(schooldata$student_course, fromLast = TRUE) # again, returns a T/F vector
schooldata <- schooldata[!dups,]
dim(schooldata) #885 x 13

schooldata <- schooldata[order(schooldata$grade, decreasing = TRUE), ]
dups <- duplicated(schooldata$student_course)
schooldata <- schooldata[!dups,]
dim(schooldata)

schooldata %>%
  group_by(studentid, courseid) %>%
  arrange(desc(grade)) %>%
  slice(1) %>%
  ungroup()

#### new stuff
schooldata$instructorname <- paste(schooldata$instructorfirst,
                                   schooldata$instructorlast)
#this does the same thing as above
schooldata <- schooldata %>%
  mutate(instructorname = paste(instructorfirst, instructorlast))



### change TBDs to missing values/NAs
schooldata$instructorname[schooldata$instructorname == "TBD TBD"] <- NA

#this does the same thing as above
schooldata <- schooldata %>%
  mutate(instructorname = ifelse(instructorname == "TBD TBD", NA, instructorname))


### DATES!

schooldata$startdate <- as.Date(schooldata$startdate)
#package in tidyverse
library(lubridate)

schooldata$startdate <- ymd(schooldata$startdate)
