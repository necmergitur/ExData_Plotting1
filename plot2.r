# plot2.r
# week 1 project in "Eploratory Data Analysis" coursera module

# get package if not present
if("sqldf" %in% rownames(installed.packages()) == FALSE) {install.packages("sqldf")}
library("sqldf")

# read data file - assumption: data file in working directory
# selects only data from Feb 1st and 2nd (2007)
mysource <- paste(getwd(), "/household_power_consumption.txt" ,sep="")
mydata <- read.csv.sql(mysource, sep=";",sql = 'select * from file where ((Date like "1/2/2007" or Date like "2/2/2007"))')

# prepping data for plot
my_x <- as.POSIXct(strptime(paste(mydata$Date,mydata$Time), "%e/%m/%Y %H:%M:%S"))
mylength <- as.numeric(length(my_x))

my_y0 <- mydata$Global_active_power

# create png file and plot data
png("plot2.png", width = 480, height = 480)
plot(my_x, my_y0, col="black", main = "", xlab="", xaxt = "n", ylab = "Global Active Power (kilowatts)", type = "l")
axis(1,as.POSIXct(c(my_x[1], my_x[mylength/2], my_x[mylength])),labels=c("Thu","Fri","Sat"))
dev.off()



