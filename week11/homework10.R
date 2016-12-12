#homework 10 - linear regression

#1. Import sleep_in_animals.csv and call it s (2pts)
#Here is a link to the data explanation - http://lib.stat.cmu.edu/datasets/sleep



#2. What is the range in total sleep time and lifespan across all the animal species? (2pts)



#3.Does lifespan (max_lifespan) predict total sleep time? In other words, does the lifespan length predict how long an animal needs to sleep? Please 1) conduct the linear model 2) report the direction of the relationship and what it means 3) plot the relationship with the line of best fit (5pts)


#4. How many animals were included in the above analysis? Show me how you arrived at this conclusion (2pts)



#4. Does body weight predict predation index? Run the linear model, report the results, and plot the relationship (3pts)





#5. I mentioned in class that in order to get the standardized betas (standardized regression coeffients), you have to z score the data. Below is code showing you an easy way to z-score your data (Thanks Dr. Hixon!). Run this code. Since the code requires you to remove missing data, also run the na.omit code below. From now on please use the "a" dataset as the un-zscored data in the following analyses (whereas zdata is the zscored data). 

install.packages("QuantPsyc")
library(QuantPsyc)
zdata=data.frame(Make.Z(na.omit(s[,2:dim(s)[2]])))
head(zdata)

#this code does not allow any missing values or non-numeric columns

#actual data but without the NAs
a=na.omit(s)


#Part A: Run the linear regression analysis using lifespan to predict gestation period with the "a" data and "zdata". Please write a comment comparing the linear regression outputs. (4pts)  




#Part B: Now run a correlation analysis on the "a" dataset. Please write a comment comparing the correlation output to the linear regression output using the zdata. (2pts)



#NOTE: please keep in mind that what you are finding is only seen when you have one predictor in the model. 