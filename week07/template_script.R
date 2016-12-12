#Here I took everythig from lecture6.R and condensed it so you could have a template for your own data
#library using in script
library(doBy)

############Step 1###################
#Write a loop that combines the individual participant files into one file called pvt_all

#path to the folder containing all the data
path="path/pvt_data"
files=paste(path,"/sub*.csv",sep="")

#now you have a list of all the files you want to combine
sub_paths=Sys.glob(files)
length(sub_paths)

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

write.csv(pvt_all, paste(path,"/pvt_all.csv",sep=""),row.names=FALSE)


############Step 3###################
#sometimes participants press the button BEFORE the target comes on the screen. This is called a false start. Most people do not think it is possible to detect a visual stimuli and respond within 100ms.  Therefore if a participant's RT is less than or equal to 100ms then we need to count that RT as a false start.

#create a column that puts a 1 at every trial where there is a false start and a 0 in every other column
pvt_all$false_start=ifelse(pvt_all$RT<=100,1,0)

#create new data frame that includes the number of false starts for each participant
fs=aggregate(false_start~sub, pvt_all,sum)
head(fs)

############Step 4###################
#create summary statistics 
#find mean, median, and standard deviation of RT without includeing the RTs that are less than 100ms. Includes the condition column so it is easier to conduct further analyses
p=summaryBy(RT~sub+condition,data=pvt_all[pvt_all$RT>100,],FUN=c(mean,median,sd))


############Step 5###################
#Before we start the analysis check the object types 
str(p)
#looks good!

############Step 6###################
#Data analysis! Find out whether the caffeined group differs from the no_caffeine group on reaction times

#mean RT?
#t.test(dependent_variable ~ independent_variable, dataframe)
t.test(RT.mean~condition, p)

############Step 7###################
#Graph!
#create a boxplot with mean RT of PVT performance
boxplot(RT.mean~condition,p, main = "Mean RT by Condition", las=1, ylab="Reaction times", xlab= " Condition")
stripchart(RT.mean~condition,p,vertical=TRUE,pch=c(18,20),add=TRUE, col=c("red","blue"))
text(2.3, 274,"t = -2.08, p = .04")



