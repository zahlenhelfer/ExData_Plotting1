## read the lines with the data we need
## As an alternativ we could filter with something like 
## data <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
## but that would be MUCH slower
data <- read.table(file="household_power_consumption.txt", header=FALSE, skip=66637, nrows=2880, sep=";", na.strings=c("?"))

# restore the lost column names
data2 <- read.table(file="household_power_consumption.txt", header=TRUE, nrows=1, sep=";")
colnames(data) <- colnames(data2)

## convert the date column 
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## creating a new column with the combined date and time
data$Datetime <- as.POSIXct(paste(as.Date(data$Date), data$Time))

## plot the data

with(data, {
  plot(data$Sub_metering_1~data$Datetime, type="l", ylab="Energy sub metering", xlab="")
  lines(data$Sub_metering_2~data$Datetime, col="red")
  lines(data$Sub_metering_3~data$Datetime, col="blue")
})

legend("topright", col=c("black","red","blue"), lty=1, lwd=2, legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## create the png file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off() 

## please notice, that the image has a transparent background (same as the images from Prof. Peng)
## on some OS the transparent background will be displayed a gray color or as a chessboard pattern.  