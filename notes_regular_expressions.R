library(tidyverse)
library(stringr)

"I'm thirsty"

"Here's a \"quote\"" #backslash character is an escape, says to treat following thing as literal character

x <- c("\"", "\\", "\n", "\t", "\u00b5") #quote, backslash, newline, tab, mu (unicode)
writeLines(x)

str_length(c("R", "R for data science"))

fruit <- c("apple", "banana", "pear")

str_sub(fruit, 1, 3)

str_view(fruit, "an")

str_view(fruit, ".a.")

str_view(c("127.0.0.1"), "\\.") # escape backslash b/c want backslash (need two... inception), also first match

str_view_all(c("127.0.0.1"), "\\.") # match all! 

str_view(fruit, "^a") # carrot (^) means beginning of string

str_view(fruit, "a$") # dollar sign means the end of the string

apples <- c("apple pie", "apple", "apple cake")

str_view(apples, "^apple$") # only apple! 

str_view(c("127.0.0.1"), "\\d\\.\\d") # d is for digit, and the double backslashes are for inception 

str_view(c("gray", "grey"), "gr[ae]y") # match anything with a or e

str_view(c("sgray","gray", "grey", "greya"), "gr(a|e)y") # same as above

str_view(fruit, "^[^a]") # anything that doesn't start with the letter a

x <- "MDCCCLXXXVIII" #1888

str_view(x, "CC+") # greedy
str_view(x, "CC?") # matches 0 or 1 (greedy)
str_view(x, "CC*") # greedy

str_view(x, "C[LX]+") # one or more of any of the characters in the []

str_view(fruit, "(na)+") # match n followed by a, no dupes etc. 

str_view(x, "C{2}") # CASE SENSITIVE

str_view(x, "C{2,}") # {min, max}

str_view(x, "CC*?") # makes the * not greedy (operator before)

fruit <- c("banana", "coconut", "cucumber", "jujube", "papaya", "salal berry")

str_view(fruit, "(..)\\1") #\\1 matches group
