#Loading appropriate packages
library(lubridate)
library(dplyr)

#Loading raw data
#Since Plot1 would generate the unpackaged TXT file, I won't unpack it again
#However it doesn't appear in the repo, because it's size is bigger than the upload limit
myDataSet <- read.table("household_power_consumption.txt", sep=";", na.strings = "?", header = TRUE)
myDataSet[, 3:9] <- lapply(myDataSet[, 3:9], as.numeric)
myDataSet$DateTime <- dmy_hms(paste(myDataSet$Date,myDataSet$Time))

#Subsetting to 2007-02-01:02
myDataSet <- filter(myDataSet, DateTime >= ymd_hms("2007/02/01 00:00:00") & DateTime < ymd_hms("2007/02/03 00:00:00"))

#Making the plots - note that my environment is Hungarian, so the weekday names are also in HU
png("plot4.png", width = 480, height = 480)
par(mfcol=c(2,2))

#Plot 1 (topleft)
plot(myDataSet$DateTime, myDataSet$Global_active_power, 
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

#Plot 2 (bottomleft)
plot(myDataSet$DateTime,myDataSet$Sub_metering_1, 
     type="n", 
     xlab="", 
     ylab="Energy sub metering")
points(myDataSet$DateTime, myDataSet$Sub_metering_1, type = "l")
points(myDataSet$DateTime, myDataSet$Sub_metering_2, col="red", type = "l")
points(myDataSet$DateTime, myDataSet$Sub_metering_3, col="blue", type = "l")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_2"), 
       col=c("black","red","blue"), 
       lty=1)

#Plot 3 (topright)
plot(myDataSet$DateTime, myDataSet$Voltage, 
        type = "l",
        ylab = "Voltage",
        xlab = "datetime")

#Plot 4 (bottomright)
plot(myDataSet$DateTime, myDataSet$Global_reactive_power, 
        type = "l",
        ylab = "Global_Reavtive_power",
        xlab = "datetime")

dev.off()
