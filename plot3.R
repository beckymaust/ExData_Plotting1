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

#plot 3
par()
par( mar = c(2,4,2,2))
with(myData, {
  plot(Time, Sub_metering_1, type="n", ylab = "Energy sub metering")
  lines(Time, Sub_metering_1, col = "black")
  lines(Time, Sub_metering_2, col = "red")
  lines(Time, Sub_metering_3, col = "blue") 
  legend("topright", lty = c(1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

dev.copy(png, file = "plot3.png", width = 480, height = 480, units = "px")
dev.off()