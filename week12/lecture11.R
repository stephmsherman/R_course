#Today we are going to see if mood influences working memory performance
#We had 20 participants complete the N-back task (working memory task) and the Positive and Negative Affect Survey (PANAS).

####N-back task - Participants were shown a sequence of visual stimuli and they had to respond each time the current stimulus was identical to the one presented n positions back in the sequence (Jaeggi et al., 2010).
#Participants completed 160 trials: 80 1-back and 80 2-back
#Participants were suppose to press the button on 60 trials (30 for 1-back and 30 for 2-back)
#Participants were NOT suppose to press the button on 100 trials (50 for 1-back and 50 for 2-back)

#video demo - https://www.youtube.com/watch?v=TEO-So0lpWg

#The outcome measure of interest is the proportion of hits minus false alarms averaged over all n-back levels called corrected recognition.

####PANAS - survey, with two outcome measures - positive_affect and negative_affect
#scores range from 10 -50 with higher scores numbers indicating higher levels of affect (either positive or negative)
#here is what the survey looks like - https://www.surveymonkey.com/r/?sm=F6chV%2FrZXiO7rvChIqmupA%3D%3D

#Your goal is to process the memory data to calculate corrected recognition. Once you have corrected recognition find out if it is correlated with positive and negativie affect.  

###Working Memory Task Data
#ndata_p?? files each contain:
#stimuli - the number the participant saw an the screen at each trial
#condition- 1N = one back task; 2N = two back task
#correct_response = the right answer. 0 - should not push the button; 1- should push the button
#actual_response - participant response - 0- they did not push the button; 1 - they did push the button
#participant - participant #

##############Step 1 ##############
#1a. First let's concentrate on organizing the memory data. All the data are in the n_back_data.zip. Unzip the data and combine it and call the dataframe all_nback (for help: refer to Week 7: October 13th lecture and homework) 




#1b. Make sure all of your data are in the correct format



#1c. Summarize how many trials each participant completed in each condition and then further separate the trial numbers by correct response.




##############Step 2 ##############
#2a. Now that you have all the data organized you need to create a new column called correct.
#In this column they should input a 1 when the correct_response matches the actual_response and a zero when it doesn't (for help: refer to Week 4: September 22nd lecture and homework and maybe Week 2 lecture)

#HINT:
#This sounds like a logical argument so before you make the column write the logical argument that would output a TRUE every time the correct_response equals the actual_response and a FALSE every time the correct_response does not equal the actual_response


#Now create the column using the logical argument



#2b Get a basic idea of how your participants did on the task. Print out each participant's mean accuracy (using the correct column). What is the mean and range of the scores? (for help: refer to Week 5: September 28th lecture and homework)




##############Step 3##############
#We need to calculate our outcome measure called corrected_recognition
# corrected_recognition = hits - false alarms
#hit = when participant was suppose to press the button (correct_response = 1) and they did (actual_response = 1)
#false alarm = when participant pressed the button (actual_response = 1) and they were not supposed to press it (correct_response = 0)
#for help: refer to Week 5: September 28th lecture and the Week 8: October 20th - Practice Subsetting)


#3a. Create a dataframe that includes the percent hits called hit for each participant (in other words the mean of actual_response when correct_response==1; HINT: you want to summarize or aggregate...)  



#3b. Create a dataframe that includes the false alarm rate called false_alarm for each participant (in other words, the mean of actual_response answers when correct_response == 0; HINT: you want to summarize or aggregate...)




#3c. Merge the hit and false_alarm columns together so that you have a data frame of participant, hit, and false alarm called c. 
#for help: refer to Week 7: October 13th lecture





#3d. Using the columns you created in 3a and 3b that are in your c data frame, create a new column called corrected_recognition by taking hit - false_alarm (for help: refer to Week 2: September 8th lecture)





##############Step 4##############
#The memory task data are analyzed and ready to go (using the dataframe c)!

#Quiz/Homework time!
#Since we are interested in individual differences let's create a stacked barplot to show how often each participant is getting hits and false alarms. Please make a graph that looks exactly like the memory_performance_figure.pdf in the Module for Week 12: November 17th. This is your homework. (HINT: you will need to use the parameter xpd)






##############Step 5##############
#Merge data
#5a. Import that PANAS.csv file and call it panas. 



#5b. Merge the panas and the memory data called c and call it final
#NOTE make sure all the participants are included in the final data set



##############Step 6##############
#data analysis
#create a correlation matrix with all of the outcome variables
#NOTE: you must remove the NA before creating the matrix








