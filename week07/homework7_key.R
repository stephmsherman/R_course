#You ran a memory study to test whether people remember emotional words better than neutral words and whether their memory is further enhanced by studying the words multiple times.

#30 participants completed the memory task. sub01 - sub15 studied the words once while sub16 - sub17 studied the words twice. 

#The memory data for all participants is in the memory_data.zip file on canvas. Each file (i.e. sub01.csv) includes the raw data for that participant. 

#All files include:
#trials (trial number)
#sub (subject number)
#times_studied (the number of times a word was studied)
#condition (emotional or neutral words)
#correct (1 = correct answer, 0 = incorrect answer)
#RT (reaction times in seconds). 
#Every participant completed 100 trials of the task.

#You will be completing ALL of these steps in R (NO editing in excel)

#1. Combine the individual participant files into one file called alldata (5pts)

files=Sys.glob("~/Dropbox/Classes/R course/lesson_plans/class_10_09_14/memory_data/sub*.csv")

path="~/Dropbox/Classes/R course/fall_2015/lesson_plans/week7/memory_data"

alldata=data.frame(c())

for (i in 1:length(files)){
	m=read.csv(files[i])
	alldata=rbind(alldata,m) #rbind with combine the data by rows
	}
	
#2. Is there a difference in mean accuracy for emotional and neutral words (ignoring how many times the words were studied)? Don't forget that each subject will have an accuracy measure for neutral and emotional words. To received full credit you must 1) create the appropriate data frame 2) run the correct stats analysis 3) interpret the results in a comment (statistical significance p < .05).(5pts)

library(doBy)
library(car)
mem=summaryBy(correct~sub+condition,alldata, FUN=mean)
t.test(correct.mean~condition,mem,paired=T)
levels(mem$condition)
e=mem[mem$condition =="emotional","correct.mean"]
m=mem[mem$condition =="neutral","correct.mean"]
mean(e-m)
#people are better at remembering emotional words versus neutral words

#3.Ignoring condition and how many times the words were studied, is there a difference in mean RT for correct and incorrect responses? Take into account that each subject will have a mean RT for correct and incorrect responses. To received full credit you must 1) create the appropriate data frame 2) run the correct stats analysis 3) interpret the results in a comment(statistical significance p < .05). (5pts)

RT_analysis=summaryBy(RT~sub+correct,alldata, FUN=mean)
t.test(RT.mean~correct, RT_analysis,paired=TRUE)

x=RT_analysis[RT_analysis$correct=="0","RT.mean"]
y=RT_analysis[RT_analysis$correct=="1","RT.mean"]
mean(x-y)
#the results suggest that there is a trend suggesting that mean RT was slower when participants were correct

#4. Ignoring condition, is there a difference in mean accuracy between the participants who studied the words once and those who studied the words twice (times_studied)? To received full credit you must 1) create the appropriate data frame 2) run the correct stats analysis 3) interpret the results in a comment(statistical significance p < .05). (5pts)

t=summaryBy(correct~sub+times_studied,alldata, FUN=mean)
leveneTest(correct.mean~times_studied, t)
t.test(correct.mean~times_studied, t, var.equal=TRUE)
#participants who studied the words twice remembered more words than participants who studied the words once. 









