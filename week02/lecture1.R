#Lecture 1 code

# the hash is used as a comment.  You can use it in the beginning of a line or after an R command

# How to run code from your script:
## Windows: "control R"
## Mac: "command return"
 
# Various methods of defining variables
a = 3 #this assigns the 3 to the variable a
b <- 3 #this assigns the 3 to the variable b

# print results
a
b

#run the line below
#a = 4

#print a
a
#because there is a hash in front of this assignment it will not change a to equal 4
#if you would like to take additional notes please use the hash 

#can use R as a calculator
a+b

#create a vector
vector = c(3,5,7,1,5,1,2,8,2)
#print out vector
vector

#Show tab function and up arrow#

# c is function 
#basic structure of R functions
#function_name(input_argument,input_argument,etc)

#help menu for function c
?c

#subsetting vectors
vector
#subset first item of vector
vector[1]

#subset the third item
vector[3]

#subset items 1 to 3
vector[1:3]

#subset items 1 and 3
vector[c(1,3)]

#why do you need a "c" in front of the 1,3 and not in front of the 1:3?

#run what is inside the vector [] alone
1:3
1,3

#if you get an error when you run the part that is inside the [] alone, then you need to use a "c" to tell R that you want to subset more than 1 item
c(1,3)

#print out vector again
vector
#remove item 2 from vector
vector[-2]

#notice how the vector still includes the item 2
vector

#if you want to remove the item 2 from vector you need to assign the function to a variable
new_vector=vector[-2] 

#look at new_vector
new_vector

#Your turn! 
#You have a vector of how many hours a group of 20 student slept last night.
hours_slept=c(6,7,6.5,5,7,8,8,7.5,4,9,6,6.7,5,5,5.5,6,7.5,4,8,8)
hours_slept

#Print out how many hours the 8th student slept last night
?

#Assign the first 10 students to a new vector called hours_slept10
?

#Remove the 2nd student and the 20th student's score from the hours_slept vector in a new vector called hours_slept_no2_20
?


########

#create a data frame
#say we collected hours of sleep AND test scores
test_scores=c(.80,.85,.80,.70,.90,.90,.92,.87,.60,.87,.81,.90,.70,.77,.82,.93,.92,.74,.84,.95)
test_scores

#let's put test scores and hours slept into a data frame
data=data.frame(hours_slept,test_scores)

#look at the data frame
data

#row columns
dim(data)
#Can you print out just the number of rows? (same as subsetting numbers in a vector)
?

#characteristics/structure of data
str(data)
#use $ to subset a column of the data (tells you to use $ in str())
data$hours_slept

#print hours_slept from the 9th student 
data$hours_slept[9]

#subsetting rows and columns from a data frame
# data[rows,columns]

#print out data
data

#print the number in the first row and second column
data[1,2]

#print rows 1 through 5 and only column 1
data[1:5,1]

#this time print rows 1 through 5 and ALL columns
data[1:5,]
#if you want to print either all rows or all colums must leave that portion blank

#Can you create a new data frame called data2 with only the first and last participant?
?

## LOGICAL ARGUMENTS
#now we want to subset the data by a logical argument

#here is an example where a = 5
a=5
a

##when we use 2 equal signs we are asking a logical question
a==5
a==6

# != means does not equal
a!=5

#can also use these
a<4
a>4
a>=5
a<=10

#back to our data frame
#print the all the columns for the students who slept 5 hours
data[data$hours_slept==5,]

#print only the test scores for students who slept 5 hours
data[data$hours_slept==5,2]
#OR
data[data$hours_slept==5,"test_scores"]

#print all the columns for students who slept less than 7 hours
data[data$hours_slept<7,]

#print all columns for students who slept less than 5 hours AND got better than or equal to .80 test score
data[data$hours_slept<7 & data$test_scores>=.80,]

#print all columns for students who slept less than 5 hours OR got better than or equal to .80 test score
data[data$hours_slept<7 | data$test_scores>=.80,]


##FLEXIBILITY OF DATA FRAMES

#say you want to create a minutes of sleep column

minutes_slept=data$hours_slept*60
minutes_slept
#no minutes_slept column in data?
data

#you need to put a data$ in front of a column name in order to put it in the data frame
data$minutes_slept=data$hours_slept*60
data
#Can you create a new column called blank where you the data in the rows match the row numbers?
?

#say for some reason I want to a new column of the blank column minus the test scores column called subtraction 
data$subtraction=data$blank-data$test_scores
data


#look at variables or objects in workspace
ls()
#clear variables in workspace
rm(list=ls())
ls()













