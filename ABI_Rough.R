#

setwd("C:/Users/NICSI/Desktop/ABI/HW 2")
library(AER)
data("HealthInsurance")

data(Boston)

attach(Boston)
#Step 2 include interaction terms in a linear model using the lm() function. The syntax lstat:black
#tells R to include an interaction term between lstat and black. The syntax lstat*age
#simultaneously includes lstat, age, and the interaction term lstat×age as predictors; it is a
#shorthand for lstat+age+lstat:age.
summary(lm(medv ~ lstat*age, data = Boston))

#Step 3 (0.5 mark) Use command dim to check how many observations and variables 
#are in the Boston file. Find the names of variables in this file. 

dim(Boston)
names(Boston)
#Step 4 (0.5 mark) Run the multivariate regression of medv against lstat  and age 
#with interaction.

g1<- lm(medv ~ lstat*age, data = Boston)

#Step 5 Is interaction term significant or not. Is the answer difference for confidence probability 5% and 1%? Formulate the appropriate hypotheses and make a conclusion based on 
#the relevant p-values.

summary(g1)
#The term lstat:age is significant for both 5% and 1 % as the p-value for the same is less than 2.2e-16 which 
#is close to zero. 

#Step6 Implement the multiple linear regression of medv against lstat and age without
#interaction (or just see the results in HW1). Compare these two models with and without
#interact-ion.

multmode <- lm(medv~lstat+age,data=Boston)  
summary(multmode)
#The p-value for both the model is 2.2 e-16 which is very less . So we consider the coefficient the coefficient 
# of predictors to tell the significance of model. 

#Based on the infernce age is not a significant variable hence we can say the interaction term of lstats and age 
# helps to increase the goodness of model.

#Step 7
#Residual Standard error of Model without interaction term: 6.176
#Residual Standard error of Model without interaction term: 6.149

#The residual Standard error of both the models are the same so it won't make any significance impact of the model.

#Step 1 
int1<- (Boston$lstat)^2
g2<- lm(medv~lstat+int1,data=Boston)
summary(g2)

#Step2
g3<- lm(medv~lstat,data= Boston)
summary(g3)

#The adjusted R square measures the proportion of the variation in your 
#dependent variable (Y) explained by your independent variables (X) for a linear regression model.
#The Bigger value of R2 better is the model. 
#The value for quadratic model is .5432 while for linear model is .5481. 
#Both the values are more or less the same but still quadratic model has lesser value hence we'll go with quadratic model.
#Step3 
anova(g2,g3)

#Big Model good f



#Step1 
library(ISLR)
data(Smarket)
str(Smarket)
summary(Smarket)

#Step2
#install.packages("WGCNA")
#library(WGCNA)

cor(Smarket[, -9])

#Step 3
#Volume has maximum collinearity with year. (.53)

library(ggplot2)
plot(Smarket$Year,Smarket$Volume)
#Reflect a positive relationship between the two variables.

#The trend line of the same:
abline(lm(Volume~Year,data=Smarket))

#install.packages("ggpubr")
library("ggpubr")
ggscatter(Smarket, x = "Year", y = "Volume", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Volume", ylab = "Year")
#Highly Significant

#Step 4

g4<-glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,family=binomial,data=Smarket)
summary(g4)
#Step5


lwrpf <- pf(0, 760, g4$df.residual)
uprpf <- pf(0.95, 760, g4$df.residual)
c(lwrpf, uprpf)

#None is significant to predict the volume

#Step 6
coef(g4)
#Consistent with the previous step

#step 7
summary(g6)

#Step8
predict<-predict(g4, newdata = NULL,
        type = c("response"))
head(predict,n=10)

#Step 9 Step 9 (0.5 mark) Use contrasts() function, which indicates that R has created a dummy
#variable with a 1 for Up, to check if these values correspond to the probability of the market
#going up, rather than down.
library(MASS)
Smarket$Direction <- factor(Smarket$Direction)
levels(Smarket$Direction) <- c("Down", "Up")
(contrasts(Smarket$Direction))

#Step 10    
#Step 10 (0.5 mark) Convert these predicted probabilities into class labels, Up or Down, in order to make our prediction more transparent. Check the result with command fix.

g5<-rep("Down", 1250)
g5[predict>.5]="Up"
fix(Smarket)

#Step11
#Step 11 (0.5 mark) Given these predictions, use the table() function to produce a confusion matrix in order to determine how many observations were correctly or incorrectly classified.

table(g5, Smarket$Direction)

#Step12
(507+145)/(1250)

mean(g5==Smarket$Direction)

#Step13
attach(Smarket)
subset<- (Smarket$Year<2005)

Smarket.2005<-Smarket[!subset,]
dim(Smarket.2005)

#Step 14
Direction.2005<- Direction [! subset]

glmfit<-glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume, data=Smarket, family =binomial, subset= subset)
glmprob=predict(glmfit, Smarket.2005, type="response")
glmpredict=rep("Down", 252)
glmpredict[glmprob>.5]="Up"
table(glmpredict, Direction.2005)

mean(glmpredict==Direction.2005)
mean(glmpredict!=Direction.2005)

summary(glmfit)
glmfit<-glm(Direction~Lag1+Lag2 ,data=Smarket ,family=binomial , subset=subset)
glmprob<-predict(glmfit ,Smarket.2005, type="response")
glmpredict<-rep("Down",252)
glmpredict[glmprob >.5]<-" Up"
table(glmpredict ,Direction.2005)
mean(glmpredict==Direction.2005)
mean(glmpredict!=Direction.2005)

