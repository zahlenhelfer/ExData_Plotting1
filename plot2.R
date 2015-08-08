## read the lines with the data we need
## As an alternativ we could filter with something like 
## data <- subset(fulldata, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
## but that would be much slower

data <- read.table(file="household_power_consumption.txt", header=FALSE, skip=66637, nrows=2880, sep=";", na.strings=c("?"))

# restore the lost column names
data2 <- read.table(file="household_power_consumption.txt", header=TRUE, nrows=1, sep=";")
colnames(data) <- colnames(data2)

## convert the date column 
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## creating a new column with the combined date and time
data$Datetime <- as.POSIXct(paste(as.Date(data$Date), data$Time))

## plot the data
plot(data$Global_active_power~data$Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## create the png file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off() 

## please notice, that the image has a transparent background (same as the images from Prof. Peng)
## on some OS the transparent background will be displayed a gray color or as a chessboard pattern.  