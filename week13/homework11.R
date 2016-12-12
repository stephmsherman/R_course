
#1. Import UCDavis_again.txt an call it d (2pts)
#Don't forget that * means the data point is missing!



#2. Examine the structure of the data to ensure that the data are in the right format (2pt)



#3. Remove (omit) any row that includes a missing values and use that dataframe for the rest of the homework (2pts)



#4. Print out the 150th row of the column Alcohol (should be 1 number) (2pts)


#5. Print out the 5th through the 20th row of columns GPA and Cheat (the dimension of your output should be 16 by 2) (2pts)


#6. Create a new dataframe called smokers that includes only the people who reported Yes to smoking (include all the columns) (2pts)



#7. In the d dataframe, create a new column called height_feet by dividing the Height column by 12. (2pts)




#8. Change the name of the Height column so that it is more descriptive by calling it height_inches.(HINT: Height is the 6th column) (2pts)
#here is a good place to start
names(d)


#9. Add a new column called subject where the subject numbers are in ascending order (i.e. row 1 subject is 1; row 2 subject is 2 etc...) (HINT: should be a sequence from 1 to 151) (2pts)





#10. Change the name of the levels in the column Hand to R and L (make sure the L replaces Left and R replaces Right!) (2pts)



#11. What is the average GPA for all the subjects who said they would cheat on the exam (Yes in Cheat column)? (2pts)




#12. What are the mean GPAs for males and females? (2pts)



#13. Assuming that the mean GPA of the college student population is 2.8, is this sample of college students significantly different from the population? Please let me in the form of a comment, what the results mean? (2pts)


#14. Is there a difference in Looks rating for people who are right and left handed? Explain the results in a comment. (2pts)



#15. Is there a difference in GPA across students who sit in the front (F), back (B), and middle (M) of the classroom? Please print of the results and report the t value. (HINT: the anova is unbalanced so you need to use the car library) (2pts)
library(car)








