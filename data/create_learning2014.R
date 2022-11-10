#Title: "Introduction to Open Data Science 2022, Assignment 2"
#Subtitle: "data wrangling"

#Author: "Yu Ren"
#Date: "9.11.2022"

library(dplyr)

#1. read the full learning2014data
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
#1.1 explore the structure and dimensions of the data
str(learning2014)
dim(learning2014)

#2. Create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points by combining questions in the learning2014 data,
lrn14$attitude <- lrn14$Attitude / 10
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
lrn14$deep <- rowMeans(lrn14[, deep_questions])
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
lrn14$surf <- rowMeans(lrn14[, surface_questions])
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
lrn14$stra <- rowMeans(lrn14[, strategic_questions])
learning2014 <- lrn14[, c("gender","Age","attitude", "deep", "stra", "surf", "Points")]
colnames(learning2014)[2] <- "age"
colnames(learning2014)[7] <- "points"
learning2014 <- filter(learning2014, points > 0)

View(learning2014)

#3. recheck the structure and dimensions
str(learning2014)
dim(learning2014)

#4. set the working directory of R session to the IODS Project folder
library(tidyverse)

write_csv(learning2014, file = "data/learning2014.csv")
learning2014.read <- read_csv("data/learning2014.csv")

dim(learning2014)






