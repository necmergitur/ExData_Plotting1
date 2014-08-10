# plot1.r
# week 1 project in "Eploratory Data Analysis" coursera module

# get package if not present
if("sqldf" %in% rownames(installed.packages()) == FALSE) {install.packages("sqldf")}
library("sqldf")

# read data file - assumption: data file in working directory
# selects only data from Feb 1st and 2nd (2007)
mysource <- paste(getwd(), "/household_power_consumption.txt" ,sep="")

mydata <- read.csv.sql(mysource, sep=";",sql = 'select * from file where (Date like "1/2/2007" or Date like "2/2/2007")')

# create png file and plot histogram
png("plot1.png", width = 480, height = 480)
hist(mydata$Global_active_power, freq=TRUE, col="red", main = "Global Active Power", xlab="Global Active Power (frequency)", ylab = "Frequency", ylim=c(0,1200))
dev.off()




