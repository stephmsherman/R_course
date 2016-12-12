#Graphing in R
#import the classroom_data.csv from Module Week 6: October 5th on canvas
g=read.csv("classroom_data.csv")
head(g)
str(g)

#check that your columns have the correct object types
#change the objects to the correct type
#the sex column was an integer and we want it to be a factor
g$sex=as.factor(g$sex)

#histograms
#look at the help menu for how to create a histogram
?hist
#notice that there are a lot of possible arguments we can input. 

#First we are just going to start by inputting x - our data
hist(g$test_score)
#this histogram shows us the distribution of test scores
#in other words, how many people earned each test score 

#change breaks
hist(g$test_score, breaks=5)

#change limits on x axis with xlim
#xlim=c(lower_limit, upper_limit)
hist(g$test_score,breaks=5, xlim=c(.5,1))
#we need to expand the upper limit and shorten the lower limit
hist(g$test_score,breaks=5, xlim=c(.6,1.1))

#change limits on y axis with ylim
hist(g$test_score,breaks=5, xlim=c(.6,1.1),ylim = c(0,35))

#change names on axes and title
#main="title" 
hist(g$test_score,breaks=5, xlim=c(.6,1.1), ylim = c(0,35), 
     main="Histogram of Test Scores")

#xlab (label on x axis) and ylab (label on y axis)
hist(g$test_score,breaks=5, xlim=c(.6,1.1),ylim = c(0,35),
     main="Histogram of Test Scores", 
     xlab="test scores", ylab="frequency")

#col ="colors"
hist(g$test_score,breaks=5, xlim=c(.6,1.1),ylim = c(0,35), 
     main="Histogram of Test Scores", xlab="test scores", 
     ylab="frequency",col="blue")

exes = seq(min(g$test_score), max(g$test_score), length.out = length(g$test_score))
whys = dnorm(exes, mean(g$test_score), sd(g$test_score))
hist(g$test_score, breaks=10, xlim=c(.6,1.1), ylim = c(0,4), main="Histogram of Test Scores", xlab="test scores", ylab="relative frequency", freq=F)
lines(exes, whys, col = 2)

##scatterplot
?plot

#can plot one variable
plot(g$test_score)
#index represents observation/row number

#can plot correlations
#shows relationship between test scores and hours slept
plot(g$test_score,g$hours_slept)

#I added the x and y axis limits to the plot. Please add the labels to the x and y axes along with a title (same input arguments as the histogram)
plot(g$test_score,g$hours_slept, xlim=c(.6,1.01), ylim=c(5.2,8.5))

#change the types of dots with pch
?pch
#change to filled in squares that are red
plot(g$test_score,g$hours_slept, xlim=c(.6,1.01),ylim=c(5.2,8.5))
plot(g$test_score,g$hours_slept, xlim=c(.6,1.01),ylim=c(5.2,8.5), 
     main="Correlation Plot of Test Scores", xlab="test scores", 
     ylab="frequency", pch=15, col="red")


#adding plots with different color data points
#make the data points from the first 50 participant red and the last 50 participants blue
first50 = g[1:50,]
last50 = g[51:100,]

#plot first 50 in red
plot(first50$test_score, first50$hours_slept, pch=15, col="red", 
     xlim=c(.6,1.01),ylim=c(5.2,8.5), xlab="Test Scores",
     ylab="Hours Slept")
#keeping the plot window from the first graph open 
#add a plot using the par function
par(new=TRUE)
#plot last 50 in blue
plot(last50$test_score, last50$hours_slept, pch=15, col="blue", 
     xlim=c(.6,1.01),ylim=c(5.2,8.5), xlab="", ylab= "", 
     xaxt='n', yaxt='n')
#in order for you to add a graph using par(new = TRUE), you must keep xlab and ylab empty, include the same xlim and ylim, and include xaxt and yaxt = 'n' saying that you do not want axis numbers for second graph

#OR

#can use ifelse function within color 
#if a participant received less than .8 on the test then we 
# want their datapoint to be red otherwise it should be blue
#col=ifelse(g$test_score<.8,"red","blue")

plot(g$test_score,g$hours_slept, pch=15, 
     col=ifelse(g$test_score<.8,"red","blue"), 
     xlim=c(.6,1.01),ylim=c(5.2,8.5), 
     xlab="Test Scores",ylab="Hours Slept")
#you can use ifelse function in most of the graphing parameters

plot(g$test_score,g$hours_slept, pch=15, 
     col=ifelse(g$sex=="1","red","blue"), 
     xlim=c(.6,1.01),ylim=c(5.2,8.5), 
     xlab="Test Scores",ylab="Hours Slept")

#shape of data point
#not only do we want participants who receive less than .8 on 
# the test to be blue but we also want the shape of the 
# data point to be triangle, otherwise we want the datapoint to be a diamond
#pch=ifelse(g$test_score<.8,18,24)

plot(g$test_score,g$hours_slept, 
     pch=ifelse(g$test_score<.8,18,24), 
     col=ifelse(g$test_score<.8,"red","blue"), 
     xlim=c(.6,1.01),ylim=c(5.2,8.5), 
     xlab="Test Scores",ylab="Hours Slept")

#adding a legend
#legend(where you want the legend, names on legend, pch=shapes of legend labels that must be in same order as legend names, col=colors that also must be in same order as legend names)
legend("bottomright", c("Failing Scores","Passing Scores"),
       pch=c(18,24), col=c("red", "blue"))

#you can also place the legend at certain coordinates
plot(g$test_score,g$hours_slept, pch=ifelse(g$test_score<.8,18,24), col=ifelse(g$test_score<.8,"red","blue"), xlim=c(.6,1.01),ylim=c(5.2,8.5), xlab="Test Scores",ylab="Hours Slept")
legend(.85,6, c("Failing Scores","Passing Scores"),pch=c(18,24), col=c("red", "blue"))
# .85 on x axis and 6 on y-axis

#add regression line for line of best fit
abline(lm(g$hours_slept~g$test_score))

#add the parameters lwd and lty to the abline line. 
# Set them at any number between 1 and 3 and see what happens
plot(g$test_score,g$hours_slept, pch=ifelse(g$test_score<.8,18,24), 
     col=ifelse(g$test_score<.8,"red","blue"), 
     xlim=c(.6,1.01),ylim=c(5.2,8.5), xlab="Test Scores",
     ylab="Hours Slept")
legend(.85,6, c("Failing Scores","Passing Scores"),
       pch=c(18,24), col=c("red", "blue"))
abline(lm(g$hours_slept~g$test_score), lwd=2, lty=2)

##add text
#keep plot window open
cor.test(g$hours_slept,g$test_score)
text(.7, 5.3, "r = .45, p < .000001, n = 95")

#1. Create a scatterplot where hours_studied is on the x-axis and test_score is on the y-axis
#-Add x label: Hours Studied
#-Add y label: Test Scores
#-Add title: The relationship between hours studied and scores on test
#-If the student slept less than 7 hours then make their data point red stars and everyone who received greater than or equal to 7 make their data point black circles
#add line of best fit (regression line)
#add legend at top left corner

#answer
plot(g$hours_studied, g$test_score, xlab = "Hours Studied", 
     ylab = "Test Scores", 
     main="The relationship between hours studied and scores on test", 
     col=ifelse(g$hours_slept<7, "red","black"), 
     pch=ifelse(g$hours_slept<7, 8,16))
abline(lm(g$test_score~g$hours_studied))
legend("topleft", c("Students who slept < 7 hours", 
        "Students who slept <= 7 hours"),
       col=c("red","black"), pch=c(8,16))






###
#two more graphing tricks

#we can make the text/data points larger using cex (cex.axis, cex.lab, cex.main etc)
#cex makes data points larger
plot(g$hours_slept, g$test_score, cex=1.5)
#cex.lab makes the labels larger
plot(g$hours_slept, g$test_score,xlab="hours slept",ylab="test scores", cex.lab=1.5)
#cex.axis makes the axis numbers large
plot(g$hours_slept, g$test_score,xlab="hours slept",ylab="test scores", cex.lab=1.5, cex.axis=1.5)
#cex.main makes the title larger
plot(g$hours_slept, g$test_score,xlab="hours slept",ylab="test scores", main="hours slept x test scores",cex.lab=1.5, cex.axis=1.5, cex.main = 1.5)

#you can change the direction of the axis labels with las
plot(g$hours_slept, g$test_score,xlab="hours slept",
     ylab="test scores", main="hours slept x test scores",
     cex.lab=1.5, cex.axis=1.5, cex.main = 1.5, las=1)
#see how the numbers on the y axis changed?
#now look at the other options
plot(g$hours_slept, g$test_score,xlab="hours slept",ylab="test scores", main="hours slept x test scores",cex.lab=1.5, cex.axis=1.5, cex.main = 1.5, las=2)
plot(g$hours_slept, g$test_score,xlab="hours slept",ylab="test scores", main="hours slept x test scores",cex.lab=1.5, cex.axis=1.5, cex.main = 1.5, las=3)

#boxplot
#dark line is the median of the test scores
boxplot(g$test_score)
#some types of graph have an add argument so you do not have
# to use par(new=TRUE)
#stripchart adds data points to your graphs
stripchart(g$test_score,vertical =TRUE, add=TRUE, pch=18)

#you can also use the formula structure we have been talking 
# about to graph test scores separated by test difficulty
boxplot(g$test_score ~ g$test_difficulty, ylab="Test Scores", 
        xlab="Test Difficulty")
#add data points
stripchart(g$test_score~g$test_difficulty, vertical=TRUE, add=TRUE, pch=21)

#bar plots
#the basic barplot function in R works really well but this barplot2 function in the gplots library allows you to add error bars/confidence intervals
#remember you should only have to install packages once on your computer but every time you open a new R session you will need to run the library(gplots)
install.packages("gplots")
library(gplots)
#take a look at the barplot2 function
?barplot2

#we are going to need this standard error function to draw error bars of 
# the standard error
#function to calculate standard error
stderr = function(x){
	 sqrt(var(x,na.rm=TRUE)/length(na.omit(x)))
}
#create vectors of the mean and standard error using tapply
#tapply is very similar to aggregate and summaryBy 
?tapply	 
m=tapply(g$test_score, g$test_difficulty, mean)
#m now includes the mean test score at each level of test difficulty
m
se=tapply(g$test_score,g$test_difficulty,stderr)
#se includes the standard error of test scores at each level of test difficulty
se
##plot means
barplot2(m,xlab="Level of Test Difficulty", ylab="Test Score")

#adding error bars 
#first create a vector of the lower bar and upper bar points
lower_bar = m - se
upper_bar = m + se
#your means vector and error bar vectors must line up and have the same dimensions
m
lower_bar
upper_bar
#great, they all have 4 items with labels for each item

#Also the first items in each vector must all be describing the same bar
m[1] #mean of 0 test difficulty
upper_bar[1] #upper error bar point for 0 test difficulty
lower_bar[1] #lower error bar point for 0 test difficulty

#within the barplot2 function, set plot.ci to TRUE and set the ci.l (confidence interveral lower) and ci.u (confidence interval upper) to the vectors you created
barplot2(m,xlab="Level of Test Difficulty", ylab="Test Score",
         plot.ci=TRUE, ci.l=lower_bar, ci.u=upper_bar, 
         las=1, col=c("orange red", "red2","red3","red4","dark red"))
#for fun a made each bar a different shade of red

#multi-panel graphs

#par functions are useful to change the plot window
#the mfrow part is saying we want to create a panel of graphs with 1 row and 2 columns
par(mfrow=c(1,2))
#graph1
barplot2(m,xlab="Level of Test Difficulty", ylab="Test Score",plot.ci=TRUE, ci.l=m-se, ci.u=m+se, las=1, col=c("orange red", "red2","red3","red4","dark red"))
#set barplot2 equal to something to get x-axis points on the graph

#graph2
boxplot(g$test_score~g$test_difficulty, ylab="Test Scores", xlab="Level of Test Difficulty")
#add data points
stripchart(g$test_score~g$test_difficulty, vertical=TRUE, add=TRUE, pch=21)
mtext("Which one do you think better illustrates the data?",side=3, outer=TRUE, line=-2, cex=1.5)

#there are many many other graphing parameters that you can play with to make the graph look exactly how you want :)
#if you would like to go over more about graphing please tell me that in the Your choice quiz on canvas. 

#Your homework this week is to review the rest of the material that you may have not gotten to in class. 



