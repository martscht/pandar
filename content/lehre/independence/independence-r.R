rm(list = ls())

## help.start()

apropos('anova')

example('boxplot') #Get an example.

# Define in_path.
in_path <- "/home/soph/Documents/thesis/Holy_Folder/"
# Define out_path.
out_path <- "/home/soph/Documents/thesis/Analyses/"
in_path
out_path

## setwd("C/Users/bailey/Documents/projectA/analysis/")

## load("C:/Users/bailey/Documents/projectA/analysis/somefolder/blahblah.rda")

## library(data.table) # fread is part of the library "data.table".
## 
## filenames <- list.files(inPath, pattern="*.csv", full.names=TRUE) # Create a list of your data files.
## 
## myData <- rbindlist(lapply(filenames,fread),fill=TRUE) # Read in your data files and concatenate them to one big data frame.

## library(haven) # This library is useful to deal with SPSS files.
## 
## SPSSfile <- "myOtherData.sav" # Define the name of your SPSS file.
## 
## myOtherData <- read_sav(paste(inPath, SPSSfile, sep = "")) # Read in SPSS data. Note how I used "paste" to concatenate two character values (your path name and your file name).``

## # Define in_path.
## in_path <- c("/home/soph/Documents/thesis/Holy_Folder/Child/"
##               , "/home/soph/Documents/thesis/Holy_Folder/YA/"
##               , "/home/soph/Documents/thesis/Holy_Folder/Child/OA/")

## all_groups <- setNames(data.frame(matrix(ncol = 9, nrow = 0))
##                        , c("participant", "group", "age", "sex", "handedness"
##                        , "IV1", "IV2", "DV1", "DV2"))

## all_groups <- rbind(all_groups, my_data)

# Let's create a little example data frame.
example1 <- setNames(data.frame(matrix(ncol = 5, nrow = 10))
                    , c("participant", "OS", "block_number", "DV", "IV"))
# Values in columns.
example1[1:5,1] <- 5
example1[6:10,1] <- 6
example1[,2] <- as.character("Windows")
example1[,3] <-c(NA,1,1,2,2,NA,1,1,2,2)
example1[,4] <- c(.5,.6,.7,.7,.8,.9,.9,.8,.5,.7)
example1[,5] <- c("B","A","B","B","A","B","B","A","B","A")
example1

example1 <- example1[!is.na(example1$block_number),] # Check the different parts of this line. What do the "!" and "is.na" do? Also check out the position of the comma in the square brackets. Remember: Rows first, columns later on!
example1

example1_copy <- example1 # Let's create a copy of example1 so we can do the same stuff over and over again.
example1 <- example1[,c(1,3,4,5)] # Select certain columns by index. Check out the position of the comma.
example1

example1 <- example1_copy # Back to our previous data frame.
example1 <- example1[,c("participant", "block_number", "IV", "DV")] # Select certain columns by name.
example1

example1 <- example1_copy # Back to our previous data frame.
example1$OS <- NULL # Delete a single columns by its name.
example1

example1 <- example1_copy # Back to our previous data frame.
example1 <- example1[,c(1,3,5,4)] # Omit the second block and switch the two last blocks.
example1

example1 <- example1_copy # Back to our previous data frame.
example1 <- example1[,c("participant", "block_number", "IV", "DV")] # Or use the variable names.
example1

# Let's create a little example data frame.
example2 <- setNames(data.frame(matrix(ncol = 4, nrow = 8))
                    , c("participant", "stimulus", "counterbalancing", "response"))
# Values in columns.
example2[1:4,1] <- 1
example2[5:8,1] <- 2
example2[,2] <- c("V","C","C","V","C","V","C","V")
example2[,3] <-c("vowel_left", "vowel_left", "vowel_left", "vowel_left", "cons_left", "cons_left", "cons_left","cons_left")
example2[,4] <- c("l", "r", "l", "l", "l", "l", "r", "r")
example2

example2$response_type <- "V" # As a default we put vowel.
example2$response_type[example2$counterbalancing == "vowel_left" & example2$response == "r"] <- "C" # If the participant is supposed to indicate consonants with the right response (belongs to the first counterbalancing group) and responded with the right key.
example2$response_type[example2$counterbalancing == "cons_left" & example2$response == "l"] <- "C" # If the participant is supposed to indicate consonants with the left response (belongs to the second counterbalancing group) and responded with the left key.
example2

example2$accuracy[(example2$stimulus == "V" & example2$response_type == "V") | (example2$stimulus == "C" & example2$response_type == "C")] <- 1 # Let's find the cases where stimulus and response_type match. Have a look at how I combined logical "and" and "or" and how I used brackets here.
example2$accuracy[is.na(example2$accuracy)] <- 0 # Now let us fill up with zeros for the incorrect responses.
example2

## my_data <- group_by(my_data, participant)

example3 <- setNames(data.frame(matrix(ncol = 4, nrow = 12))
                    , c("participant", "IV1", "IV2", "accuracy"))
# Values in columns.
example3[1:6,1] <- 5
example3[7:12,1] <- 6
example3[,2] <- c('r','r','r','r','r','r','s','s','s','s','s','s')
example3[,3] <- c('B','A','A','B','A','B','A','B','A','A','B','B')
example3[,4] <- c(0,1,1,0,0,1,1,1,1,1,0,1)
example3

# Aggregate data (summarize over the within IV, separate for each participant).
agg_example3 <- aggregate(example3$accuracy # Which variable should be aggregated?
                    ,list(example3$IV1,example3$participant,example3$IV2) # How should we split up the new data frame?
                   ,mean) # What is our actual operation?
agg_example3 

# Create sensible column names.
colnames(agg_example3) <- c('IV1'
                        ,'participant'
                        ,'IV2'
                        ,'accuracy') #Name the columns with a vector containing the labels.
agg_example3

# Re-order columns.
agg_example3 <- agg_example3[,c(2,1,3,4)]

# Sort lines.
agg_example3 <- agg_example3[order(agg_example3$participant),]
agg_example3

# Now something a little more realistic.
example4 <- setNames(data.frame(matrix(ncol = 3, nrow = 6))
                    , c("participant", "stim_type", "accuracy"))
# Values in columns.
example4[1:3,1] <- 5
example4[4:6,1] <- 6
example4[,2] <- c('exp','sur','new','exp','sur','new')
example4[,3] <- c(.5,.6,.7,.7,.8,.9)
example4

library(dplyr) # This library is our friend for so many things! Remember to install the package beforehand, if you have never used it before!

# Group by participants (use "ungroup" to remove all grouping).
example4 <- group_by(example4, participant)

# For false alarm rates, we use 1 - the value in the third row. Thanks to grouping, this is done individually for all subjects.
example4 <- mutate(example4, Pr = accuracy - (1-accuracy[3])) # mutate is also a nice and useful function.
example4

example4$Pr[example4$stim_type == "new"] <- NA
example4

example4 <- example4[!example4$stim_type == 'new',]
example4

example5 <- setNames(data.frame(matrix(ncol = 3, nrow = 12))
                    , c("participant", "stim_type", "Pr"))
# Values in columns.
example5[1:2,1] <- 5
example5[3:4,1] <- 6
example5[5:6,1] <- 7
example5[7:8,1] <- 8
example5[9:10,1] <- 9
example5[11:12,1] <- 10
example5[,2] <- c('exp','sur','exp','sur','exp','sur','exp','sur','exp','sur','exp','sur')
example5[,3] <- c(.11, .3, .13, .5, .21, .99, .08, .35, .14, .71, .03, .99)
example5

summary(example5) 

by(example5, example5$stim_type, summary) # It's nice to have both steps in just one line 

# Reshape to wide format.
library(tidyr) # A nice package for data wrangling.
example5_wide = spread(example5, stim_type, Pr)
example5_wide

# Summarize the wide format data frame.
summary(example5_wide)

# install.packages("summarytools")
# Uncomment if you have to install it the first time. Btw, it is common courtesy to include `install.packages()` functions only commented, i.e. `#install.packages()`. Otherwise you'd expect people who use your script to either check every line for unnecessary installations or to install packages they might already have installed. Both would just waste precious time.
library(summarytools)
descr(example5_wide, stats = "common") # Most common descriptive statistics.

dfSummary(example5_wide)

# install.packages("Rmisc")
library(Rmisc)

Easyinfo = summarySE(example5, measurevar = "Pr", groupvars = "stim_type") #
Easyinfo

# install.packages("ggplot2")
library(ggplot2) # Load the package.

# For plotting I use here 'ggplot2'. Look at the next section (Data visualisation magic)for further information.
ggplot(Easyinfo, aes(x=stim_type, y=Pr, colour=stim_type)) + # Here you specify the data frame you want to refer to and what should be on the x and y axes...
    geom_errorbar(aes(ymin=Pr-ci, ymax=Pr+ci), width=.1) + # Add here the CI.
    geom_line() + # This specifies that we want a simple line.
    geom_point() # But with a dot for the mean please...

# install.packages("gplots")
library(gplots)
plotmeans(Pr ~ stim_type, data = example5)
# But this is really only for the lazy ppl - stick with the 1st version if possible.

# install.packages("remotes")
# remotes::install_github("TKoscik/tk.r.misc")
library(tkmisc)

CI_within = example5_wide
CI_within = CI_within[,-1] # Remove the participant column so that only the columns with the values remain in the data frame.

CI_within = as.data.frame(cm.ci(CI_within, conf.level = 0.95, difference = TRUE)) # Apply the function and put the results in a data frame.
CI_within = tibble::rownames_to_column(CI_within, "stim_type") # Change "column 0" (contains the row names and is not really a column) to a real column. We need that later for the visualisation. 
CI_within$Pr = Easyinfo$Pr # Add the mean values. Also needed for the visuals.
CI_within

ggplot(CI_within, aes(x=stim_type, y=Pr, colour=stim_type)) + 
  geom_errorbar(aes(ymin=lower, ymax=upper), width=.1) + # Add here the CI.
  geom_line() + # This specifies that we want a simple line.
  geom_point() # But with a dot for the mean please...

ggplot(example5, aes(stim_type, Pr, fill=stim_type)) + # `fill=` assignes different colors to the boxplots based on the condition.
  geom_boxplot() + # The actual function for a boxplot. 
  stat_summary(fun = "mean") # It might be helpful to add the mean here as a dot.

ggplot(example5, aes(stim_type, Pr, fill=stim_type)) + # `fill=` assigns different colors to the boxplots based on the condition.
  geom_boxplot(notch = TRUE) + # The actual function for a boxplot. 
  stat_summary(fun = "mean") # It might be helpful to add the mean here as a dot.

ggplot(example5, aes(stim_type, Pr, fill=stim_type)) + 
  geom_boxplot() + 
  stat_summary(fun = "mean") + 
  labs(title = "Recognition Probability of Stimulus Types", # This bit adds the titles.
       fill = "Stimulus Type",
       x = "Stimulus Type",
       y = "Recognition Probability"
  )

ggplot(example5, aes(stim_type, Pr, fill=stim_type)) + 
  geom_boxplot() + 
  stat_summary(fun = "mean") + 
  labs(title = "Recognition Probability of Stimulus Types", 
       y = "Recognition Probability") + # Keep labs() function for main title and y axis since they work fine.
  scale_x_discrete(
    "Stimulus Type", # x axis title
    labels = c("exp" = "Expected", "sur" = "Surprising") # Change tick mark labels, using syntax OLD NAME = NEW NAME. Note that order specified here does not change order of display.
  ) +
  scale_fill_discrete(
   "Stimulus Type", # legend title
   labels = c("exp" = "Expected", "sur" = "Surprising")  # Change legend labels, using syntax OLD NAME = NEW NAME. 
  ) 

ggplot(example5, aes(stim_type, Pr, fill=stim_type)) + 
  geom_boxplot() + 
  stat_summary(fun = "mean") + 
  labs(title = "Recognition Probability of Stimulus Types", 
       y = "Recognition Probability") + # Keep labs() function for main title and y axis since they work fine.
  scale_x_discrete(
    "Stimulus Type", # x axis title
    labels = c("exp" = "Expected", "sur" = "Surprising") # Change tick mark labels, using syntax OLD NAME = NEW NAME. Note that order specified here does not change order of display.
  ) +
  scale_fill_discrete(
   "Stimulus Type", # legend title
   labels = c("exp" = "Expected", "sur" = "Surprising")  # Change legend labels, using syntax OLD NAME = NEW NAME. 
  ) + 
  geom_line(aes(group=participant, color=participant)) + # This is the relvant part for the spaghettis.
  scale_colour_gradientn(colours=rainbow(6)) # You can specify the color palette you want to use for the lines. 


example6 = setNames(data.frame(matrix(ncol = 2, nrow = 12))
                    , c("participant", "animal")) 
example6$participant = (1:12)
example6$animal = c("Otter", 
                 "Lama", 
                 "Otter",
                 "Otter", 
                 "Lama", 
                 "Lama", 
                 "Otter", 
                 "Bumblebee", 
                 "Duck", 
                 "Otter", 
                 "Otter", 
                 "Duck")
example6

ggplot(example6, aes(animal, fill=animal)) + 
  geom_bar() + # This gives you the barplot. 
  labs(title = "Favourite Animal Rating", 
       y = "Number") + 
  scale_x_discrete(
    "Animal") +
  scale_fill_discrete(
   "Animal") 

example7 <- example5
example7$rt <- c(1303,
                900,
                1193,
                1000,
                1090,
                690,
                1393,
                1121,
                970,
                988,
                1440,
                793)
example7

ggplot(example7, aes(x=Pr , y=rt)) + 
  geom_point() # Makes a scatter plot using x and y variables specified in aes().

ggplot(example7, aes(x=Pr, y=rt, color=stim_type, shape=stim_type)) +
  geom_point() + 
  geom_smooth(method=lm, aes(fill=stim_type))

# Set seed.
set.seed(234634)
# First, simulate recognition for hungry: the first 30 are for cold, the other 30 for warm food.
recog_perf_H<-c(rnorm(30, mean=0.60, sd=0.13), rnorm(30, mean=0.75, sd=0.12)) 
# Now for not hungry.
recog_perf_nH<-c(rnorm(30, mean=0.50, sd=0.14), rnorm(30, mean=0.60, sd=0.15)) 
# Merge both.
recog_perf<-c(recog_perf_H, recog_perf_nH)
# Create condition variable.
condition<-rep(c("cold", "warm"), each=30, times=2)
# Participant variable.
participant<-c(rep(c(1:30), times=2), rep(31:60, times=2))
group<-rep(c("hungry", "not hungry"), each=60)

# Bind it.
data_food<-data.frame(participant, condition, recog_perf, group)

# Create also a continuous variable indicating participants' working memory performance ("wm"). 
# We are assuming that it is correlated to the recognition performance.
wm<-vector()
for (n in 1:length(unique(participant))){
wm[n]<-mean(data_food$recog_perf[data_food$participant==data_food$participant[n]])+rnorm(1,mean=0.10, sd=0.02)
}
# Order according to participants.
data_food<-data_food[order(data_food$participant),]
# Attach the wm variable.
data_food$wm<-rep(wm, each=2)
# Check the structure of the data.
str(data_food)
# Check the format of the data:
head(data_food)
# Let us look at the data:
data_food

# Check the distribution of the response variable, performance (DV).
library(ggplot2)
ggplot(data_food, aes(recog_perf)) +
  geom_histogram(aes(y=..density..), colour="black", fill="white") +
  geom_density()+
  facet_grid(condition~group)

qqnorm(data_food$recog_perf[data_food$condition=="warm" & data_food$group=="hungry"], main = "QQ plot for the warm condition & hungry group")
qqline(data_food$recog_perf[data_food$condition=="warm" & data_food$group=="hungry"])

qqnorm(data_food$recog_perf[data_food$condition=="warm" & data_food$group=="not hungry"], main = "QQ plot for the warm condition & not hungry group")
qqline(data_food$recog_perf[data_food$condition=="warm" & data_food$group=="not hungry"])

qqnorm(data_food$recog_perf[data_food$condition=="cold" & data_food$group=="hungry"], main = "QQ plot for the cold condition & hungry group")
qqline(data_food$recog_perf[data_food$condition=="cold" & data_food$group=="hungry"])

qqnorm(data_food$recog_perf[data_food$condition=="cold" & data_food$group=="not hungry"], main = "QQ plot for the cold condition & not hungry group")
qqline(data_food$recog_perf[data_food$condition=="cold" & data_food$group=="not hungry"])

shapiro.test(data_food$recog_perf[data_food$condition=="warm" & data_food$group=="hungry"])
shapiro.test(data_food$recog_perf[data_food$condition=="cold" & data_food$group=="hungry"])
shapiro.test(data_food$recog_perf[data_food$condition=="warm" & data_food$group=="not hungry"])
shapiro.test(data_food$recog_perf[data_food$condition=="cold" & data_food$group=="not hungry"])

library(car)
# We can check first if the variance differ across food condition.
leveneTest(data_food$recog_perf, data_food$condition)
# Then across hunger group.
leveneTest(data_food$recog_perf, data_food$group)

library(reshape2)
# Create a wide dataset by aggregating performance on the participant level.
# In order to do that, we can use the reshape function. 
# We need to specify the grouping variables ("idvar"), i.e. the variables that vary between participants. Those are participants' id, group, and wm. The condition that varies within participant ("timevar") is "condition". 
data_food_wide<-reshape(data_food, idvar = c("participant", "group", "wm"), timevar = "condition", direction = "wide")

# Let's have a look at this dataset.
head(data_food_wide)
# As you can see, we have two columns indicating "recog_perf.warm" for warm condition, and "recog_perf.cold" for cold condition. 

# We want to aggregate it by averaging within participant, to have one variable indicating the recognition performance at the participant level. 
# We can use the useful "rowMeans" function.
data_food_wide$recog_perf_avg<-rowMeans(data_food_wide[c("recog_perf.warm", "recog_perf.cold")])

# Check if wm is normally distributed.
shapiro.test(data_food_wide$wm)
# Do the same for the aggregated recognition performance.
shapiro.test(data_food_wide$recog_perf_avg)

# They are both normally distributed. Let's do the correlation. 
cor.test(data_food_wide$recog_perf_avg, data_food_wide$wm)

# R uses the "lm" (Linear Model) function to compute regression.
regres<-lm(recog_perf_avg~wm, data=data_food_wide)
# On the left side of the "~" there is the dependent variable, on the right the predictor(s).
# Let's have a look at the output.
summary(regres)

t.test(recog_perf_avg~group, data = data_food_wide)

t_test_as_reg<-lm(recog_perf_avg~group, data = data_food_wide)

summary(t_test_as_reg)
# The t-value and p-value are the same as the t-test that we did before. 

# Subset the variable to extract the data. 
t.test(data_food_wide$recog_perf.warm, data_food_wide$recog_perf.cold, paired = TRUE)

# This t-test is considering that each case is "paired" with the other, meaning that it is coming from the same participant. 

# We could also run it in our long dataset.
t.test(recog_perf~condition, data = data_food, paired =T)

# In order to understand the direction of the difference, let's get the means of the two conditions.
by(data_food$recog_perf, data_food$condition, FUN = mean)

# We can create a third group of "super hungry" people that are just starving.
recog_perf_sH<-c(rnorm(30, mean=0.40, sd=0.13), rnorm(30, mean=0.50, sd=0.12)) 

# Create condition variable.
condition<-rep(c("cold", "warm"), each=30)
# Participant variable.
participant<-rep((61:90), times=2)
# Group variable.
group<-rep("super hungry", times=30)

# Bind it.
data_food_sH<-data.frame(participant, condition, "recog_perf" = recog_perf_sH, group)

# Working memory.
wm<-vector()
for (n in 1:length(unique(participant))){
  wm[n]<-mean(data_food_sH$recog_perf[data_food_sH$participant==data_food_sH$participant[n]])+rnorm(1,mean=0.10, sd=0.02)
}

# Order according to participants.
data_food_sH<-data_food_sH[order(data_food_sH$participant),]
# Attach the wm variable.
data_food_sH$wm<-rep(wm, each=2)

# Attach to the previous dataframe.
data_food<-rbind(data_food, data_food_sH)
head(data_food)

# Re-create the dataframe in wide format.
data_food_wide<-reshape(data_food, idvar = c("participant", "group", "wm"), timevar = "condition", direction = "wide")

data_food_wide$recog_perf_avg<-rowMeans(data_food_wide[c("recog_perf.warm", "recog_perf.cold")])
head(data_food_wide)

# Let's run a levene test first.
leveneTest(data_food_wide$recog_perf_avg, data_food_wide$group, center = mean)
# Since it is non-significant, the variances of the two groups are similar.
anova_betw<-aov(recog_perf_avg~group, data=data_food_wide)

# Let's see the results.
summary(anova_betw)

# The "summary" function returns the "omnibus" test, testing whether the recognition performance varies as a function of the hungry group. If we want to have an idea on the differences between the different conditions, we can run the ANOVA as a regression, by using the "lm" function. 
LM_betw<-lm(recog_perf_avg~group, data=data_food_wide)
summary(LM_betw)

# Let's make the "super hungry" group the reference level. 
#data_food_wide$group<-relevel(data_food_wide$group, ref = "super hungry")

# Run the anova again.
LM_betw_sH<-lm(recog_perf_avg~group, data=data_food_wide)

summary(LM_betw_sH)

recog_perf_H<-rnorm(30, mean=0.50, sd=0.13)
# Now for not hungry.
recog_perf_nH<-rnorm(30, mean=0.40, sd=0.14)

recog_perf_sH<-rnorm(30, mean=0.30, sd=0.13)

# Merge both.
recog_perf<-c(recog_perf_H, recog_perf_nH,recog_perf_sH)
# Create condition variable.
condition<-rep("frozen", times = 90)
# Participant variable.
participant<-1:90
group<-rep(c("hungry", "not hungry", "super hungry"), each=30)

# Bind it.
data_food_froz<-data.frame(participant, condition, recog_perf, group)

# Create working memory.
for (n in 1:length(unique(participant))){
  wm[n]<-mean(data_food_froz$recog_perf[data_food_froz$participant==data_food_froz$participant[n]])+rnorm(1,mean=0.10, sd=0.02)
}
# Order according to participants.
data_food_froz<-data_food_froz[order(data_food_froz$participant),]
# Attach the wm variable.
data_food_froz$wm<-wm

# Finally, attach the so-created data to the dataframe.
data_food<-rbind(data_food, data_food_froz)

# Order it according to participants.
data_food<-data_food[order(data_food$participant),]

# Let's have a look at the data.
head(data_food)

library(ez)
# Convert participant variable as factor.
data_food$participant<-as.factor(data_food$participant)
anova_within<-ezANOVA(data = data_food, # Dataframe.
                 dv = .(recog_perf), # Dependent variable. This functions requires to place the name of each variable within .() 
                 wid = .(participant), # Variable that identifies participants.
                 within = .(condition), # Independent variable.
                 detailed = T
                 )

# Let's call the model.
anova_within

# We could use the following syntax to run pairwise, bonferroni corrected, contrasts.
pairwise.t.test(data_food$recog_perf, data_food$condition, paired = TRUE,
p.adjust.method = "bonferroni")

library(lme4)
library(lmerTest) # We also need this package to show the p-values.

# The function we are using is "lmer" function. It is very similar to the lm function, with the only difference that it requires specification of the random effects.
LLM_within<-lmer(recog_perf ~ condition # So far it is the same as the lm function. Now we need to add the random effects.
          + (1| participant),  # We are specifying that the data are nested within participants (random intercept of participants) 
          data = data_food
          )

summary(LLM_within)

# This analysis is the same as our previous ezAnova example, with the only difference that we are adding a between-participants variable(group).
anova_mixed<-ezANOVA(data = data_food, # Dataframe.
                 dv = .(recog_perf), # Dependent variable. This functions requires to place the name of each variable within .() 
                 wid = .(participant), # Variable that identifies participants.
                 within = .(condition), # Independent variable.
                 between = .(group),
                 detailed = T
                 )

anova_mixed

# This is very similar to our previous example, with the only difference that now we are adding one more fixed effect and the interaction.
LMM_mixed<-lmer(recog_perf~condition+group+condition:group # This means that our model is a multiple regression (there are more that one fixed effects) in which we are trying to predict recogPerf from condition, group, and their interaction. 
               + (1| participant), # Random intercept for participants. The three food conditions (warm, cold, frozen) come from the same participants, and therefore we need to account for the fact that they are correlated within each participant.
               data = data_food)

summary(LMM_mixed)

library(car)

Anova(LMM_mixed, type = "III")

#install.packages("dplyr") # Do not forget the "".

library(dplyr) # Now we use the term library. No "".

rm(list = ls())

r <- c(1:10) # Creates a vector containing the numbers 1:10 (from 1 to 10). The : here is super useful.
r # When we type in the name of the object, we can see its contents.
# Assignments are usually done with <-

help(c) # Check out the help for this function.

s = c(1.2, 18) # Assignments also possible with = . Use , to separate the elements.
s

assign("t", c(r, 7, 9, 11, 13)) # Or assign. You can also put an object into an object.
t

help(assign) # Check out the help for this function.

c(21, 8, 22.5, 3) -> u # Or you use the other arrow -> and the name of the new object on the right side. That's actually confusing, I would not recommend it.
u

-u # What happens here?

u <- c(u, -5) #Y ou can also overwrite an object.
u

u # Entire vector.

u[2] # Only second element.

v <- u[2:4] # And what do we get here?
v

objects() # Lists all objects which are in the environment.

ls()

rm(v) # Removes an object you do not want anymore.
ls()

v <- rep(u, times=2) # This is how you repeat.
v

w <- rep(u, each=2) # Another option for repeating.
w

x <- sort(u) # Sort the elements of the vector.
x

y <- c('psy', 'rules')
y

x_char <- as.character(x) # We can change digits into characters. Note ''.
x_char

x_int <- as.integer(x_char) # And back into digits, here integers. Note no decimal places.
x_int

mode(x) # What type are our elements?

mode(y)

length(y) # Length of the vector.

s_plus_2 <- s + 2 # For example.
s_plus_2

s_log_round <- s %>% log() %>% round()
s_log_round

a <- seq(1,12)
b <- seq(from=-5, to=7)
c <- seq(2, -1, by=-.2) # Elements in descending order. We specify the difference.
d <- seq(to=5, from=1)
a
b
c
d

help(array)

arr_3_dim <- array(1:24, dim=c(3,4,2)) # Check how it looks like.
arr_3_dim

arr_2_dim <- array(arr_3_dim, dim=c(6,4)) # Cool! We can rearrange our data in a different way. Note: Zeilen zuerst, Spalten spaeter.
arr_2_dim

arr <- array(c(-5, r, -3.54), dim=c(2,2,3))
arr

arr2 <- array(arr, dim=c(6,2))
arr2

arr3 <- array(arr, dim=c(2,6))
arr3

arr4 <- t(arr3) # Transpose function.
arr4

help(t)

arr[2,1,3]

arr[,,1]

arr[,,c(1,3)]


help(matrix)

mat1 <- cbind(r,r)
mat1

mat2 <- matrix(r, 2,5)
mat2

mat3 <- matrix(r,2,)
mat3

mat4 <- matrix(r, ncol=5)
mat4

mat5 <- matrix(r, nrow=2)
mat5

rdg <- sample(1:2,1) # Randomly select 1 or 2.
if (rdg == 1){ # if the random digit is 1
  print ('Heaven') 
} else{ # if the random digit is 2
  print ('Hell')
}

vec <- 10:20
for(i in 1:5){
  print(vec[i])
}

i <- 1
while(i<=3){
  print(paste('This is round', i, 'of 3'))
  i <- i+1 # This line needs to be at the right location of your loop, here, at the end of each iteration.
}

i <- 1
repeat{
  if(i<=3){ # Note that all loops and if statements can be flexibly combined.
    print(paste('This is round', i, 'of 3'))
  }
  else{
    print('This is it.')
    break # This is important to exit the loop.
  }
  i <- i+1
}

m=8
for (i in 1:m){
  print(i)
  if (i<=5) 
    next # If the condition is met, we start over at the beginning of our loop.
  print('This number is greater than 5.')
}
