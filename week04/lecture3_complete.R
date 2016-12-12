#ifelse statements and loops

#What is a loop and why do you use it?
###use loops do repeat the same procedure multiple times

#data file is in the class_data.zip from Week 3: September 15th Module on Canvas
data=read.csv("~/Downloads/class_data/object_types.csv")
head(data)
str(data)


##structure of for loop
# for(variable in sequence) {
    # statements
# }

#Basic for loops
for (i in 1:20){
	print(i)
}
#this code is saying print each value for i of the sequence 1 to 20

#a lot of people use i but you can use any variable name
for (participant in 5:10){
	print(participant)
}

#now this code is saying print the value for participant of the sequence 5 to 10

for (i in 1:20){
	print(data$test_scores[i])
}

#See what it did?
#it iterated through data$test_scores and printed out each score
1:20 #print out items 1 to 20 of the data$test_scores column

data$test_scores
#starting with 
data$test_scores[1]
data$test_scores[2]
#etc...

#say the professor decided to add 5% to everyone's test score 
for (i in 1:20){
	data$test_scores_curve[i]=data$test_scores[i]+.05
}

#let's look
data[,c("test_scores","test_scores_curve")]

#first iteration did this:
data$test_scores[1]+.05 
#this is now the value that is in
data$test_scores_curve[1]

#second iteration did this:
data$test_scores[2]+.05 
#this is now the value that is in
data$test_scores_curve[2]

#what did the last iteration do?
data$test_scores[20]+.05
data$test_scores_curve[20]

#NOTE about syntax: curly braces let a computer know what to keep together
#paratheses specify arguments


#write a for loop for sequence 1:20 to create a new column in data called minutes_slept that takes hours_slept and multiplies it by 60
for (i in 1:20){
	data$minutes_slept[i]=data$hours_slept[i]*60
}

data[,c("minutes_slept","hours_slept")]

#We would rather not "hard code" length (20), instead we would rather change the length to a variable so that it will depend on the length of our data frame
num=dim(data)[1]
num

for (i in 1:num){
	data$minutes_slept[i]=data$hours_slept[i]*60
}
data[,c("minutes_slept","hours_slept")]


##removing columns
data
#quickest way to remove one column
data$minutes_slept=NULL
head(data)

#Setting conditionals with ifelse statements

#basic ifelse statement
?ifelse
#ifelse(test, true_value, false_value)
#NOTE: test is a logical argument, if you ran the test input argument alone you should get TRUE/FALSE output

#say we want to convert the sex column so that instead of 0 it says male and instead of 1 it says female
data$sex2=ifelse(data$sex==0, "male","female")

#so every item where data$sex==0 is TRUE will now equal "male" and every item where data$sex==0 is FALSE will now equal "female" in the column data$sex2
data$sex==0
data$sex2

#so the 5th participant is male, in data$sex there is a 0 so in data$sex2 now there is "male"
(data$sex==0)[5]
data$sex2[5]

#check your work
data[,c("sex","sex2")]
#why did I put male and female in quotes?
#not objects in R
male
female

#say I want to label everyone who got less than 6 hours of sleep as a poor_sleeper and everyone else as a good_sleeper and put those values in a new column called sleep_quality

data$sleep_quality=ifelse(data$hours_slept<6, "poor_sleeper","good_sleeper") 

data$hours_slept<6
data$sleep_quality

(data$hours_slept<6)[1]
data$sleep_quality[1] 

#check
data[,c("hours_slept","sleep_quality")]

#using ifelse is easier but it is the same as the for loop and if else below:

for (i in 1:dim(data)[1]){
if(data$hours_slept[i]<6){
	data$sleep_quality_new[i]="poor_sleeper"}
	else {data$sleep_quality_new[i]="good_sleeper"}
		}

#check
data[,c("hours_slept","sleep_quality","sleep_quality_new")]

#Let's break down the structure of the loop
#the for line says it is going to iterate over the following numbers
1:dim(data)[1]

#the if line says if this logical statement is true then that case will do whatever is inside the curly braces
#when the statement is TRUE:
data$hours_slept[4]
data$hours_slept[4]<6
#because it is TRUE sleep_quality_new[4] was assigned to "poor_sleeper
data$sleep_quality_new[4]
#when the statement is FALSE:
data$hours_slept[12]
data$hours_slept[12]<6
#because it is FALSE sleep_quality_new[12] was assigned to "good_sleeper
data$sleep_quality_new[12]

#make sense?


#the basic ifelse statement works great for two conditionals but what if you have more than 2?

#let's assign letter grades to test scores
for (i in 1:dim(data)[1]){
if(data$test_scores[i]>=.9){
	data$letter_grades[i]="A"}
	else if (data$test_scores[i]>=.8){
	data$letter_grades[i]="B"}
	else if (data$test_scores[i]>=.7){
	data$letter_grades[i]="C"}
	else if (data$test_scores[i]>=.6){
	data$letter_grades[i]="D"}
	else {data$letter_grades[i]="F"}
		}
		
data[,c("test_scores","letter_grades")]
#cover all possible scenerios in your loops
#be careful- if the conditions are not in the right order then you will run into problems


#Your turn!
#1. Write a loop to assign letter grades based on the curved score (use the test_scores_curve column) and call the new column letter_grades_curve (HINT: modify the loop we wrote above)
for (i in 1:dim(data)[1]){
if(data$test_scores_curve[i]>=.9){
	data$letter_grades_curve[i]="A"}
	else if (data$test_scores_curve[i]>=.8){
	data$letter_grades_curve[i]="B"}
	else if (data$test_scores_curve[i]>=.7){
	data$letter_grades_curve[i]="C"}
	else if (data$test_scores_curve[i]>=.6){
	data$letter_grades_curve[i]="D"}
	else {data$letter_grades_curve[i]="F"}
		}

data[,c("test_scores_curve","letter_grades_curve")]
#2a. Using the test_scores_curve column create a new column called pass_fail where everyone who receives greater than or equal to a .60 passes (HINT: ifelse)
data$pass_fail=ifelse(data$test_scores_curve>=.6,"pass","fail")

#2b. please include the subset command I have used several times to print out only the test_scores_curve and the pass_fail column to check your work
data[,c("pass_fail","test_scores_curve")]

#3. Write a loop to create a new column called student_type where:
#"good" test score is greater than or equal to .8
#"good" night of sleep is greater than or equal to 6 hours
#(use the test_scores column and the hours_slept column)

#if a student receives a "good" test score and a "good" night of sleep label them as a "ideal"
#else if a student receives a "bad" test score and a "good" night of sleep label them as a "unlucky"
#else if a student receives a "bad" test score and a "bad" night of sleep label them as a "not_ideal"
#otherwise label them as "lucky"
#I know this is difficult so here is the skeleton
for (s in 1:dim(data)[1]){
	if(data$test_scores[s]>=.8 & data$hours_slept[s]>=.6){
	data$student_type[s]="ideal"}
	else if (data$test_scores[s]<.8 & data$hours_slept[s]>=.6){
	data$student_type[s]="unlucky"}
	else if (data$test_scores[s]<.8 & data$hours_slept[s]<.6){
	data$student_type[s]="not_ideal"}
	else {data$student_type[s]="lucky"}
		}
#don't forget to check your work
data[,c("student_type","hours_slept")]

####
##common error
#There were 20 warnings (use warnings() to see them)
#it says 20 warnings because I have 20 rows
#look at warnings
# warnings()
# Warning messages:
# 1: In if (data$test_scores >= 0.8 & data$hours_slept[i] >=  ... :
  # the condition has length > 1 and only the first element will be used

#the solution:make sure you have [i] after every variable name











