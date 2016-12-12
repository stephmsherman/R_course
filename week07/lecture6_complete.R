#You ran a research study to test whether performance on a reaction times task improved with the administration of caffeine. 

#40 participants completed the Psychomotor Vigilance Task (PVT). sub01 through sub20 were given caffeine and sub21 through sub40 were not given caffeine

#Description of Task: PVT (Dinges & Powell, 1985) is a high-signal load reaction time test in which participants attend to a small rectangular area at the center of a computer screen. At random intervals, a millisecond timer appears in the center of the rectangle (2 to 5 second inter-trial intervals). Participants are instructed to respond via button press as rapidly as possible upon detection of the counter stimulus; participant response stops the counter from updating. The final counter value corresponds to the participant’s reaction time (RT) and is displayed on-screen for 1 second, thus providing feedback for that particular trial. Participants will be given 2 seconds to make a response before the computer aborts a trial. 

#The PVT data for all 40 participants is in the pvt_data.zip file on canvas. Each file (i.e. sub01.csv) includes the raw data for that participant. 

#All files include 4 columns- sub (subject number), condition (caffeine or no_caffeine), trials (trial number), RT (reaction times in milliseconds). Every participant completed 100 trials of the task.

#RESEARCH QUESTION: Your goal today is to find out whether reaction times differ across the two groups (caffeinated, decaffeinated)
#We will be completing ALL of these steps in R (NO editing in excel)

############Step 1###################
#Write a loop that combines the individual participant files into one file called pvt_all

#First fill in the path variable below with wherever you put the pvt_data folder on your computer (i.e. ~/Desktop)
path="~/Downloads/pvt_data"
#now run the paste function and see what it does
paste(path,"/sub*.csv",sep="")
#the output of the paste function only includes 1 vector and 1 item
length(paste(path,"/sub*.csv",sep=""))

#see how paste differs from the c function?
c(path,"/sub*.csv")
#the output of the c function is 1 vector but 2 items whereas the paste function include 1 vector and only 1 item
length(c(path,"/sub*.csv"))

#now set that equal to files
files=paste(path,"/sub*.csv",sep="")
files
# our goal here is create paths to files for each participants
# the * is the only part of the file path that is unique for each participant
# in other words - the files for each participant all have the same path and name except after sub there is a UNIQUE subject number

#We are going to Sys.glob so that the * can be read as a "wildcard"
?Sys.glob
#What the wildcard does is to print everything that has a path that starts with sub and ends with .csv

#Look how adding the star can help
Sys.glob(files)

#Look what happens when I change the name of a file so that it does not start with sub
#change sub01 to plt01
Sys.glob(files)
#change plt01 back to sub01
Sys.glob(files)
#now you have a list of all the files you want to combine
sub_paths=Sys.glob(files)
length(sub_paths)

#look how I get the path for sub27
#subset the vector
sub_paths[27]
#you see how you can use sub_paths[i] in a loop?

#create an empty data frame called pvt_all
pvt_all=data.frame(c())
pvt_all

#read in all participant files and combine
#remember we want to combine all 40 files so we want the sequence to be from 1:40 or
1:length(sub_paths)

for (i in 1:length(sub_paths)){
	pvt=read.csv(sub_paths[i])
	pvt_all=rbind(pvt_all,pvt) #rbind with combine the data by rows
	}
#we are adding to the empty data frame we created called pvt_all
pvt_all
head(pvt_all)
tail(pvt_all)
dim(pvt_all)
table(pvt_all$sub)

#let's break down what it is doing	
pvt_all=data.frame(c())
pvt=read.csv(sub_paths[1])
#now pvt is a dataframe that includes all data from the sub01
pvt
#next we combine data from sub01 to the empty dataframe pvt_all
pvt_all=rbind(pvt_all,pvt)
pvt_all
dim(pvt_all)
#next we import the data from sub02 and call it pvt
pvt=read.csv(sub_paths[2])
pvt
#now we combine the data from sub02 with the data from sub01
pvt_all=rbind(pvt_all,pvt)
pvt_all
dim(pvt_all)
table(pvt_all$sub)
#now pvt_all contains the data from sub01 and sub02. I could easily combine them by rows (rbind) because I have the same number and type of columns in both data sets
#the loop will do this process over all 40 participants

#run the loop again before continuing
pvt_all=data.frame(c())
for (i in 1:length(sub_paths)){
	pvt=read.csv(sub_paths[i])
	pvt_all=rbind(pvt_all,pvt) #rbind with combine the data by rows
	}
#make sure we have 40 participants with 100 trials for each participant
str(pvt_all)
length(levels(pvt_all$sub)) #40 participants
table(pvt_all$sub) #100 trials for each participant

############Step 2###################
#export a file called pvt_all.csv that contains data from all the participants
#in write.csv we need a path and a file name that we want to create
#we can use the paste function to create that path
path
paste(path,"/pvt_all.csv",sep="")
#we combined that path to where all the data are and created a new file name called pvt_all.csv that we want to contain all the data

write.csv(pvt_all, paste(path,"/pvt_all.csv",sep=""),row.names=FALSE)

############Step 3###################
#sometimes participants press the button BEFORE the target comes on the screen. This is called a false start. Most people do not think it is possible to detect a visual stimuli and respond within 100ms.  Therefore if a participant's RT is less than or equal to 100ms then we need to count that RT as a false start.

#create a column that puts a 1 at every trial where there is a false start and a 0 in every other column
pvt_all$false_start=ifelse(pvt_all$RT<=100,1,0)

head(pvt_all)

#create new data frame that includes the number of false starts for each participant
fs=aggregate(false_start~sub, pvt_all,sum)
fs

############Step 4###################
#create summary statistics

#Your turn!

#Now that you have all the data in one file, use the summary functions to calculate the mean, median, and standard deviation of RT for each participant (sub). DO NOT include the reaction times less than or equal to 100 ms in these calculations. Name the new data frame you create pvt_sum.
library(doBy)
pvt_sum=summaryBy(RT~sub,pvt_all[pvt_all$false_start==0,],FUN=c(mean,median,sd))
pvt_sum

#OR

##new dataframe with only RT > 100
pvt_trim= pvt_all[pvt_all$RT>100,]
pvt_sum=summaryBy(RT~sub,pvt_trim,FUN=c(mean,median,sd))


######
#add the condition column to your new pvt_sum dataframe
pvt_sum=summaryBy(RT~sub+condition,pvt_trim,FUN=c(mean,median,sd))
pvt_sum


#merge pvt_sum data frame with fs data frame
?merge
# structure of the function merge(dataframe1,dataframe2, by =column that is in common between the 2 dataframes)
p=merge(pvt_sum, fs, by = "sub")
p

############Step 5###################
#Before we start the analysis check the object types 
str(p)
#anything need to be changed?
#nope
############Step 6###################
#Data analysis! Find out whether the caffeined group differs from the no_caffeine group on reaction times

#mean RT?
#t.test(dependent_variable ~ independent_variable, dataframe)
y=t.test(RT.mean~condition, p)

#what do the results indicate?
#people who drink caffeine are faster

#standard deviation of the RT?
t.test(RT.sd~condition,p)

#number of false starts?
t.test(false_start~condition,p)

############Step 7###################
#Graph! - Preview for next week's lesson
#create a boxplot with mean RT of PVT performance
#add data points to the graphs
#make caffeine data points red and no_caffeine data points blue
boxplot(RT.mean~condition,p, main = "Mean RT by Condition", las=1, ylab="Reaction times", xlab= " Condition")
stripchart(RT.mean~condition,p,vertical=TRUE,pch=c(18,20),add=TRUE, col=c("red","blue"))
text(2.3, 274,"t = -2.08, p = .04")
