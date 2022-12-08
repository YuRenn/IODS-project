#Author: Yu Ren
#Assignment 6: data wrangling

#1.read the data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep = "", header = T)

# take a look at the data sets
#BPRS
dim(BPRS)
str(BPRS)
summary(BPRS)
#RATS
dim(RATS)
str(RATS)
summary(RATS)

#2.Convert the categorical variables of both data sets to factors
# Factor treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

#3.Convert the data sets to long form. Add a week variable to BPRS and a Time variable to RATS.
# Convert to long form
BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
  arrange(weeks)

# Convert data to long form
RATSL <- pivot_longer(RATS, cols = -c(ID, Group), 
                        names_to = "WD",
                        values_to = "Weight") %>% 
  mutate(Time = as.integer(substr(WD, 3, 4))) %>%
  arrange(Time)

#4.
#Take a serious look at the new data sets and compare them with their wide form versions
names(BPRS)
names(BPRSL)

names(RATS)
names(RATSL)

#look at the structure....
str(BPRSL)
glimpse(BPRSL)

str(RATSL)
glimpse(RATSL)

#Write the data sets to file
write.table(RATSL, "data/ratsl.txt", append = F, sep = ",", dec = ".",
            row.names = T, col.names = T)

write.table(BPRSL, "data/bprsl.txt", append = F, sep = ",", dec = ".",
            row.names = T, col.names = T)


