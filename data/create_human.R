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

hd <- hd%>%
  rename(hdir = "HDI rank",
         hdi = "Human Development Index (HDI)",
         lifeexp = "life expectancy at birty",
         edumean = "expected years of education",
         gni = "gross national income per capita",
         g_h = "gni per capota rank minus HDI rank")

gii <- gii%>%
  rename(giir = "GII Rank",
         gii = "gender inequality index",
         maternaldr = "Maternal Mortality Ratio",
         teenbr = "adolescent bith rate",
         prp = "percent representation in parliament",
         edu2F = "Population with Secondary Education (Female)",
         edu2M = "Population with Secondary Education (Male)",
         workrF = "Labour Force Participation Rate (Female)",
         workM = "Labour Force Participation Rate (Male)")

#Mutate the “Gender inequality” data and create two new variables.
gii <- gii%>%
  mutate(Edu2.FM = Edu2.F / Edu2.M,
         Labo.FM = Labo2.F / Labo2.M)

#join 2 datesets
human <- inner_join(hd, gii, by = "Country")
human %>% head

write_csv(alc, "data/alc.csv")




#***********Assignment 5: Data Wrangling***************
human_5 <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human1.txt",
                        sep=",", header = T)

str(human_5); dim(human_5)
#The dataset has 195 observations and 19 variables.

library(stringr)
library(dplyr)
#check the structure of GNI
str(human$`Gross National Income (GNI) per Capita`)

#transform the GNI variable to numeric
human_5$GNI <- str_replace(human$`Gross National Income (GNI) per Capita`, pattern = ",", replace = "") %>%
  as.numeric()

#exclude unneeded variables
keep <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human_5 <- dplyr::select(human_new, one_of(keep))

#Remove all rows with missing values 
human_5 <- filter(human_5, complete.cases(human_5))

#Remove the observations which relate to regions instead of countries.
last <- nrow(human_5) - 7
human_5 <- human_5[1:last, ]

#Define the row names of the data by the country names and remove the country name column from the data.
#remove the country name column from the data
rownames(human_5) <- human_5$Country
keep <- c("Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human_5 <- dplyr::select(human_5, keep)

write.table(human_new, "human.txt", append = FALSE, sep = ",", dec = ".",
            row.names = TRUE, col.names = TRUE)



