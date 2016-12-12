d=read.csv("path/classroom_data.csv")
#check data
head(d)
str(d)
dim(d)

#change the sex column to a factor
d$sex=as.factor(d$sex)
str(d$sex)

#basic statistical analyses

#correlations
?cor.test
cor.test(d$test_score,d$hours_slept)

#can save the correlation as an object
c=cor.test(d$test_score,d$hours_slept)
c
#look at the components of the object c
names(c)

# Pearson's r correlation coefficent
c$estimate
#OR (using [])
?

#What does Pearson's r tell you?
#1. Direction of linear relationship
#2. Strength of relationship
#ranges from -1 to 1

#we will go over plotting in a lot of detail later but here is a quick preview
plot(d$test_score,d$hours_slept)

#correlation matrix
str(d)
#can only include numeric columns
cormatrix=cor(d[,c(2,4,5,6,7)])
cormatrix
#these are correlation coefficients

#exactly the same r values as if we conducted cor.test on every relationship:
a=cor.test(d$age, d$test_score)
a
a$estimate
#same as
cormatrix["age","test_score"]
#subsetting the row called "age" and the column called "test_score"

#correlation coefficient and the associated p value 
install.packages("Hmisc")
library(Hmisc)

#must convert data into a matrix
ndata=as.matrix(d[,c(2,4,5,6,7)])
rcorr(ndata)


# t test
?t.test
#this function can be used to run one sample t test, two sample t test, paired t test, one tailed t test?

#one-sample t-test
#necessary input arguments
#1. numeric vector of data values (i.e. d$hours_slept)
#2. mu = the true value of the mean if the null hypothesis is true

#Say students ages 13 to 15 sleep for an average of 8 hours (population mean)
#sample research question: Do our sample of students sleep the same number of hours as the entire population of students? 
#mu = population mean or "true mean"
#null hypothesis (H0) : mu = 8
#alternative hypothesis (HA) : mu != 8

#two-tailed t-test (the default in R)
t.test(d$hours_slept, mu = 8)
#interpretation: we reject the null hypothesis (H0) that our sample of students sleep the same average number of hours as the population of students

#if you made a SPECIFIC hypothesis about the direction of the results then you would use a one-tailed t-test
#one sided t tests
t.test(d$hours_slept, mu = 8, alternative="less")

#look what happens when the direction is incorrect
t.test(d$hours_slept, mu = 8, alternative="greater")


#two-sample t-test
#t.test(dependent_variable~independent_variable/group_column, data)
#note: this is the same as you input into the aggregate and summaryBy function for the formula argument!

#Is there a difference in how many hours males slept compared to females?
#H0: mean of hours males slept - mean of hours females slept = 0
#HA: mean of hours males slept - mean of hours females slept != 0

#dependent variable = hours_slept (must be a numeric column)
#independent variable = sex (is the group column)
# name of data frame = d
t.test(hours_slept~sex,d)
#Questions: Is there are difference in test scores between males and females?
#Answer: nope we accept the null hypothesis (H0)

#keep in mind you can always pull parts of the results
#how do I pull the estimate (or group means) out of the t.test object?
?

#An intervention was administered to all 95 students that included sleep education. We measured sleep, test scores, and test difficulty following the intervention.
s=read.csv("path/classroom_data_intervention.csv")
head(s)
str(s)
#notice that even though there are 190 observations there are only 95 levels for subject
dim(s)
#how do you we look at a summary of the number of data points for each subject?
?

str(s)
#change object type
s$sex=as.factor(s$sex)

#pre post intervention column
s$condition

#Our goal is to test whether the sleep education intervention increased the number of hours slept
ptest=t.test(?,s, paired=TRUE)
ptest
#look at the degrees of freedom (df) to verify whether you have ran the test correctly

length(levels(s$subject))
#we have 95 participants so the df should be n-1
#subtract 1 so df represents number of values that are free to vary

#look what happens if you do not do specify paired
t.test(?,s, paired=FALSE)
#the dfs are 180.66 which are incorrect
#NOTE: the dfs are estimates because we did not assume that the variance was equal. You can add var.equal=TRUE to make that assumption (I will show you how to test the assumption below)
t.test(?,s, paired=FALSE,var.equal=TRUE)

#print out the correct analysis
ptest

#This is how the mean difference score is calculated

#first we subset the data to create a dataframe called pre with only the hours slept before the intervention. Then we created a second dataframe called post which only included the data from the hours slept following the intervention
pre=s[s$condition =="pre",c("subject","hours_slept")]
post=s[s$condition =="post",c("subject","hours_slept")]
#then we take the mean of the difference between each participants' pre and post hours slept
mean(post$hours_slept-pre$hours_slept)
#matches this
ptest$estimate

#we can conclude that there was greater total sleep time at post time point because the pvalue is less than .05
ptest$p.value

#NOTE: It is important to make sure that the data for a paired t-test are sorted by subject and there are not missing observations, otherwise the pairing can be thrown off.

##Your turn!
#for the quiz you will be using the classroom_data_intervention.csv data

#1.Using our classroom intervention data set (s), please create a new data frame called post which only includes data from the post condition (include all of the columns)


#2. Using the post data, please run a correlation between test score and test difficulty


#3. Save the correlation to an object called cr then print out just the estimate


#4. What is the direction of the relationship? (write this as a comment)


#5. Back to the entire data frame called s, please test whether the test scores significantly changed from pre to post intervention (I am making not assumptions about the direction of the change)


##

#NOTE about assumptions
#the default of t.test assumes unequal variance, that is why the dfs are estimated. If you want to test whether the variance is equal, you can use the levene's test.
install.packages("car")
library(car)
leveneTest(hours_slept~sex,d)
#since this is not significant it means that the variances are equal
#if we want in our t-test we can specify
t.test(hours_slept~sex,d,var.equal=TRUE)
#does not differ to much from when var.equal=FALSE but the dfs are no longer fractions
t.test(hours_slept~sex,d,var.equal=FALSE)

####saving data out to a file
?write.csv #can also you write.table
#write.csv(dataframe, "path/filename.csv")

write.csv(post,"file",row.names=FALSE)
#row.names=FALSE will remove printing the row names to a column in your data file

#save output from an analysis in a file
?sink
#say you want to save a txt file with the output of an analysis examining the relationship between test difficulty and age
cor.test(s$test_difficulty,s$age)

#in the sink function put the name of the file you want to create that will hold your analysis output
#notice after we run sink no analyses will output to the console. Everything is now in the contents of the file you created
sink("path/analysis.txt")
cor.test(s$test_difficulty,s$age)
sink()
#you MUST end with this sink(). Everything before the last sink() will be written into the file.



