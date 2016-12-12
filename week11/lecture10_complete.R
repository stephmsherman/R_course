#Read in dataset about California Test Scores called Caschool.csv
c=read.csv("~/Downloads/Caschool.csv")
head(c)
#notice that there is a column called X; that is what R calls columns when they do not have a column name

#Let's look at the desciption of the variables here:
#http://vincentarelbundock.github.io/Rdatasets/doc/Ecdat/Caschool.html
str(c)

#Notice that district code is an integer but in reality it is a factor

#since those district numbers are meaningful, we will first change the column to a character then a factor
c$distcod=as.factor(as.character(c$distcod))

str(c$distcod)
#since there are 420 factors and 420 observations total we have a single measure per district (no repeated measures in these data)

#Are all the other variables in the correct format?


#Now that we understand the dataset and know all the columns are in the right format, we are ready to begin our analysis!

#Research Question: Does the student teacher ratio (str) predict average test scores (testscr). Do students in school districts who have a smaller student teacher ratio have higher test scores?

#For this question we want to use linear regression
?lm
#lm(outcome~predictor,data)

#predictor: student teacher ratio 
#outcome: average test score 

reg=lm(testscr~str,c)
summary(reg)

#Let's break down the output of lm
names(reg)
########Residuals######## 
#residuals/error are the difference between the actual data and the predicted data (predicted data- data on line of best fit)
head(reg$residuals)
#We want to see whether the residuals are normally distibuted

#plot the proportion of residuals 
hist(reg$residuals,prob=TRUE,ylim=c(0,.022))
curve(dnorm(x,mean=mean(reg$residuals), sd=sd(reg$residuals)),add=TRUE)
#when we overlay a normal curve we see that the residuals are normally distributed

#in other words, the residuals are centered at zero which is also illustrated in the summary output. 
summary(reg)

######## t statistic and p value########
summary(reg)$coef

#lets look at the t statistics and p value for student teacher ratio predictor
summary(reg)$coef[2,3:4]
#this is telling us that student teacher ratio significantly predicts average test scores

#Since we only have one predictor in our model the f-statistic is the t-statistics squared 
tstat=summary(reg)$coef[2,3]
tstat
tstat^2
summary(reg)$fstatistic

#print anova table
anova(reg)

#What does this really mean?

########Coefficients########
summary(reg)$coef
#To better understand that t statistic and p value, lets look at the coefficients/estimates for our student teach ratio (str) predictor
summary(reg)$coef[2,1]

#The estimate is the slope or unstandardized beta coefficient

#The first thing we notice is this coefficient is negative so we know that a higher student teacher ratio is associated with lower average test scores (negative relationship)

#This number is called an unstandardized beta because slope is in the raw units of measure

#Let's graph the data to understand the estimates
#overall this is what our data look like
plot(testscr~str,c,xaxs="i",ylab="Average Test Scores",xlab="Student Teacher Ratio", main="Student Teacher Ratio by Average Test Scores")
abline(lm(testscr~str,c),lwd=1.5)
#residuals: actual - predicted
segments(15.58,663,15.58,673,col="red",lwd=2)
segments(23.3,631,23.3,646,col="red",lwd=2)

#zoom in on a portion of the graph 
plot(testscr~str,c,xlim=c(0,2),ylim=c(690, 700),xaxs="i",ylab="Average Test Scores",xlab="Student Teacher Ratio", main="Illustrating Estimates of Linear Regression Analyses")
abline(lm(testscr~str,c),lwd=1.5)

#for every one unit of increase in the student teacher ratio
segments(0,698.9, 1,698.9,col="red",lwd=2)
text(.7, 699.5, "1 unit increase in student teacher ratio")

#there is a 2.28 decrease in average test scores
segments(1,698.9,1, (698.9+summary(reg)$coef[2,1]), col="red",lwd=2)
text(1.45, 698,"2.28 unit decrease \n in average test scores")
summary(reg)
#NOTE: if you want to report standardized beta coefficients then you have to Z score everything 

#great resource that explains each part of lm output
#http://blog.yhathq.com/posts/r-lm-summary.html

#Your turn!
#Import Wages1.csv and call it w
#1. Do years of schooling (school) predict wage per hour (wage)? Please describe what the slope means in the context of these results.
w=read.csv("~/Downloads/Wages1.csv")
head(w)
str(w)
reg2=lm(wage~school, w)
summary(reg2)
plot(wage~school, w)
abline(reg2)
plot(w$wage,w$school)
abline(lm(school~wage,w))


##

#Next Research Question
#we know that there are a lot of variables that could predict average test scores so we may not be getting the entire picture with out first analysis

#what about income?
str(c$avginc)
range(c$avginc)
#there is a large range across the districts so maybe income is related to test scores

#Does the relationship between student teacher ratio and average test score depend on the income of that district?

#Interaction model
#lm has same syntax as aov
reg2=lm(testscr~str*avginc,c)
summary(reg2)
#What do the results mean?

#Let's graph it to better understand the results

#It can be difficult to graph interactions so the easiest way do it is to split one of the predictors into high and low groups - perform a median split
c$income_split=ifelse(c$avginc<median(c$avginc),"low","high")
c$income_split=as.factor(c$income_split)
summary(c$income_split)

#plot the relationship between test scores and student teacher ratio and specify which data points have high incomes and which have low incomes
#setting margins good reference- http://research.stowers-institute.org/efg/R/Graphics/Basics/mar-oma/
#c(bottom, left, top, right)

#default setting for mar
c(5, 4, 4, 2)
par(mar=c(5, 8, 4, 2))
plot(testscr~str,c,col=ifelse(c$income_split =="high","blue","black"),pch=ifelse(c$income_split =="high",19,18),ylim=c(605,710),xlab="Student Teacher Ratio",ylab="Average Test Scores", main="Interaction between Student Teacher Ratio and Income", cex.lab=2, cex.axis=1.3)
#add legend
legend("topright",c("High Income","Low Income"),col=c("blue","black"),pch=c(19,18),bty="n")
#add line of best fit for high and low income groups
abline(lm(testscr~str,c[c$income_split=="high",]),col="blue",lwd=2)
abline(lm(testscr~str,c[c$income_split=="low",]),col="black",lwd=2)
#add stats to graph
text(24,610, "t(416) = 4.09, p < .001", cex=1.3)


#compare the slopes
#run linear regression to compare slopes of high and low income groups
high=lm(testscr~str,c[c$income_split=="high",])
low=lm(testscr~str,c[c$income_split=="low",])
summary(high)$coef[2,1]
summary(low)$coef[2,1]
#these results suggest that for everyone one unit increase in student teacher ratio the high income groups test scores drop at a higher rate
#in other words, the high income group has a stronger relationship between student teacher ratio and average test scores

#NOTE: we can only compare the slopes in the unstandardized beta form because they are in the same unit of measures

