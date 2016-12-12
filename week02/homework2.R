##FOR EACH QUESTION PLEASE WRITE THE LINE OF CODE ASSOCIATED WITH THE ANSWER UNDER THE QUESTION

#Data description:
#You administered a mood survey to a group of 30 undergrads. You asked them to rate on likert scale how much they are currently experiencing each emotion.
#scale description:from 1 (not at all) to 5 (very)

#First, you were interested in the happiness ratings
#The vector of happiness ratings is called happy
happy=c(2,4,4,5,3,4,5,1,2,5,5,3,3,4,3,2,2,3,1,2,4,3,2,4,4,3,2,3,5,4)

#1. Print out the happiness rating from the 23rd undergrad (2pts)


#2. Print out the happiness rating for the 10th through the 20th undergrad (2pts)


#3. Print out all the undergrads who had a happiness rating greater than 4 (2pts)


#Next you wanted to look at the happiness ratings along with the stress and excited ratings 
#so you combined all the ratings into a data frame called mood
mood=data.frame(happy, stress = c(1,3,3,4,3,2,2,2,3,4,1,1,3,4,5,1,2,3,3,4,2,2,1,5,1,3,3,4,2,5), excited=c(3,3,3,3,4,4,1,2,2,3,4,4,5,2,2,3,2,3,4,4,4,5,5,2,2,4,1,2,4,5))
#Look at the data frame
mood

#4. Print out the number of rows and columns for the mood data frame (2pts)


#5. Print out rows 15 to 20 and only columns 1 and 3 (2pts)


#6 You would like to run a stress intervention study so you want to recruit all the participants who had a stress rating greater than 3. Please create a data frame called recruit with only these participants. (2pts)


#7. Create a new data frame called well_adjusted with participants who have happiness ratings greater than 3 AND stress ratings less than 3. Please include all of the columns in this data frame (2pts)


#8. Print out all columns for participants who have stress ratings greater than 2 AND either a happiness rating less than or equal to 2 OR an excited rating less than 3 (2pts)


#9. Create a new column in the mood data frame called positive_mood by multiplying the happy column and the excited column (2pts)


#10. Create a new column in the mood data frame called mood_score by adding the happy and excited column then substracting the stress column (2pts)




