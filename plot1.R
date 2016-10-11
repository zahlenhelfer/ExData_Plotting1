## read the lines with the data we need
## As an alternativ we could filter , with performance issues
## data <- subset(fulldata, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

x <- read.table(file="household_power_consumption.txt", header=FALSE, skip=66637, nrows=2880, sep=";", na.strings=c("?"))

# convert the column with the date to the data type date
x[,1] <- as.Date(x[,1], "%d/%m/%Y")

# restore lost column names
y <- read.table(file="household_power_consumption.txt", header=TRUE, nrows=1, sep=";")
colnames(x) <- colnames(y)

# create a plot
hist(x[,3], col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

# copy it to a png file
dev.copy(png, file = "plot1.png"-) 
dev.off()
 
## please notice, that the image has a transparent background (same as the images from Prof. Peng)
## on some OS the transparent background will be displayed a gray color or as a chessboard pattern.
