#Yu Ren
#Data: 18.11.2022
# data wrangling and explore the structure of the data
#reference: [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets.html)

#prepare the packages
library(tidyverse)
library(dplyr)

#1. read student-mat.csv and student-por.csv
math <- read_csv('/Users/renyu/Desktop/IODS-project/data/student-mat.csv')
por <- read_csv('/Users/renyu/Desktop/IODS-project/data/student-por.csv')

#explore the structure and dimensions of the data
str(math)
str(por)
dim(math)
dim(por)

#2.Join the two data sets using all other variables than "failures", 
#"paid", "absences", "G1", "G2", "G3" as (student) identifiers. 
#Keep only the students present in both data sets.
free_cols <- c("failures","paid","absences","G1","G2","G3")
join_cols <- setdiff(colnames(por), free_cols)

math_por <- inner_join(math, por, by = join_cols, suffix = c(".math", ".por"))

# the structure and dimensions of the joined data
str(math_por)
dim(math_por)

#3. Get rid of the duplicate records in the joined data set.
alc <- select(math_por, all_of(join_cols))
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(math_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}

#4.Take the average of the answers related to weekday and weekend alcohol 
#consumption to create a new column 'alc_use' to the joined data. 
#Then use 'alc_use' to create a new logical column 'high_use' which is TRUE for 
#students for which 'alc_use' is greater than 2 (and FALSE otherwise).

#create a new column "alc_use"
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
#create a newlogical column "high_use"
alc <- mutate(alc, high_use = alc_use > 2)

#5.Glimpse at the joined and modified data to make sure everything is in order
dim(alc)

#6.save the dataset
write_csv(alc, "alc.csv")
