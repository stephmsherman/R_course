#Homework 4 - Loops and if else statements 

#1. Import homework_data.txt from the Modules Class on 9/11 (2pt) and call it h. Remember to add an input argument for missing data value = ?

h = read.table("~/Dropbox/Classes/R course/fall_2015/lesson_plans/week3/homework_data/homework_data.txt",header=TRUE, sep= ",",na.string="?")

#2. Using the hours_per_week column, create a new column called job_status where everyone who works less than or equal to 20 hours is "part_time" and everyone else works "full_time" (3pts)

h$job_status=ifelse(h$hours_per_week<=20,"part_time","full_time")
h[,c("job_status","hours_per_week")]

#3. Look at the structure of the job status column you created - str(h$job_status). Convert this column into a factor (keeping the same name). (2pts)
str(h$job_status)
h$job_status=as.factor(h$job_status)
str(h$job_status)

#4.Look at the levels of the income column. Change the names to "less_than_50k" and "greater_than_50k." NOTE: It is possible to do in one line of code. (3pts)
levels(h$income)=c("less_than_50k","greater_than_50k")
levels(h$income)


#5. Using the age column, create a new column called age_category where:
#anyone ages 17 -30 is young_adult, 31 -59 is middle_aged , and ages 60 -90 is older_adult. Use a loop. It may take a little while to run (4pts) 

for (i in 1:dim(h)[1]){
	if (h$age[i]<31){
	h$age_category[i]="young_adult"}
	else if(h$age[i]<60){
		h$age_category[i]="middle_aged"}
		else(h$age_category[i]="older_adult")
	}

tail(h[,c("age_category","age")],60)

#6. In R loops can be really slow, so I want you to explore other ways to get the same results without using a loop. Please use the age column to create a new column called age_category2 that looks the same as age_category (criteria: anyone ages 17 -30 is young_adult, 31 -59 is middle_aged , and ages 60 -90 is older_adult). Use the subsetting commands we discussed in Lecture 1 to create this column from the age column. (4pts)

#HINT: Start with the line of code below. This creates the age_category2 column in your h data frame with all zeros. Use subsetting to replace parts of the column to fit the criteria above. (think: h$age_category2[logical_argument])
h$age_category2=rep(0,dim(h)[1])
h$age_category2[h$age<31]="young_adult"
h$age_category2[h$age>30 & h$age<60]="middle_aged"
h$age_category2[h$age>59]="older_adult"


#or 
h$age_category2=rep(0,dim(h)[1])
h$age_category2[h$age<=30]="young_adult"
h$age_category2[h$age>30 &h$age<=59]="middle_aged"
h$age_category2[h$age>59]="older_adult"
head(h[,c("age","age_category2")],100)



