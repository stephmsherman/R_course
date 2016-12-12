#homework 10 - linear regression

#1. Import sleep_in_animals.csv and call it s (2pts)
#Here is a link to the data explanation - http://lib.stat.cmu.edu/datasets/sleep
s=read.csv("~/Dropbox/Classes/R course/lesson_plans/class_11_06_14/sleep_in_animals.csv")
head(s)
dim(s)

#2. What is the range in total sleep time and max lifespan across all the animal species? (2pts)
summary(s$total_sleep_time)
summary(s$max_lifespan)

#3.Does lifespan (max_lifespan) predict total sleep time? In other words, does the lifespan length predict how long an animal needs to sleep? Please 1) conduct the linear model 2) report the direction of the relationship and what it means 3) plot the relationship with the line of best fit (5pts)

k=lm(total_sleep_time~max_lifespan,s)
summary(k)
plot(total_sleep_time~max_lifespan,s)
abline(lm(total_sleep_time~max_lifespan,s))
#as life span increases hours of sleep decreases

#4. How many animals were included in the above analysis? Show me how you arrived at this conclusion (2pts)
anova(k)
#54
#looked at dfs and added 2

dim(na.omit(s[,c("total_sleep_time","max_lifespan")]))

#4. Does body weight predict predation index? Run the linear model, report the results, and plot the relationship (3pts)
k=lm(predation_index~body_weight,s)
summary(k)
plot(predation_index~body_weight,s)
abline(lm(predation_index~body_weight,s))
anova(k)

#5. I mentioned in class that in order to get the standardized betas (standardized regression coeffients), you have to z score the data. Below is code showing you an easy way to z-score your data (Thanks Dr. Hixon). Run this code. Since the code requires you to remove missing data, also run the na.omit code below. From now on please use the "a" dataset and the un-zscored data in the following analyses. 

install.packages("QuantPsyc")
library(QuantPsyc)
zdata=data.frame(Make.Z(na.omit(s[,2:dim(s)[2]])))
head(zdata)
#this code does not allow any missing values or non-numeric columns

#actual data but without the NAs
a=na.omit(s)

#Part A: Run the linear regression analysis using lifespan to predict gestation period with the s data and zdata. Please write a comment comparing the linear regression output. (4pts)  

k=lm(gestation_period~ max_lifespan,a)
summary(k)

k=lm(gestation_period~ max_lifespan,zdata)
summary(k)
#the stats are the same except for the estimate

#Part B: Now run a correlation analysis on the "a" dataset. Please write a comment comparing the correlation output to the linear regression output using the zdata. (2pts)
cor.test(a$gestation_period,a$max_lifespan)
#the correlation coeffient is the same as the standardized beta

#NOTE: please keep in mind that what you are finding is only seen when you have one predictor. 