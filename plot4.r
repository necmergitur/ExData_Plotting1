# plot4.r
# week 1 project in "Eploratory Data Analysis" coursera module

# get package if not present
if("sqldf" %in% rownames(installed.packages()) == FALSE) {install.packages("sqldf")}
library("sqldf")

# read data file - assumption: data file in working directory
# selects only data from Feb 1st and 2nd (2007)
mysource <- paste(getwd(), "/household_power_consumption.txt" ,sep="")

#closing any unused connection
if (!is.null(getOption("sqldf.connection"))) sqldf()

mydata <- read.csv.sql(mysource, sep=";",sql = 'select * from file where ((Date like "1/2/2007" or Date like "2/2/2007"))')

#closing connection
if (!is.null(getOption("sqldf.connection"))) sqldf()

# prepping data for plot
my_x <- as.POSIXct(strptime(paste(mydata$Date,mydata$Time), "%e/%m/%Y %H:%M:%S"))
mylength <- as.numeric(length(my_x))

my_y0 <- mydata$Global_active_power
my_y1 <- mydata$Sub_metering_1
my_y2 <- mydata$Sub_metering_2
my_y3 <- mydata$Sub_metering_3
my_y4 <- mydata$Voltage
my_y5 <- mydata$Global_reactive_power



# create png file and plot data
png("plot4.png", width = 480, height = 480)
# plotting...
par(mfrow = c(2,2))
with(mydata, {
	# (1,1)
	plot(my_x, my_y0, lwd=0.25, col="black", main = "", xlab="", xaxt = "n", ylab = "Global Active Power", type = "l")
	axis(1,as.POSIXct(c(my_x[1], my_x[mylength/2], my_x[mylength])),labels=c("Thu","Fri","Sat"))

	# (1,2)
	plot(my_x, my_y4, lwd=0.25, col="black", main = "", xaxt = "n", xlab = "datetime", ylab = "Voltage", type = "l")
	axis(1,as.POSIXct(c(my_x[1], my_x[mylength/2], my_x[mylength])),labels=c("Thu","Fri","Sat"))	
	
	# (2,1)
	plot(my_x, my_y1, col="black", main = "", xlab="", xaxt = "n", ylab = "Energy sub metering", type = "l")
	lines(my_x, my_y2, col="red", type = "l")
	lines(my_x, my_y3, col="blue", type = "l")
	legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),  col = c("black", "red", "blue"), lwd=1, lty=c(1,1,1), pch = c(NA,NA,NA), bty = "n")
	axis(1,as.POSIXct(c(my_x[1], my_x[mylength/2], my_x[mylength])),labels=c("Thu","Fri","Sat"))
	
	# (2,2)
	plot(my_x, my_y5, lwd=0.25, col="black", main = "", xaxt = "n", xlab = "datetime", ylab = "Global_reactive_power", type = "l")
	axis(1,as.POSIXct(c(my_x[1], my_x[mylength/2], my_x[mylength])),labels=c("Thu","Fri","Sat"))	
	
	}
)
dev.off()



