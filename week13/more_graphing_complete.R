#last section of graphing lecture from Week 8


#Graphing in R
#import the classroom_data.csv
path="~/Downloads"
g=read.csv(paste(path,"/classroom_data.csv",sep=""))
head(g)
str(g)

#check that your columns have the correct object types
#change the objects to the correct type
#the sex column was an integer and we want it to be a factor
g$sex=as.factor(g$sex)
str(g)

###
#two more graphing tricks

#we can make the text/data points larger using cex (cex.axis, cex.lab, cex.main etc)
#original graph
plot(g$hours_slept, g$test_score)
#cex makes data points larger
plot(g$hours_slept, g$test_score, cex=1.5)
#cex.lab makes the labels larger
plot(g$hours_slept, g$test_score,xlab="hours slept",ylab="test scores", cex.lab=1.5)
#how do you make the axis numbers larger
plot(g$hours_slept, g$test_score,xlab="hours slept",ylab="test scores", cex.lab=1.5, cex.axis=1.5)

#cex.main makes the title larger
plot(g$hours_slept, g$test_score,xlab="hours slept",ylab="test scores", main="hours slept x test scores",cex.lab=1.5, cex.axis=1.5, cex.main = 1.5)

#Bold the text
plot(g$hours_slept, g$test_score,xlab="hours slept",ylab="test scores", main="hours slept x test scores",cex.lab=1.5, cex.axis=1.5, cex.main = 1.5, font=2)

#how do you bold the labels
plot(g$hours_slept, g$test_score,xlab="hours slept",ylab="test scores", main="hours slept x test scores",cex.lab=1.5, cex.axis=1.5, cex.main = 1.5, font=2, font.lab=2)


#you can change the direction of the axis labels with las
plot(g$hours_slept, g$test_score,xlab="hours slept",ylab="test scores", main="hours slept x test scores",cex.lab=1.5, cex.axis=1.5, cex.main = 1.5, las=1)
#see how the numbers on the y axis changed?
#now look at the other options
plot(g$hours_slept, g$test_score,xlab="hours slept",ylab="test scores", main="hours slept x test scores",cex.lab=1.5, cex.axis=1.5, cex.main = 1.5, las=2)
plot(g$hours_slept, g$test_score,xlab="hours slept",ylab="test scores", main="hours slept x test scores",cex.lab=1.5, cex.axis=1.5, cex.main = 1.5, las=3)

###remove border around plot (frame.plot)
plot(g$hours_slept, g$test_score,xlab="hours slept",ylab="test scores", main="hours slept x test scores",cex.lab=1.5, cex.axis=1.5, cex.main = 1.5, las=1, frame.plot=FALSE)

####make axis at 0 point (xaxs and yaxs)

#there is an annoying space between 0 and the 0,0 point on graph
plot(g$hours_slept, g$test_score,xlab="hours slept",ylab="test scores", main="hours slept x test scores",cex.lab=1.5, cex.axis=1.5, cex.main = 1.5, las=1, frame.plot=FALSE, xlim=c(0,10))

plot(g$hours_slept, g$test_score,xlab="hours slept",ylab="test scores", main="hours slept x test scores",cex.lab=1.5, cex.axis=1.5, cex.main = 1.5, las=1, frame.plot=FALSE, xlim=c(0,10), xaxs="i",yaxs="i")


#boxplot
#dark line is the median of the test scores
boxplot(g$test_score)
#some types of graph have an add argument so you do not have to use par(new=TRUE)
#stripchart adds data points to your graphs
stripchart(g$test_score,vertical =TRUE, add=TRUE, pch=18)

#you can also use the formula structure we have been talking about to graph test scores separated by test difficulty
boxplot(g$test_score~g$test_difficulty, ylab="Test Scores", xlab="Test Difficulty")
#add data points
stripchart(g$test_score~g$test_difficulty, vertical=TRUE, add=TRUE, pch=21)

##can add points to graph to show the mean because boxplot only displays the median
points(aggregate(test_score~test_difficulty, g, mean), col="red", pch=20, cex=2.5)


#bar plots
#the basic barplot function in R works really well but this barplot2 function in the gplots library allows you to add error bars/confidence intervals
#remember you should only have to install packages once on your computer but every time you open a new R session you will need to run the library(gplots)
install.packages("gplots")
library(gplots)
#take a look at the barplot2 function
?barplot2

#we are going to need this standard error function to draw error bars of the standard error
#function to calculate standard error
stderr = function(x){
	 sqrt(var(x,na.rm=TRUE)/length(na.omit(x)))
}
#create vectors of the mean and standard error using tapply
#tapply is very similar to aggregate and summaryBy 
?tapply	 
m=tapply(g$test_score, g$test_difficulty,mean)
#m now includes the mean test score at each level of test difficulty
m
is.data.frame(m)
class(m)

se=tapply(g$test_score,g$test_difficulty,stderr)
#se includes the standard error of test scores at each level of test difficulty
se
##plot means
#first argument in barplot2 and barplot is height
#the height of the bars is the mean so let's put in the vector of our means = m
barplot2(m,xlab="Level of Test Difficulty", ylab="Test Score")
#automatically added the labels to the bar because each number in m had an associated name
names(m)

#adding error bars 
#first create a vector of the lower bar and upper bar points

#error bars are the mean plus and minus the standard error (they can also be 94% confidence intervals but not in this example)
lower_bar = m - se
upper_bar = m + se
#your means vector and error bar vectors must line up and have the same dimensions
m
lower_bar
upper_bar
#great, they all have 1 row with 4 items with the same labels for each item

#Also the first items in each vector must all be describing the same bar
m[1] #mean of 0 test difficulty
upper_bar[1] #upper error bar point for 0 test difficulty
lower_bar[1] #lower error bar point for 0 test difficulty

#within the barplot2 function, set plot.ci to TRUE and set the ci.l (confidence interveral lower) and ci.u (confidence interval upper) to the vectors you created
barplot2(m,xlab="Level of Test Difficulty", ylab="Test Score",plot.ci=TRUE, ci.l=lower_bar, ci.u=upper_bar, las=1, col=c("orange red", "red2","red3","red4","dark red"))
#for fun a made each bar a different shade of red

##can also change the width and color of the error bars
##lwd = thickness = ci.lwd with change thickness of ci (error bars)
##ci.width with change width of ci (error bars)
##col =  = ci.col with change col of ci (error bars)
barplot2(m,xlab="Level of Test Difficulty", ylab="Test Score",plot.ci=TRUE, ci.l=lower_bar, ci.u=upper_bar, las=1, col=c("orange red", "red2","red3","red4","dark red"), ci.col="blue", ci.lwd=1, ci.width=.2)


#add points to plot
barplot2(m,xlab="Level of Test Difficulty", ylab="Test Score",plot.ci=TRUE, ci.l=lower_bar, ci.u=upper_bar, las=1, col=c("orange red", "red2","red3","red4","dark red"))
stripchart(g$test_score~g$test_difficulty, vertical=TRUE, add=TRUE, pch=21)
#unfortunately barplot is not as compatible with strip chart as boxplot
#the points are not lined up in the middle of the bar. How do we fix that?

#set your barplot2 to equal a variable to get the x-coordinates of the middle of each bar
xcoord=barplot2(m,xlab="Level of Test Difficulty", ylab="Test Score",plot.ci=TRUE, ci.l=lower_bar, ci.u=upper_bar, las=1, col=c("orange red", "red2","red3","red4","dark red"))
xcoord
text(xcoord[1,1],.2, "bar1")
#see how bar1 text was put in the middle of the first bar on the plot at the y-coordinate of .2
#so if we want to add points to our stripchart we ...
?stripchart #look at the "at" argument
stripchart(g$test_score~g$test_difficulty, vertical=TRUE, add=TRUE, pch=21, at =xcoord)
#we specified where we want the points to be on the x-axis to the middle of each bar

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
#the reason why mtext put the label for both plots was because of the outer =TRUE argument
#if we do not include that here is what it does
mtext("Which one do you think better illustrates the data?",side=3, line=-2, cex=1.5)
#R will put the text on the last graph you created
#we also specified with the side=3 that we wanted the text on the top of the graph
#side: 1= bottom; 2 = left, 3 = top ; 4 = right

#there are many many other graphing parameters that you can play with to make the graph look exactly how you want :)


