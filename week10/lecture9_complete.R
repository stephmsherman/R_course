#Before we start I would like to review paired t-tests from the homework a couple weeks ago

#Let's import data from 80 participants who each took one of five classes
s=read.csv("~/Downloads/between_subjects_sleep_class.csv")
head(s)
#again we always check the structure
str(s)

##substitution
s$sex=gsub(0,"male",s$sex)
s$sex
s$sex=gsub(1,"female",s$sex)
s$sex
#NOTE: there are easier ways to accomplish this but using gsub can be a handy tool

#check our structure
str(s)
s$sex=as.factor(s$sex)
str(s)

#now we have everything ready to start our data analysis

#first we want to see if test_score varies across different classes (art, english, and history,math). Essentially we want to see whether the mean test scores differ across all the classes
levels(s$classes)

#Why can't we use a t-test like we have before?
t.test(test_score~classes,s)

#You guessed it, we have more than 2 levels of our class factor

#so we are going to use a one-way between subjects ANOVA
?aov

#structure of aov function
#aov(dependent variable ~ group/independent variable, data)
#this should look similiar to aggregate formula and t-test formula

#let's try it
#dependent variable = test scores (numeric column)
#factor/group variable = classes (factor column)
analysis=aov(test_score~classes,s)

#we saved the anova formula to an object called analysis
#in order to look at the analysis output we use the summary function
summary(analysis)
#OR
anova(analysis)

#What can we conclude so far?

#since the analysis is a model object in R let's look at the individual objects
#(just like the correlation and t-test)
names(analysis)

#print details of analysis like the mean
model.tables(analysis,"means")

#same as using aggregate
aggregate(test_score~classes,s, mean)

#interesting illustration of the results
#you can either put in the formula
plot.design(s$test_score~s$classes)
#plots means of each factor as well as grand mean

#or you can look at all the factor means across all the different levels
plot.design(s)
#pay attention to the change in y-axis

#now we want to unfold these results to understand which class test scores are significantly different from others

#Tukey mulitiple comparisons of means
#gives upper and lower 95% confidence intervals by default and adjusted p value
comparisons=TukeyHSD(analysis)
comparisons

#we can graph the confidence intervals to better illustrate/understand the results

#I used par to increase the margins before plotting
par(mar=c(5.1,6.8,4.1,2.1))
plot(comparisons, las=1)
#if 0 is in the confidence interval then the results are non-signficant (p > .05)

#If you planned to run specific contrasts to investigate differences between two groups then here is how you would complete follow up t-tests
t.test(test_score~classes,s[s$classes=="art" | s$classes=="english",])

#look at how the results compare to Tukey HSD (which has an adjusted p-value)
comparisons$classes["english-art",]

##two way between subjects ANOVA)
#new research question: now we want to know whether test scores vary across different classes and genders. We now have 2 factors- classes and sex
analysis_2fac=aov(test_score~classes+sex,s)
summary(analysis_2fac)
model.tables(analysis_2fac,"means")

#what can we conclude?


#testing the interaction model
#interaction: the effect of one factor on the dependent variable differs across levels of another factor. 
#we want to know whether test scores in each class differ across males and females
analysis_interaction=aov(test_score~classes*sex,s)
summary(analysis_interaction)
model.tables(analysis_interaction,"means")
#IGNORE main effects

#there is no interaction so we can drop that term and look at main effects (like we did above)
analysis_2fac =aov(test_score~classes+sex,s)
summary(analysis_2fac)
#MAKE SURE TO REMOVE THE INTERACTION TERM FROM THE MODEL BEFORE INVESTIGATING THE MAIN EFFECTS

#Your turn!
#Import football_player_weights.csv and call it f. You goals is to find out whether players weight significantly differs across the 5 teams. 
f=read.csv("~/Downloads/football_player_weights.csv")
f

#1. First you should notice that the data are in the wide format. You must convert the data to the long format before you begin (HINT: melt) 
library(reshape2)
f=melt(f)
f


#2. Conduct the appropriate analysis to find out whether weight differs across the teams. Be sure to print the mean weight of each team.
w=aov(value~variable,f)
summary(w)
model.tables(w,"means")

###

#NOTE: You should be aware that R's aov uses type I sum of squares by default whereas SPSS and SAS use type III sum of squares. If you have an unbalanced factorial design (different number of N in each group) this distinction will be important. If you would like to use Type III sum of squares in R, you can use the car package
install.packages("car")
library(car)
analysis1=aov(test_score~classes,s)
Anova(analysis1, type="3")

#because we have a balanced design the results are the same as aov (this table does not include the intercept)
summary(analysis1)