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

## put the plots in a 2x2 matrix, set marigins so there's enough room for labels
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
  plot(Global_active_power~Datetime, type="l",   ylab="Global Active Power",  xlab="")
  plot(Voltage~Datetime, type="l",               ylab="Voltage", 				xlab="datetime")
  plot(Sub_metering_1~Datetime,      type="l",   ylab="Energy sub metering",  xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  
  ## create the legend for the sub-metering	
  legend("topright", lty=1, lwd=2, bty="n", 
         col=c("black", "red", "blue"), 
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(Global_reactive_power~Datetime, type="l", ylab="Global_reactive_power", xlab="datetime")
})

## create the png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off() 

## please notice, that the image has a transparent background (same as the images from Prof. Peng)
## on some OS the transparent background will be displayed a gray color or as a chessboard pattern.  