#Title: "Introduction to Open Data Science 2022, Assignment 4"
#Subtitle: "data wrangling"

#Author: "Yu Ren"
#Date: "26.11.2022"
#read datasets
library(tidyverse)

hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

#explore the datasets
str(hd)
dim(hd)
str(gii)
str(gii)

#summaries of the variables
summary(hd)
summary(gii)

#rename the variables
library(tidyselect)

hd <- hd %>% 
  rename(hdi.rank = `HDI Rank`,
         hdi = `Human Development Index (HDI)`,
         life.exp = `Life Expectancy at Birth`,
         edu.exp = `Expected Years of Education`,
         edu.mean = `Mean Years of Education`,
         gni = `Gross National Income (GNI) per Capita`,
         gni_hdi = `GNI per Capita Rank Minus HDI Rank`)

#check the names
colnames(hd)

gii <- gii %>% 
  rename(gii.rank = `GII Rank`,
         gii = `Gender Inequality Index (GII)`,
         maternal.mortality.ratio = `Maternal Mortality Ratio`,
         teen.birth = `Adolescent Birth Rate`,
         per.pa = `Percent Representation in Parliament`,
         edu.f = `Population with Secondary Education (Female)`,
         edu.m = `Population with Secondary Education (Male)`,
         labour.f = `Labour Force Participation Rate (Female)`,
         labour.m = `Labour Force Participation Rate (Male)`)
#check the name
colnames(gii)

#Mutate the “Gender inequality” data and create two new variables.
gii <- gii %>% 
  mutate("edu_fm" = edu.f/edu.m,
         "labour_fm" = labour.f/labour.m)

#join 2 datesets
human <- inner_join(hd, gii, by = "Country")
human %>% head



write_csv(human, "data/human.csv")




#***********Assignment 5: Data Wrangling***************

str(human); dim(human)
#The dataset has 195 observations and 19 variables.

library(stringr)
library(dplyr)

#check the structure of GNI
str(human$gni)

#transform the GNI variable to numeric
human$gni <- str_replace(human$gni, pattern = ",", replace = "") %>%
  as.numeric()

#exclude unneeded variables
keep <- c("Country", "edu_fm", "labour_fm", "edu.exp", "life.exp", "gni", "maternal.mortality.ratio", "teen.birth", "per.pa")
human <- dplyr::select(human, one_of(keep))

#Remove all rows with missing values 
human <- filter(human, complete.cases(human))

#Remove the observations which relate to regions instead of countries.
last <- nrow(human) - 7
human <- human[1:last, ]

#Define the row names of the data by the country names and remove the country name column from the data.
#remove the country name column from the data
rownames(human) <- human$Country
keep <- c("edu_fm", "labour_fm", "edu.exp", "life.exp", "gni", "maternal.mortality.ratio", "teen.birth", "per.pa")
human <- dplyr::select(human, keep)

write.table(human, "human.txt", append = FALSE, sep = ",", dec = ".",
            row.names = TRUE, col.names = TRUE)



