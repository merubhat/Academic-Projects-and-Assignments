#Step 1:
#Create a folder by the name of ABI for Homework.

#Step 2
setwd("C:/Users/NICSI/Desktop/ABI/HW 1")

#Step 3
auto=read.csv("Auto.csv")
dim(auto)

#Step 4 
fix(auto)
temp<-edit(auto)
names(temp)

#Step 5
auto[auto=="?"]<- NA
auto[auto==""]<- NA
auto<-na.omit(auto)
dim(auto)

#Step 6
library(ggplot2)
plot1<- plot(auto$cyl,auto$mpg,xlab = "Cyl",ylab = "MPG" )
plot1

#Step 7
p1<-hist(
  auto$horsepower, 
  xlab="Horsepower", 
  main="Histogram For the distribution of Horsepower",breaks = 6, col = "Blue")
#Step8 
summary(auto$mpg)
summary(auto$acceleration)
library(e1071)
skewness(auto$mpg)
skewness(auto$acceleration)

