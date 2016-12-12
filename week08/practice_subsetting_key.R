#1. Import homework_data.txt from Week 3 on canvas and call it s. Specify in the read.table function that the missing value is "?"
#HINT: the dimensions of the data should be 32561 rows and 13 columns. Please make sure this is true before moving on

s=read.table("path/homework_data.txt",header=TRUE, sep=",",na.string="?")
str(s)

#2. Create a dataframe called d that only includes people who are divorced (info from the martial_status column)

d=s[s$marital_status=="Divorced",]
head(d)
#check
#in your new dataframe you should have ALL TRUES
summary(d$marital_status=="Divorced")

#3. Create a dataframe called m that includes all participants who are not divorced.

m = s[s$marital_status!="Divorced",]
head(m)
#check
#in your new dataframe you should have ALL TRUES
summary(m$marital_status!="Divorced")

#4. Create a dataframe called high_school that includes the participants who have between 9 and 12 years of education (information from the education_num column)

high_school = s[s$education_num>=9 & s$education_num<=12,]
#check
range(high_school$education_num)
#OR
summary(high_school $education_num>=9 & high_school$education_num<=12)

#5. Create a dataframe called t that includes all the rows but only the "age", "occupation" and "hours_per_week" column

t = s[,c("age","occupation","hours_per_week")]
head(t)

#6. Create a dataframe called data where particpants are either Male OR work 40 hours per week

data = s[s$sex =="Male" | s$hours_per_week==40,]
#check
head(data[,c("sex","hours_per_week")])
#check
#in your new dataframe you should have ALL TRUES
summary(data$sex=="Male"|data$hours_per_week==40)


#7. Create a new dataframe called tech with only Black Females who work in Tech-support. Remove NAs from the dataframe after subsetting using na.omit. 

tech=s[s$sex=="Female" & s$occupation=="Tech-support" & s$race=="Black",] 
tech=na.omit(tech)

#check
summary(tech$sex=="Female" & tech$occupation=="Tech-support" & tech$race=="Black")


