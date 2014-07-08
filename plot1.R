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

## Open PNG device; create 'plot1.png' in working directory
png(file ="plot1.png", width = 480, heigh = 480) 
##Create histogram with global_active_power column as it's data set
hist(elecData$Global_active_power, col = "red", xlab = 
             "Global Active Power (kilowatts)", main="Gloabl Active Power")
##Close PNG device
dev.off()