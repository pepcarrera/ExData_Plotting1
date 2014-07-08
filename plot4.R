



##Load Data from Data set
##Set ? entries as NA while using ; as seperator for the data
elecData <- read.table("household_power_consumption.txt", 
                       header=TRUE, sep=";", na.strings="?")
##Set ? Convert Date column in data set to date format
elecData$Date <-as.Date(elecData$Date, format="%d/%m/%Y")
##Subset just the data we are interested in (2007-02-01 through 2007-02-02)
elecData <- elecData[elecData$Date >= as.Date("2007-02-01") & elecData$Date <= as.Date("2007-02-02"),]
##create vector with Date & Time column combined
Date_time <- strptime(paste(elecData$Date, elecData$Time), "%Y-%m-%d %H:%M:%S")
##Add new Date_time vector as a column while dropping existing date/time columns
elecData <- cbind(Date_time, subset(elecData, 
                                    select=Global_active_power:Sub_metering_3))

## Open PNG device; create 'plot2.png' in working directory
png(file ="plot4.png", width = 480, heigh = 480) 

##Sets gloabl parameter to fix 2x2 plots
par(mfrow= c(2,2))

##Create top right graph, Date_time as x, Global Active Power as y
plot(elecData$Date_time, elecData$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power")

##Create top right graph, Date_time as x, Voltage as y
plot(elecData$Date_time, elecData$Voltage, type="l", xlab="datetime", 
     ylab="Voltage")

##Create bottom left graph with Date_time as the x and Sub_metering_1 as y
plot(elecData$Date_time, elecData$Sub_metering_1, type="l", xlab="", 
     ylab="Energy sub metering")

##Add Sub_metering_2 as red line
lines(elecData$Date_time, elecData$Sub_metering_2, col="red")

##Add Sub_metering_3 as blue line
lines(elecData$Date_time, elecData$Sub_metering_3, col="blue")

##Add legend
legend(x="topright", legend=c("Sub_metering_1", "Sub_metering_2", 
        "Sub_metering_3"), lty=c(1,1,1), col=c("black", "red", "blue"), bty="n")

##Create bottom right graph, Date_time as x, Voltage as y
plot(elecData$Date_time, elecData$Global_reactive_power, type="l", 
        ylab="Global_reactive_power", xlab="datetime")


##Close PNG device
dev.off()
