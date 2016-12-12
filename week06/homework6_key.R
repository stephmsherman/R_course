#You are going to analyze the UCDavis2.txt data set. Look at the UCDavis2_explanation.txt file for information about the study. Both of these files are under Modules, Class on 10/2 on canvas. Briefly, these data were collected in the year 2000 at UC Davis in 239 college students. 

#NOTE: for each statistical test you run, write a comment explaining what the results indicate.

#1. Read in the data and call it u. Make sure to specify that the NAs are coded as "*" (2pt)
u=read.table("~/Dropbox/Classes/R course/data_sets/UCDavis2.txt",header=TRUE,sep="",na.strings="*")
head(u)
str(u)

#2. Is there a relationship between GPA and Looks? (2pts)

cor.test(u$GPA,u$Looks)
#more people value looks the lower their GPA

#3. Look at the Cheat column. Is there a difference in GPA between people who say they would tell the instructor if they saw somebody cheating on an exam and someone who would not say anything? (3pts)
var.test(GPA~Cheat,u) 
t.test(GPA~Cheat,u,var.equal=TRUE)

#4. Is there a relationship between GPA and amount of Alcohol consumed in a typical week? (2pts)
cor.test(u$GPA, u$Alcohol)
#higher correlation between ideal w

#5. Look at the Seat column. Run a t-test to see whether there is a difference in GPA between people who sit in the front (F) versus the back (B) of the room? (3pts)
var.test(GPA~Seat,u[u$Seat!="M",])
ttest=t.test(GPA~Seat, u[u$Seat!="M",])
ttest

#6. What is the mean GPA for people who sit in front and the back of the classroom? Write the line of code that will print out only those numbers. (2pts)
ttest$estimate

#7. How many values are you missing in the Looks column? Show me code that helped you arrive at this answer. (2pts)
summary(u$Looks)

#8. Look at the data and the data explanation file. Ask your own research question, run the appropriate stats test (either t-test or correlation), then interpret the results. (4pts)

t.test(Alchol~Seat, u[u$Seat!="M",],var.equal=TRUE)
