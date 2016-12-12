
s=data.frame(stimuli=rep(0,80),condition=rep(0,80), correct_response=rep(0,80))
s$stimuli=round(runif(80, 1, 3),0)
s$condition=c(rep("1N",40),rep("2N",40))
for (i in 2:39){
	
if (s$stimuli[i]==s$stimuli[i+1]){
	s$correct_response[i+1]=1
}
else(s$correct_response[i+1]=0)
}

for (i in 40:78){
	
if (s$stimuli[i]==s$stimuli[i+2]){
	s$correct_response[i+2]=1
}
else(s$correct_response[i+2]=0)
}

table(s$correct_response,s$condition)

write.csv(s,"~/Dropbox/Classes/R course/lesson_plans/class_11_13_14/template2.csv",row.names=FALSE)


b=read.csv("~/Dropbox/Classes/R course/lesson_plans/class_11_13_14/template.csv")
b2=read.csv("~/Dropbox/Classes/R course/lesson_plans/class_11_13_14/template2.csv")

a=rbind(b,b2)
table(a$correct_response,a$condition)

a$actual_response=a$correct_response+round(runif(40,0,.65),0)
a$actual_response=gsub(2,0,a$actual_response)
a$participant=rep("p20",80)
write.csv(a,paste("~/Dropbox/Classes/R course/lesson_plans/class_11_13_14/n_back_data/ndata_",a$participant[1],".csv",sep=""),row.names=FALSE)