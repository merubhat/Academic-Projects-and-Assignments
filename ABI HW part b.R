#install.packages("MASS")
library(MASS)
data("Boston")


#Step 1:
fix(Boston)
summary(Boston)

#Step 2
(linearmod <- lm(medv ~ lstat , data=Boston))

summary(linearmod)

#Significance: 
#The P=value for the variable lstat while predicting medv is less than .001 and hence is higly 
#significant for finding the ouput response. Thus the co-efficient of lstat can't be ignored which 
# is against the null hypothesis. 

#Step 4
names(linearmod)

#Step 5
  library(ggplot2)
  plot1 <- plot(Boston$lstat,Boston$medv,ylab = "Medv" , xlab = "Lstat", 
                main = "Plot Graph between medv and Lstat")
  abline(coef = coef(linearmod), col="red",lwd=3, main="LSS graph")
  
#________________________________________________________________________________________________
#multiple regression model
multmode <- lm(medv~lstat+age,data=Boston)  
summary(multmode)