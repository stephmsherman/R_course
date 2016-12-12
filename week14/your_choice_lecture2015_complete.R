#Your choice lecture!

#R script writing tips
#Google wrote a style guide for how they would like their employees to code in R
#https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml
#the purpose of this style guide is to keep the code consistent across scripts and people
#I suggest using your own general guide to keep your scripts consistent so when you look back at an old data analysis script you will understand exactly what you did.

#IF YOU ONLY REMEMBER ONE SCRIPTING TIP IT SHOULD BE:
#Write detailed comments in your scripts! You NEVER want to look back at a script and not know why you ran your analysis a certain way, removed a participant, or used a certain function. I even include HOW to use a function.

##################
#Starting a new script 
#1. Put any functions and libraries you are using at the top of your script. 
#OR in your .Rprofile you can load packages you always use so that at the startup of R they are automatically loaded

#this library allows me to add error bars to barplots using the barplot2 function
library(gplots)
#can use the summaryBy function
library(doBy)

#2. Read in the data
#read in data
m=read.csv("~/Downloads/memory_mood_data.csv")

#3. Check the data, change the format of columns in necessary
head(m)
str(m)

summary(m$positive_affect)

#let's split the data into 3 groups based on the positive affect scale

#create new column called positive_affect_group where 
#low = positive affect < 32
#middle = positive affect between 32 - 41
#high = positive affect greater than or equal to 42
#rational: I am using these cutoffs based on X publication


#create a new column called positive affect group and fill in new column based on the positive_affect criteria
#NOTE: could also do this with a loop but it is faster with subsetting
m$positive_affect_group[m$positive_affect<32]="low"
m$positive_affect_group[m$positive_affect>=32 & m$positive_affect<42]="middle"
m$positive_affect_group[m$positive_affect>=42]="high"

#look at structure
str(m$positive_affect_group)

#it is a character so we need to change it to factor
m$positive_affect_group=as.factor(m$positive_affect_group)

#look how many participants are in each group
table(m$positive_affect_group)

#lets graph the mean hits and false alarms for each positive affect group

#first we need a matrix of the data we want to graph
for_graph=summaryBy(hit+false_alarm~positive_affect_group,data=m, FUN=mean)
for_graph

#change the row names to the positive affect group names
#row names are currently just 1 2 3
rownames(for_graph)
#change to high low middle
rownames(for_graph)=for_graph$positive_affect_group
#remove the positive affect group column
for_graph$positive_affect_group=NULL
for_graph

#we must put the data in a matrix to actually use barplot2 (NOTE: if you are having a problem with the R version using barplot2 just use barplot)
barplot2(for_graph)
#see the error it is telling you to change to a matrix

graph_ready=as.matrix(for_graph)
graph_ready
#everything in the matrix must be numeric
#you know you have non-numeric values in a matrix when the numbers are in quotes. This means that need  to remove the non-numeric values before continuing!

#NOTE: if you use just barplot the default colors will be different
barplot2(graph_ready)

#So barplot2 takes the columns as the number of bars and uses the rows as different colors

#what happens when we change beside=TRUE (the default is beside=FALSE)
barplot2(graph_ready,beside=TRUE)
#now the bars are next to eachother instead of stacked

#what if we want the bars to be grouped by positive_affect_group
#we need to transpose the matrix graph_ready
graph_ready2=t(graph_ready)
graph_ready2

#now the positive_affect_group are the column names so when we graph it there should be a bar (or group of bars) for the high low and middle group
barplot2(graph_ready2,beside = TRUE)

#Your turn!
#Change order of columns to high, middle, low and call it graph_ready2
#data[row, column]
graph_ready2=graph_ready2[,c("high", "middle","low")]

##
barplot2(graph_ready2,beside=TRUE,ylim=c(0,1),legend=rownames(graph_ready2))

###par functions
#mfrow allows you to plot multiple graphs plot 2 graphs
#par(mfrow=c(number_of_rows, number_of_colums))
par(mfrow=c(1,2))
barplot2(graph_ready2,beside=TRUE,ylim=c(0,1))
barplot2(graph_ready2,ylim=c(0,1))

par(mfrow=c(2,1))
barplot2(graph_ready2,beside=TRUE,ylim=c(0,1))
barplot2(graph_ready2,ylim=c(0,1))

#plotting margins
#some take the form of c(bottom,left,top,right))
#helpful website - http://rgraphics.limnology.wisc.edu/images/layouts/rmargins_sf.png 
############ mar ###############
#default setting for mar par(mar=c(5,4,4,2))
#if you increase any of these numbers that means the margin will be larger, if you decrease any of the number, that means the margin will be smaller

#if we make the mar parameter set to zero on each side we are just left with the plot region
par(mar=c(0,0,0,0))
barplot2(graph_ready2,beside=TRUE,ylim=c(0,1))
#so when mar = 0 all there are no margins around the plotting area

par(mar=c(8,8,8,8))
barplot2(graph_ready2,beside=TRUE,ylim=c(0,1),main="margins in R",xlab="positive affect group",ylab="Proportion Response")
segments(0,.9,-3,.9,xpd=TRUE)
#I want to add text above the line, since it is outside the plotting window it won't write text by default
text(-1.5,.93,"mar parameter")
#change xpd=TRUE to add something outside the plotting area
text(-1.5,.93,"mar parameter",xpd=TRUE)
segments(7.5,1,7.5,3,xpd=TRUE)
text(8.5,1.2,"mar\nparameter",xpd=TRUE)

#adding a second plot
par(mfrow=c(2,1))
par(mar=c(5,5,5,5))
#plot 1
barplot2(graph_ready2,beside=TRUE,ylim=c(0,1),main="margins in R",xlab="positive affect group",ylab="Proportion Response")
#plot 2
barplot2(graph_ready2,beside=TRUE,ylim=c(0,1),main="margins in R",xlab="positive affect group",ylab="Proportion Response")

#if you set the margins for one graph it will automatically set the same margins for the next graph unless you specify-
par(mfrow=c(2,1))
par(mar=c(5,5,5,5))
#plot 1
barplot2(graph_ready2,beside=TRUE,ylim=c(0,1),main="margins in R",xlab="positive affect group",ylab="Proportion Response")
#plot 2
#adding different margins
par(mar=c(0,0,0,0))
barplot2(graph_ready2,beside=TRUE,ylim=c(0,1),main="margins in R",xlab="positive affect group",ylab="Proportion Response")

#more examples are here:
#http://rgraphics.limnology.wisc.edu/rmargins_mfcol.php

#other graphing topics to explore
#adding confidence bands around line graphs
?polygon
#helpful website: http://www.alisonsinclair.ca/2011/03/shading-between-curves-in-r/

#######Within-subjects ANOVA########
#there are many different ways to run a within subjects ANOVA
#good explanation here: https://statistics.laerd.com/statistical-guides/repeated-measures-anova-statistical-guide.php
#here I will show you two different ways

#Read in data
w=read.csv("~/Downloads/within_subjects_anova.csv")
head(w)
str(w)
#we have repeated measures because we have 5 observations for each subject
summary(w$subject)

#Research questions: Do the hours students sleep the night before at test significantly vary across the different classes?

#since we have 5 observations for each subject that represent 5 different classes we must include an error term
#More information about error terms can be found here: 
#http://ww2.coastal.edu/kingw/statistics/R-tutorials/repeated.html
#http://personality-project.org/r/r.anova.html

#In this case our error term will reflect that we have classes by subjects 
#Error(subject/classes)

#we take our basic aov formula: 
not_complete=aov(hours_slept~classes,w)

#add our error term

analysis_within=aov(hours_slept~classes + Error(subject/classes),w)
summary(analysis_within)
#compare to output when we do not account for repeated measures
summary(not_complete)
#look at degrees of freedom, the analysis is not taking into account that you have the same subjects 

#Illustrating the advantage of a repeated measures design

#from the not_complete analysis that does NOT account for repeated measures, the sum of squares error is 22.526
regANOVA_SSerror = 22.526

#from the analysis_within that DOES account for the repeated measures the sum of squares error is now at 18.502
withinANOVA_SSerror= 18.502

#If we subtract the SSerror when we do NOT account for repeated measures (from not_complete) and when we do account for repeated measures (from analysis_within) we get the SS for the subjects!
withinANOVA_SSsubjects =regANOVA_SSerror - withinANOVA_SSerror
withinANOVA_SSsubjects
#matches the results in the ANOVA table

#now that we have removed the SS for subjects (the subject variability) we have a more accurate error term that will end up in the denominator of our equation for the F-statistic (after dividing by the degrees of freedom (18.502/76))
withinANOVA_MSerror= 18.502/76
withinANOVA_MSerror

#the F-stat is calculated by taking the MScondition/MSerror (MS stands for mean squared)
withinANOVA_MScondition = 1.3555
Fstat= withinANOVA_MScondition/withinANOVA_MSerror
Fstat

#if you have more complicated designs then it is possible to do the analysis using aov or lm. I suggest using that as often as you can because the model objects can be very useful in follow up analyses (calculating effect sizes and confidence intervals etc.)

#OTHERWISE consider using ezANOVA

install.packages("ez")
library(ez)

?ezANOVA
#define the dv (dependent variable)
#
ezTest=ezANOVA(w, dv = hours_slept, wid = subject, within = classes, type=3)
ezTest

#NOTE: if you want to include multiple variables in an input argument the syntax is within = .(classes, variable2)

#Notes about ANOVAs 
#some researchers are suggesting that everyone include the line below at the top of their code when they are running ANOVAs in R
options(contrasts=c("contr.sum","contr.poly"))
#here are some resources about it:
#https://gribblelab.wordpress.com/2009/03/09/repeated-measures-anova-using-r/
#http://myowelt.blogspot.com/2008/05/obtaining-same-anova-results-in-r-as-in.html

#THANKS FOR A GREAT SEMESTER!










