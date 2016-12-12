#Homework 3 Importing Data and Object Types
#You are going to import 2 very large datasets so I will give you hints along the way so you can check your work

#1. Import homework_data.txt and call it a (2pts)
a=read.table("~/Dropbox/Classes/R course/lesson_plans/class_09_11_14/data/homework_data.txt",header=TRUE, sep=",")
str(a)
#HINT: the dimensions of the data should be 32561 rows and 13 columns. Please make sure this is true before moving on

#2. Look at the levels(a$occupation) and notice that one level is a ?. In this dataset that means the values are missing. Please re-import the data and call it b. Specify in the read.table function that the missing value is "?" (2pts)
b=read.table("~/Dropbox/Classes/R course/fall_2015/lesson_plans/week3/homework_data/homework_data.txt",header=TRUE, sep=",",na.strings="?")
levels(b$occupation) 
b$occupation[31361]
#HINT: check str(b$occupation) to make sure ? is not longer a level. b$occupation[31361] was an ? now look at it and check that it is an <NA>

#3. Examine the structure of your dataframe called b (1pt)
str(b)
b$hours_per_week

#4. Print out the first few colums (head of data) (1pts)
head(b)

#5. Look at the levels of education using the levels() function. Print out the 10th level (2pts)
levels(b$education)[10]

#6. How many education levels are in this dataset? NOTE: Write the code that will output the number (2pts)
length(levels(b$education))

#7 Print out the age column (I know it is really long) (1pt)
b$age

#8. Create a new dataframe of only the female participants and call it f
f=b[b$sex=="Female",]


#9. Import USOpen_women_2013.csv data and call the data wtennis. Before you import it, open the file. See how the missing values are coded as "*" and "none." Make sure you import the data so that those values are all <NA> (2pts)
tennis=read.csv("~/Dropbox/Classes/R course/lesson_plans/class_09_11_14/homework_data/USOpen_women_2013.csv",na.strings=c("*","none"))
str(tennis)
#HINT: the dimensions of the data should be 76 rows and 42 columns. Please make sure this is true before moving on Look at the structure and make sure there are no "none" and "*" in the columns

#10. Look at the number of levels for Player.1 and Player.2. Please write a comment and explain why even though the lengths of the columns are the same there are a diffferent number of levels.

#11. Convert Player.1 and Player.2 columns into a characters (keep in mind this is just for practice, we may want these columns to be factors in subsequent analyses)
tennis$Player.1=as.character(tennis$Player.1)
str(tennis$Player.1)
tennis$Player.2=as.character(tennis$Player.2)
str(tennis$Player.2)


#12. ST2.1 is the Set 1 results for Player 2 and ST2.2 is the Set 2 Result for Player 2. Please add these columns together and label it as a new column called player2_sets
tennis$player2_sets= tennis$ST2.1 + tennis$ST2.2
head(tennis$player2_sets)


