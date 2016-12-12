#summary statistics

data=read.csv("~/Downloads/class_data/object_types.csv")
head(data)
str(data)

#examing your data

#basic summary stats
summary(data$hours_slept)

#you can calculate these measures individually
#get the mean
mean(data$hours_slept)

#median
median(data$hours_slept)

#standard deviation
sd(data$hours_slept)

#range of values
range(data$hours_slept)

#how do I print out only the upper end of the range
str(range(data$hours_slept))

range(data$hours_slept)[2]

#these commands are great for quick results on numeric data

#checking object types
str(data)
#first I noticed that condition is an integer when we need it to be a factor 
str(data$condition)
#Convert it from a number to a factor 
data$condition=as.factor(data$condition)
data$condition
#let's change these to names the 3 and 4 represent years in school
levels(data$condition)=c("junior","senior")
levels(data$condition)
data$condition

str(data$sex)
#Convert it from a number to a factor 
data$sex=as.factor(data$sex)
data$sex
levels(data$sex)=c("male","female")
data$sex

#best ways to examine categorical data
#frequency table
table(data$condition)

#you can also look at the frequencies split on groups
table(data$condition,data$sex)

#say we want to calculate the mean of hours_slept for juniors and seniors (condition 3 and 4) 

?aggregate
#show the data input argument
#in aggregate and a lot of other functions it does not want you to write data$ instead you specify the name of the dataframe in another input argument

#aggregate(numeric_column~ group_column, data= dataframe_name, function_name)

#mean of hours_slept for juniors and seniors 
aggregate(hours_slept~condition,data=data, FUN=mean)

#standard deviation of hours_slept for juniors and seniors 
aggregate(hours_slept~condition,data=data, FUN=sd)

#how do I get the median hours_slept for juniors and seniors? I want to call the output sleep_med 
sleep_med=aggregate(hours_slept~condition,data,median)
sleep_med

sleep_med=aggregate(hours_slept~condition,FUN=median,data=data)

#since hours slept is now the median of hours_slept let's change the name
names(sleep_med)[2]="hours_slept_median"
sleep_med

#see how the output of aggregate is a data frame?
class(sleep_med)

#now I just want a count or get the length of how many measures I have for hours slept in each condition
aggregate(hours_slept~condition,data=data, length)

#Cool function that is not in the base package or R
#installing an R package
install.packages("doBy")
library(doBy)
#the summaryBy function is very similiar to aggregrate except it has a few advantages
summaryBy(hours_slept~condition,data=data, FUN=c(mean,median,sd))
#we were able to calculate multiple values with ONE command 
#notice how it changed the name of the columns

#You can even right your own function and include it
#example of really basic function
add1 = function(x){
	 x + 1
	 }
	 
add1(5)
#you try 
add1(30)

#here is a function to calculate standard error
stderr = function(x){
	 sqrt(var(x,na.rm=TRUE)/length(na.omit(x)))
	 }
	 	 
stderr(data$hours_slept)
#here is what this did:
#replaced the x in the calculation for what I put in ()
sqrt(var(data$hours_slept,na.rm=TRUE)/length(na.omit(data$hours_slept)))
#if you need to create a specific calculation you can always write it!
#please refer to the Helpful Websites on the syllabus for details
#If you would like me to go over functions in class please submit the your choice survey 

summaryBy(hours_slept~condition,data=data, FUN=c(mean,median,sd,stderr))


#say you want to further separate the values by sex (you can also + columns to the aggregate command)
summaryBy(hours_slept~condition+sex,data=data, FUN=c(mean,median,sd,stderr))
#that is it!

#add more than one numeric column (this is unique to summaryBy)
summaryBy(hours_slept+test_scores~condition+sex,data=data, FUN=c(mean,median,sd,stderr))
#it is soo easy!

#Your turn!
#1. Import sleep_data.csv and call the data sleep (please look at the data)
sleep=read.csv("~/Downloads/sleep_data.csv")

#2. create a new dataframe called math_class with only the rows in the class column that equal math and all of the columns
math_class=sleep[sleep$class=="math",]

#2a What is the mean of test_difficulty column for only the math test?
mean(math_class$test_difficulty)

#3. Back to the entire data set called sleep, what is the mean test score for each class?
aggregate(test_score~class,data=sleep,FUN=mean)

#4. What is the standard deviation of test scores for each class?
summaryBy(test_score~class,sleep,FUN=sd)

#5 What is the average test score for males/females in each class?
aggregate(test_score~class+sex,sleep,mean)

###

#Dealing with missing data
mdata=read.csv("~/Downloads/sleep_data_missing_data.csv",na.strings="NA")
head(mdata)
mdata

#get mean test scores
mean(mdata$test_score)

#doesn't work because there is missing data
#we have to add more input arguments
mean(mdata$test_score,na.rm=TRUE)

#same for sd()
sd(mdata$test_score)

#need to add na.rm or remove NAs
sd(mdata$test_score, na.rm=TRUE)

##let's try the other summary commands

#aggregate is VERY flexible 
aggregate(test_score~subject, mdata,mean)

#let's check what it did
#sub06 had missing data so aggregate
mdata[mdata$subject=="sub06","test_score"]
mean(mdata[mdata$subject=="sub06","test_score"], na.rm=TRUE)
#OR
mean(c(.73,.82,.94,.81))
#aggregate does not need a special input argument, by default it removes NAs (na.action)
?aggregate

#now look at summaryBy
summaryBy(test_score~subject, mdata,FUN=c(mean))
#it does not remove NAs by default
#we have to add na.rm=TRUE as an input argument
summaryBy(test_score~subject, mdata,FUN=c(mean),na.rm=TRUE)

#let's look at one more example
aggregate(test_score~subject+class, mdata,mean)
#we did not have a test score for art class for sub06
#you will not see any output score in the aggregate function for art sub06

##in summaryBy holds a place for sub06 art test score with NaN for not a number
summaryBy(test_score~subject+class, mdata,FUN=c(mean),na.rm=TRUE) 

#NAs can be very frustrating to handle for statistical analyses
#if you use 
na.omit(mdata)
#it will remove the entire row that includes the missing value
#back to our previous example of sub06 art test score
#the dataframe after the na.omit function does not include that row
#this means even though you had other measures for that test you can't look at them if you use na.omit

#please keep this in mind as you decide what to do with missing data








