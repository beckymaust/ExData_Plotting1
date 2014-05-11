#loads Data
data <- read.table("household_power_consumption.txt", sep=";", header = TRUE, na.strings = "?")

#subsets to specific days
myData <- data[which(data$Date == "1/2/2007" | data$Date == "2/2/2007"),]

#clears large data frame
rm(data)

#formats first Date column as a date and Time column as Date Time
myData[,1] <- as.Date(myData[,1], "%d/%m/%Y")
myData[,2] <- paste(myData[,1], myData[,2], sep = " ")
myData <- transform(myData, Time = as.POSIXct(Time))
myData[,2] <- as.POSIXct(strptime(myData[,2], '%Y-%m-%d %H:%M:%S'))

#plot 4
par()
par(mfrow = c(2, 2), mar = c(4, 4, 4, 2))
with(myData, {
  plot(Time, Global_active_power, type="n", ylab = "Global Active Power (kilowatts)")
  lines(Time, Global_active_power)
  plot(Time, Voltage, type="n", xlab = "datetime", ylab = "Voltage")
  lines(Time, Voltage)
  plot(Time, Sub_metering_1, type="n", ylab = "Energy sub metering")
  lines(Time, Sub_metering_1, col = "black")
  lines(Time, Sub_metering_2, col = "red")
  lines(Time, Sub_metering_3, col = "blue") 
  legend("topright", lty = c(1,1), col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         box.lwd = 0, box.col = "white", cex = .5)
  plot(Time, Global_reactive_power, type="n", xlab = "datetime", ylab = "Global_reactive_power")
  lines(Time, Global_reactive_power)
})

dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px")
dev.off()