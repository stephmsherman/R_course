#Lecture 2 code

#Quick note about homework 2
#when you set a variable equal to an object that variable takes on the characteristics of that object

#IMPORTING DATA INTO R

#save your data as a .csv or .txt NOT .xls or .xlsx
#NOTE: there are ways to import excel files, SPSS files, SAS files etc. I will not be going over that but refer to the Helpful websites section on the syllabus for that information 

#Download csv_data.csv,comma_delimited.txt, tab_delimited_data.txt, quiz_data.txt, tricky_data.txt, object_types.csv from Canvas and save it somewhere on your computer

#look at help menu for the function used to import data
?read.table

#Important questions to ask yourself when importing data
## where did you save your data? (the path)
## is there a header? (do you have column names in the file?)
## how are the data separated? (commas, spaces, tabs?)

## We are going to import csv_data.csv first
#1. First input argument of the function is file
#read.table(file, )
# this includes the file name AND the path to the file

#Getting the path
## Mac users: from the finder you can drag the file into your R script and it will give you the path
## Windows users: go to the file "Properties" and copy the path from the "Location:"

#paste the path where is says path below
read.table("path/csv_data.csv")
#put path name in quotes because it is not an object in R
#IMPORTANT note for Windows users- even though your path includes \ change to /

#2. Does your file have a header (column names)?
#if so add another input argument : header = TRUE to your function
#if not: header = FALSE
read.table("path/csv_data.csv",header=TRUE)

#3. How are your data separated?
#csv stands for comma separated values so we know this file is sep = ","
#again put the comma in quotes because it is not an object in R
#NOTE: don't put the name of the delimiter (separater) between the quotes put the symbol i.e. sep = " " (separated by a space)
read.table("path/csv_data.csv",header=TRUE, sep = ",")

#run the command above
#How do you save this data frame as an object in R?
data=read.table("path/csv_data.csv",header=TRUE, sep = ",")

#4. CHECK THE DATA FRAME
head(data)#look at first few rows of your data
str(data) #check the structure
dim(data) #check the dimensions 

#Import comma_delimited_data.txt and called it data2
# path?
read.table("path/comma_delimited_data.txt")
#header?
read.table("path/comma_delimited_data.txt",header=TRUE)
#how are data separated?
data2=read.table("path/comma_delimited_data.txt",sep=",")
#4. CHECK!
head(data2)
str(data2)
dim(data2)

#What happens if you import your data incorrectly
#incorrect header argument
data2_wrong1=read.table("path/comma_delimited_data.txt",header=FALSE, sep = ",")
head(data2_wrong1)
str(data2_wrong1)
dim(data2_wrong1)

#incorrect separater argument
data2_wrong2=read.table("path/comma_delimited_data.txt",header=TRUE, sep = "")
head(data2_wrong2)
str(data2_wrong2)
dim(data2_wrong2)
###R did not give you an error even though your data were imported incorrectly
#R shows you what the delimiter is when you mess up
##THIS IS WHY IT IS SOOO IMPORTANT THAT YOU COMPLETE THE LAST STEP AND CHECK YOUR DATA

##Your turn!
#Import quiz_data.txt
#Walk through each step carefully and assign the data frame to an object called data3 Please only enter the code NOT the output.
data3=read.table("path/quiz_data.txt",header=FALSE,sep="\t")
#OR
data3=read.table("path/quiz_data.txt",header=FALSE,sep="")

#if you want to add column names
names(data3)
names(data3)=c("hours_slept","test_scores")

#Now you can import "nice" data
#let me show you a few tricks if your data are not cooperating

#Import tab_delimited_data.txt
#look at data
#In this file I coded the missing values as 999
#specify with na.strings
 t=read.table("path/tab_delimited_data.txt", header=TRUE, sep ="	",na.strings="999")
#OR
t=read.table("path/tab_delimited_data.txt", header=TRUE, sep ="\t",na.strings="999")
#OR
t=read.table("path/tab_delimited_data.txt", header=TRUE, sep ="",na.strings="999")
t
str(t)
#Import tricky_data.txt
#What do you notice about the data?
#there are comments at the top so add comment.char

#first let's specify the character for the comments
#we are going to ignore how the data are separated
data4=read.table("path/tricky_data.txt", header=TRUE, sep ="",na.strings="999",comment.char="*")
head(data4)
str(data4)
dim(data4)

#since you see that the data are separated by / change the sep argument
data4=read.table("path/tricky_data.txt", header=TRUE, sep ="/",na.strings="999",comment.char="*")
head(data4)
str(data4)
dim(data4)

#If you specify the incorrect path you will get the error below
#Error in file(file, "rt") : cannot open the connection
# In addition: Warning message:
# In file(file, "rt") :
  # cannot open file '/Users/stephanie/Classes/R course/lecture_2/tab_delimited_data.txt': No such file or directory 


#Different types of objects in R
#character: a string of letter and/or numbers
#factor: treated as a category 
#numeric: number with decimals
#integer: whole number
#logical: TRUE/FALSE

#import object_types.csv and call it all
#I am going to use read.csv instead of read.table because I do not have to add additional arguments
?read.csv #defaults to header=TRUE unlike read.table and defaults to sep ","
all=read.csv("path/object_types.csv")
head(all)
dim(all)
#look at the structures of our new columns - subject, sex, initials, complete
str(all)

#subject column
#what type of format do we want
#factor
is.factor(all$subject)

#sex column (male = 0, female = 1)
#what type of format do we want?
#it is an integer which does not make sense
as.factor(all$sex)

#look at data frame 
str(all$sex)

#why did the column sex not convert to a factor?
all$sex=as.factor(all$sex)

#now look 
str(all$sex)
levels(all$sex)
#look at the initials column
#what type of format do we want?
#the length of the levels 
str(all$initials)
levels(all$initials)
length(levels(all$initials))
#we want 20 levels but the length is only 18 because some people had the same initials

#it should be just characters
all$initials=as.character(all$initials)
str(all$initials)

##NOTES
#say condition was a factor and you wanted to convert it back to a numeric 

all$condition_ex=as.factor(all$condition)
all$condition_ex=as.numeric(all$condition_ex)

#look what happens  
all[,c("condition","condition_ex")]
#run this
all$condition=as.factor(all$condition)
#if you want to convert a factor to a number you must first change it into a character
str(all$condition)
all$condition=as.character(all$condition)
str(all$condition)
all$condition=as.numeric(all$condition)
str(all$condition)

#Importance of zero padding
all$subject_no_zeros=as.factor(c("sub1","sub2","sub3","sub4","sub5","sub6","sub7","sub8","sub9","sub10","sub11","sub12","sub13","sub14","sub15","sub16","sub17","sub18","sub19","sub20"))

all

##look at the order of the levels
#alpha numeric
levels(all$subject_no_zeros)
#compared to this
levels(all$subject)










