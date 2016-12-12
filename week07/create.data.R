#create data
for (i in 1:9){
trials=seq(1,100,1)
RT=round(runif(100, 190,370),digits=0)
sub=rep(paste("sub0",i,sep=""),100)
condition=rep("caffeine", 100)
p=data.frame(sub,condition,trials,RT)
write.csv(p, paste("~/Dropbox/Classes/R course/lecture_7/pvt_data/",sub[1],".csv",sep=""),row.names=FALSE)
}

for (i in 10:20){
trials=seq(1,100,1)
RT=round(runif(100, 180,400),digits=0)
sub=rep(paste("sub",i,sep=""),100)
condition=rep("caffeine", 100)
p=data.frame(sub,condition,trials,RT)
write.csv(p, paste("~/Dropbox/Classes/R course/lecture_7/pvt_data/",sub[1],".csv",sep=""),row.names=FALSE)
}



#create data
for (i in c(22,23,24,26,27,28)){
trials=seq(1,100,1)
RT=round(runif(100, 200,370),digits=0)
sub=rep(paste("sub",i,sep=""),100)
condition=rep("no_caffeine", 100)
p=data.frame(sub,condition,trials,RT)
write.csv(p, paste("~/Dropbox/Classes/R course/lecture_7/pvt_data/",sub[1],".csv",sep=""),row.names=FALSE)
}

#create data
for (i in c(21,25,29,30,31,32)){
trials=seq(1,100,1)
RT=round(runif(100, 180,420),digits=0)
sub=rep(paste("sub",i,sep=""),100)
condition=rep("no_caffeine", 100)
p=data.frame(sub,condition,trials,RT)
write.csv(p, paste("~/Dropbox/Classes/R course/lecture_7/pvt_data/",sub[1],".csv",sep=""),row.names=FALSE)
}

#create data
for (i in 33:40){
trials=seq(1,100,1)
RT=round(runif(100, 180,410),digits=0)
sub=rep(paste("sub",i,sep=""),100)
condition=rep("no_caffeine", 100)
p=data.frame(sub,condition,trials,RT)
write.csv(p, paste("~/Dropbox/Classes/R course/lecture_7/pvt_data/",sub[1],".csv",sep=""),row.names=FALSE)
}



##

