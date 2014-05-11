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

#plot 1
par()
with(myData, hist(Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "Red"))
dev.copy(png, file = "plot1.png", width = 480, height = 480, units = "px")
dev.off()