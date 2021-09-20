###############################
# analysis script
#
#this script loads the processed, cleaned data, does a simple analysis
#and saves the results to the results folder

#load needed packages. make sure they are installed.
library(ggplot2) #for plotting
library(broom) #for cleaning up output from lm()
library(here) #for data loading/saving

#path to data
#note the use of the here() package and not absolute paths
data_location <- here::here("data","processed_data","processeddata.rds")

#load data. 
mydata <- readRDS(data_location)



#I want to plot the death rate for drunk driving accidents for each state,
#but first I need to do some data mangement to get the abbreviations.
#Here I use some R stored datasets on states and abbreviations to create 
#a new data frame to merge with mydata
abb <- as.data.frame(cbind(state.name, state.abb))
abb <- rename(abb, State = state.name)


#now the merge
mydata <- merge(mydata, abb, by = "State")

#checking. looks good
glimpse(mydata)



#Now we plot the data by state for Rate of deaths (per 100,000 population)
#for people killed in crashes involving a driver with BAC =>0.08% for all ages
p1 <- mydata %>% ggplot(aes(x=state.abb, y=All.Ages..2012)) + geom_bar(stat="identity") +
  ggtitle("Drunk Driving Death Rates by State, USA, 2012 (All Ages)") +
  ylab("Death Rate per 100k (All Ages)") + xlab("State")



#look at figure
plot(p1)

#save figure
figure_file = here("results","resultfigure.png")
ggsave(filename = figure_file, plot=p1) 



#Now we plot the data by state for Rate of deaths (per 100,000 population)
#for people killed in crashes involving a driver with BAC =>0.08% for ages 0-20
p2 <- mydata %>% ggplot(aes(x=state.abb, y=Ages.0.20..2012)) + geom_bar(stat="identity") +
  ggtitle("Drunk Driving Death Rates by State, USA, 2012 (Ages 0-20)") +
  ylab("Death Rate per 100k (Ages 0-20)") + xlab("State")



#look at figure
plot(p2)

#save figure
figure_file = here("results","resultfigure2.png")
ggsave(filename = figure_file, plot=p2) 




#Now we plot the data by state for Rate of deaths (per 100,000 population)
#for people killed in crashes involving a driver with BAC =>0.08% for ages 21-34
p3 <- mydata %>% ggplot(aes(x=state.abb, y=Ages.21.34..2012)) + geom_bar(stat="identity") +
  ggtitle("Drunk Driving  Death Rates by State, USA, 2012 (Ages 21-34)") +
  ylab("Death Rate per 100k (Ages 21-34)") + xlab("State")



#look at figure
plot(p3)

#save figure
figure_file = here("results","resultfigure3.png")
ggsave(filename = figure_file, plot=p3) 


