#jootenhu 29.12.2017
#Creating learn2014.cvs from http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt 
#meta file http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS2-meta.txt

# Access the dplyr library
library(dplyr)

#Read txt file from url
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

#Print dimensions of lrn14
# [1] 183  60
# n = 183 variables = 60
dim(lrn14)

#Print structure of lrn14
str(lrn14)

#Scaling attitude variable
lrn14$Attitude <- lrn14$Attitude / 10

lrn14$Gender <- lrn14$gender
#Create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points 
#by combining questions in the lrn14 data according to meta file http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS2-meta.txt

d_sm <- c("D03", "D11", "D19", "D27")
d_ri <- c("D07", "D14", "D22", "D30")
d_ue <- c("D06", "D15", "D23", "D31")
su_lp <- c("SU02", "SU10", "SU18", "SU26")
su_um <- c("SU05", "SU13", "SU21", "SU29")
su_sb <- c("SU08", "SU16", "SU24", "SU32")
st_os <- c("ST01", "ST09", "ST17", "ST25")
st_tm <- c("ST04", "ST12", "ST20", "ST28")

# questions related to deep, surface and strategic learning
Deep <- c(d_sm, d_ri, d_ue)
Surf <- c(su_lp, su_um, su_sb)
Stra <- c(st_os, st_tm, su_sb)

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(Deep))
lrn14$Deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(Surf))
lrn14$Surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(Stra))
lrn14$Stra <- rowMeans(strategic_columns)

# change the name of the first column
colnames(learning2014)[1] <- "Gender"

# choose columns to keep
keep_columns <- c("Gender","Age","Attitude", "Points", "Deep", "Stra", "Surf")



# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

# select rows where Points is greater than zero
learning2014 <- filter(learning2014, Points > 0)

# see the stucture of the new dataset
str(learning2014)


#Save dataset for later use
write.csv(learning2014, file = "learning2014.csv", eol= "\r", na = "NA", row.names = FALSE)

#read dataset to verify the saving
read_test <- read.csv("learning2014.csv", header = TRUE, sep=",")

#print out structure of dataset
str(read_test)

