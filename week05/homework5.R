#You are going to calculate summary statistics using a publicly available dataset. The dataset is posted on the Week 5: September 28th Module called risk_proj.txt. 

#information about the data can be found here: http://www.stat.ucla.edu/projects/datasets/risk_perception.html

#Description of variables
# subid......ID of subject 
# risk.......This is the risk value given to one of the 22 
           # activities listed above, on a scale from 0-100 (100 high)
# ethnic.....1=Caucasion, 2=African-American, 3=Mexican-American,     
           # 4=Taiwanese-American 
# gender.....0=Female, 1=Male 
# age........Age of participant
# active.....This is the name of the activity, for which the participant is applying a risk judgement.
# wvcat......World View Category: 0= Unclassifiable, 1=Individualist, 
           # 2=Hierarchicalist, 3=Egalitarian
           
#1. Import data with the missing values coded as "." and call the data risk (1pt)



#2.Convert the subjects column (subid) into a character and then a factor. Keep the same name of the column (2pts) 




#3. How many participants are in this dataset? How many data points do we have for each participant? As always, show me the lines of code that gave you these answers.(3pts)




#4. Create a new data frame called risk_vals that includes the mean risk values (risk) for each participant (subid). (2pts)



#5.Create a new data frame called risk_activexgender that includes mean risk values for each of the active groups separated by gender. In this new data frame, change the name of the column including the risk values to mean_risk_vals. (2pts)



#6. Change the column ethnic from the numbers to the ethnicities (1=Caucasion, 2=African-American, 3=Mexican-American, 4=Taiwanese-American). Also, make the column a factor. (2pts)





#7. Create a table to show how many people are in each ethnicity separated by gender (2pts)

#8. What is the range of risk scores for people in the World View Category (wvcat) who identify as an Individualist? (2pts)


#9. Go to the data explanation website (http://www.stat.ucla.edu/projects/datasets/risk_perception.html). Notice there are two types of activities (active column), the Financial Activities and the Health Activities. Create a data frame called financial that includes the median risk values for only the Finanacial Activities and only participants who are "Mexican-American" and "Taiwanese-American." The financial data frame should include median risk values for each financial activity separated by the 2 ethnicities. (4pts)



