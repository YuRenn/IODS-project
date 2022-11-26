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









