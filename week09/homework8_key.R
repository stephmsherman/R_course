#You collected longitudinal data from 20 graduate students across their 5 year program. You asked students at the end of each year how satisfied they were with grad school using a visual analog scale from 0 (not satisfied) to 5 (extremely satisfied) and how many hours they work on average per week. You want to graph your results but in order to do so you must first convert the data from a wide format to a long format.

#1. Import the grad_survey_wide_format.csv file and call it g. (2pts)
g=read.csv("~/Dropbox/Classes/R course/lesson_plans/class_10_23_14/grad_survey_wide_format.csv")          
head(g)

#2. Convert the data to long format and call it grad (6pts)
grad1=reshape(g, idvar=c("subject","sex"), timevar="year",times = c("year1","year2","year3","year4","year5"), v.names=c("satisfaction","work_hours_per_week"),varying=list(c("year1.satisfaction","year2.satisfaction","year3.satisfaction","year4.satisfaction","year5.satisfaction"),c("year1.work_hours_per_week","year2.work_hours_per_week","year3.work_hours_per_week","year4.work_hours_per_week","year5.work_hours_per_week")),direction="long")

#3. Take the new dataset you created called grad and put the rows in order by subject (increasing order). Make sure to save the dataset as grad again (2pts)

grad=grad[order(grad$subject),]
grad

#4. Create a scattetplot of satisfaction (x-axis) by hours worked per week (y-axis) for only year 3. Make the data points that represent males red open circles and the female data points blue open squares. Add labels for the x and y axis, a title, a regression line that is 1.5 units thick, and make sure the axis labels are horizontal. (6pts)

three=grad[grad$year=="year3",]

plot(three$satisfaction, three$work_hours_per_week,col=ifelse(three$sex=="male","red","blue"),pch=ifelse(three$sex=="male",21,22),las=1, xlab="Satisfaction", ylab="Hours Worked per Week", main="Satisfaction x Hours Worked")
abline(lm(three$work_hours_per_week~three$satisfaction), lwd=1.5)

#5. Using the entire dataset, create a box plot of hours worked per week and year in grad school. Put year on the x axis and hours worked per week on the y axis. There should be a "box" for each year. Make the limits on the y axis from 35 to 55 (4pts).   

boxplot(work_hours_per_week~year,grad, ylim=c(35,55))



