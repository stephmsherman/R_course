#1. Import salaries_in_academia.csv and call the dataset a. Please read the text file salaries_in_academia_explanation.txt to familiarize yourself with the data. (2pts)
a=read.csv("~/Dropbox/Classes/R course/lesson_plans/class_10_30_14/salaries_in_academia.csv")
head(a)
#2. Is there a difference in salaries across full, associate, and assistant professors? Since we have different numbers of professors across the 3 groups be sure to use type III sum of squares. For full credit you must 1) conduct the appropriate analysis, 2) print the mean salaries for each group, 3)calculate the Tukey HSD results 4) graph the Tukey HSD confidence intervals, and 5) make a comment about what the results mean (5pts).

library(car)
y=aov(sl~rk,a)
Anova(y,type="3")
print(model.tables(y,"means"))
comparisons=TukeyHSD(y)
par(mar=c(5.1,6.8,4.1,2.1))
plot(comparisons, las=1)
#all salaries are significantly different

#3. Does salary across the different professor ranks depend on whether the person is male or female? Print the mean salaries for the groups by sex. If the interaction is not significant then show the main effect model. (5pts)  

y=aov(sl~rk*sx,a)
summary(y)
Anova(y,type="3")
print(model.tables(y,"means"))

y=lm(sl~rk*sx,a)
Anova(y,type="3")

y=aov(sl~sx+rk,a)
Anova(y,type="3")
print(model.tables(y,"means"))

y=lm(sl~rk+sx,a)
Anova(y,type="3")
anova(y)

y=aov(sl~rk+sx,a)
Anova(y,type="3")
anova(y)

y=lm(sl~sx+rk,a)
Anova(y,type="3")


#4. Unfortunately I will not be able to lecture about function in R. Therefore I want to see if you can teach yourselves how to use a new function. Please use interaction.plot to plot professor rank (rk) by salary (sl) separated by sex (sx). I want one line on the graph to represent males and the other to represent females. Please change the x label to "Professor Rank" and the y label to "Salary". (3pts)
?interaction.plot
interaction.plot(a$rk, a$sx,a$sl,xlab="Professor Rank", ylab="Salary")

#5. Is there a correlation between years since highest degree was earned (yd) and salary (sl)? If so, please interpret and graph the results. Remember do not just tell me whether the relationship is positive or negative, tell me what it means! (2pts)

cor.test(a$yd,a$sl)
plot(a$yd,a$sl)
#yes the longer since the person earned their degree to more money they earn

#6. Use an ANOVA to ask your own research question! You question can involve a comparison across 2 groups. Please conduct the appropriate analysis, print the means, and interpret the results. (3pts)

u=aov(yd~sx, a)
Anova(u,type="3")
print(model.tables(u,"means"))
TukeyHSD(u)
t.test(yd~sx, a,var.equal=TRUE)

salary_dgxyd=aov(sl~dg*yd,a)
library(car)
summary(salary_dgxyd)
Anova(salary_dgxyr, type="3") 
str(a)

plot(sl~yd,a, col=ifelse(a$dg=="masters","red","blue"))
abline(lm(sl~yd,a[a$dg=="masters",]),col="red")
abline(lm(sl~yd,a[a$dg=="doctorate",]),col="blue")


