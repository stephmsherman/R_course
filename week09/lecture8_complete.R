##reshaping data
#helpful website - http://seananderson.ca/2013/10/19/reshape.html
#look at difference between wide and long format
#in R you need a column that specifies conditions in order to do anovas and linear regressions correctly

install.packages("reshape2")

library(reshape2)

#wide_format includes a data frame where 4 subjects responded to a target after seeing a happy, sad, or neutral face. Under each column is the mean RT for each category
wide_format=data.frame(sub=c("sub1", "sub2","sub3","sub4"),happy=c(200,220,216,230), sad=c(280, 250, 230, 240), neutral=c(240,210,230, 250))
wide_format

#what if we want to ask whether mean RT differed across the happy, sad, and neutral condition?
#in the anova function just like the t.test (as well as aggregate and summaryBy) you need to write a formula
#formula - numeric column ~condition column
#In the wide format you do not have a condition column so you need to change it from the wide format to the long format

#the melt function is used to change data frames from the wide to long format
long_format=melt(wide_format)
long_format
#the long_format data now includes a column to describe which type of target each RT corresponds to (variable column) and one column that represents the outcome values, RT

#now you can use the formula: numeric column ~ condition column : value column ~ variable column
###PREVIEW: WILL GO OVER THIS IN A LOT MORE DETAIL IN THE NEXT COUPLE OF WEEKS
analysis=aov(value~variable+Error(sub), long_format)
summary(analysis)

#for this dataset the default settings work very well
#BUT if we have a more complicated dataset then we will need to make further specifications

#we can also add new column names using the arguments:
#id.vars= column of ids (subjects)
#variable.name= column name for factor types
#value.name= column name for outcome variable
long_format2=melt(wide_format, id.vars="sub",variable.name="target_type", value.name="RT")
long_format2

#if you need to change your data from long form to wide form use dcast
?dcast
wide_format_back=dcast(long_format2,sub~target_type)
wide_format_back

wide_format2=dcast(long_format,sub~variable)
#the formula argument is a little different then what we are used to seeing. On the left side, you need to put the ID variable (id.vars) and on the right side you put the variables (variable.name)

#by default dcast knew that the numeric column was the values column, we can also this with - value.var
wide_format_back=dcast(long_format2,sub~target_type,value.var="RT")
wide_format_back
#now R does not tell you that it had to "guess"

##Import sleep_data_wide_format
s=read.csv("~/Downloads/sleep_data_wide_format.csv")
head(s)
#our goal is to change these data to long format
#Like this:

#sub sex age classes test_scores hours_slept test_difficulty
#             art
#            english
#            history
#             math
#            science


#melt works well for converting simple dataset to long format but if you want to convert a dataset with multiple measures you should use the reshape function

#our sleep_data_wide_format includes data from 20 subjects. Each subject has test scores, test difficulty ratings, and hours slept for 5 different classes (art, english, history, math, science)

#Here is the template for the reshape function
#we have to fill in the question marks
#reshape(data= ?, idvar= ?, timevar= ?,times= ?, v.names= ?, varying= ?, direction="long")

######Step 1######
#idvar = vector of variables that "identify" the participant
idvar=c("subject","sex","age")
idvar
#the idvar will not change across the measures that are repeated within a subject

######Step 2###### 
#create your new grouping column by specifying timevar and times 

#timevar= the name of the group variable
timevar=c("classes")
#classes is not currently a column in our dataset, but we would like classes to be the name of the grouping column in our final dataset in the long format

#times= the names that go in the times column, in other words what goes in the rows
times=c("art","english","history","math","science")
#end product so far will look like this: (first row is column names)
#sub sex age classes
#             art
#            english
#            history
#             math
#            science

#the order of the items in this vector is VERY important

######Step 3######
#v.names= name new columns with the values (the numeric columns)
names=c("test_score","hours_slept","test_difficulty")

#the end product so far is like this: (first row is column names)

#sub sex age classes test_scores hours_slept test_difficulty
#             art
#            english
#            history
#             math
#            science

######Step 4######
#now that we have set up the new columns with steps 1-3 we must fill in the values columns with the actual values

#varying= a set or "list" of vectors that correspond to one variable in the long-format
#list of measures

#created 3 vectors of each of our measures
#the order of the items in this vector must match our times vector c("art","english","history","math","science")

times
test_score=c("art.test.score", "english.test.score", "history.test.score", "math.test.score", "science.test.score")
hours_slept=c("art.hours.slept", "english.hours.slept", "history.hours.slept", "math.hours.slept", "science.hours.slept")
test_difficulty=c("art.test.difficulty", "english.test.difficulty", "history.test.difficulty", "math.test.difficulty", "science.test.difficulty")

#we need to combine these into one list
#we must put the list in the same order as the names vector because the names vector creates the new numeric columns
names 
varlist=list(test_score, hours_slept,test_difficulty)
varlist

#subset list 2
varlist[[2]]

######Step 5######
#put it all in the reshape function
#add name of data and direction
sleep_long=reshape(data=s, idvar=idvar, timevar=timevar, times=times,v.names=names,varying=varlist, direction="long")
sleep_long
head(sleep_long)
#compared to 
head(s)

#now we would be ready to conduct analyses to test whether test scores differ by classes (which is what we will be doing next class!)

write.csv(sleep_long,"path/sleep_data_long_format.csv",row.names=FALSE)
#compare original dataset with reshaped data

#SUMMARY OF RESHAPE ARGUMENTS
#idvar = vector of variables that "identify" the participant
#timevar= the name of the group variable
#times= the names that go in the timevar column, in other words what goes in the rows
#v.names= name new columns with the values (the numeric columns)
#varying= a set or "list" of vectors that correspond to one variable in the long-format; list of measures

#Your turn!

#you wanted to know whether test performance (performance) and awake rating (rating) changed across 3 times of the day (wake1, wake2, wake3)
#dataset called w includes 
w=data.frame(subject=c("subject1","subject2","subject3","subject4","subject5"),age=c(19,20,19,21,18),wake1.rating=c(2,2.5,4,3,2),wake2.rating=c(3,3,3.5,2.5,4),wake3.rating=c(3.5,4,5,3.5,4),wake1.performance=c(.84,.73,.72,.82,.87), wake2.performance=c(.89,.87,.78,.83,.91),wake3.performance=c(.89,.88,.90,.85,.93))
w
str(w)

##1. Put the dataset w in "long" format and call it w_long 

#Like this:

#subject age time_of_day rating performance
#				wake1 
#				wake2
#				wake3

#here is your skeleton
w_long=reshape(data=w, idvar=c("subject","age"), timevar="time_of_day" ,times=c("wake1","wake2","wake3") ,v.names= c("rating","performance"),varying=list(c("wake1.rating","wake2.rating","wake3.rating" ),c("wake1.performance","wake2.performance","wake3.performance" )),direction="long")
w_long

###

#how to change the order of the rows in your data frame

#if we want to put the subject column in increasing order we can use the order function with our subset syntax
?order
order(w_long$subject)
#the output of order is a vector of row numbers

#in order for our entire data set to be put in the order we must put the order function in the row part of our subset function
w_long[order(w_long$subject),]

#same as putting the row names in the order from the output of the order function
w_long[c(1,6,11,2,7,12,3,8,13,4,9,14,5,10,15),]

#you can also specify that decreasing =TRUE to put the rows in decending order
w_long[order(w_long$subject, decreasing=TRUE),]




