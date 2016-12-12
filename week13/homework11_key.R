
#1. Import UCDavis_again.txt an call it d (2pts)
#Don't forget that * means the data point is missing!
d=read.table("~/Dropbox/Classes/R course/lesson_plans/class_11_20_14/UCDavis_again.txt",header=TRUE,na.strings="*")
head(d)

#2. Examine the structure of the data to ensure that the data are in the right format (2pt)
str(d)

#3. Remove any row that includes a missing values (2pts)
d=na.omit(d) #151 observations
str(d)
#4. Print out the 150th row of the column Alcohol (2pts)
d[150,"Alcohol"] #6
#OR
d$Alcohol[150]

#5. Print out the 5th through the 20th row of columns GPA and Cheat (the dimension of your output should be 16 by 2) (2pts)

d[5:20, c("GPA","Cheat")]
#OR
d[5:20, c(2,13)]

#6. Create a new dataframe called smokers that includes only the people who reported Yes to smoking (include all the columns) (2pts)

smoking=d[d$Smoke=="Yes",]

#7. In the d dataframe, create a new column called height_feet by dividing the Height column by 12. (2pts)

d$height_feet=d$Height/12
head(d)

#8. Change the name of the Height column so that it is more descriptive by calling it height_inches. (2pts)

names(d)[6]="height_inches"

#9. Create a new column called subject where the subject numbers are in ascending order (i.e. row 1 subject is 1; row 2 subject is 2 etc...) (2pts)
dim(d)
d$subject=seq(1:151)
#OR
d$subject=c(1:151)

#10. Now that we have a subject column I want you to zero pad the subject column. For example you need to change the 1 in the subject column to 001 and so on, you will also have to change 50 to 050. Every subject number should have 3 digits. You have been given all the tools to do this but I will give you a hint: (5pts)
d$subject=as.character(d$subject)
#now think paste...

head(d)

for (i in 1:dim(d)[1]){
	if (i < 10){
		d$subject[i]=paste("00",d$subject[i],sep="")}
		if (i < 100 && i >9){
		d$subject[i]=paste("0",d$subject[i],sep="")}
else(d$subject[i] = d$subject[i])
}

#OR
d$subject[1:9]=paste(0,0,d$subject[1:9], sep="")
d$subject[10:99]=paste(0,d$subject[10:99], sep="")

#OR
d$subject=formatC(d$subject, width = 3, format = "d", flag = "0")
#OR
d$subject=sprintf("%03s", d$subject ) 


#11. Change the name of the levels in the column Hand to R and L (make sure the L replaces Left and R replaces Right!) (2pts)
levels(d$Hand)=c("L","R")

#12. What is the average GPA for all the subjects who said they would cheat on the exam (Yes in Cheat column)? (2pts)
cheaters=d[d$Cheat=="Yes",]
mean(cheaters$GPA)

#13. What are the mean GPAs for males and females? (2pts)
aggregate(GPA~Sex,d,mean)

#14. Assuming that the mean GPA of the college student population is 2.8, is this sample of college students significantly different from the population? Please let me in the form of a comment, what the results mean? (2pts)
t.test(d$GPA, mu = 2.8)
#Yes, these college students are significantly different from the population. Their mean GPA is significantly higher (M = 3.10)


#15. Is there a difference in Looks rating for people who are right and left handed? Explain the results in a comment. (2pts)
t.test(Looks~Hand,d) 

#16. Is there a difference in GPA across students who sit in the front (F), back (B), and middle (M) of the classroom? Please print of the results and report the t value. (2pts)
y=aov(GPA~Seat, d)
summary(y)
model.tables(y)
t=sqrt(2.618)

#there are unequal numbers in each group
library(car)
Anova(y,type="3")
#type 3 sum of squares did not make a difference in the results





