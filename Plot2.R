## Check if the data folder exists and if not, create it
	if(!file.exists("./Data")){dir.create("./Data")}
	fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## check if data.zip exists in the ./Data folder and if not, download the data to it
	if(!file.exists("./Data/Data.zip")){download.file(fileUrl,destfile = "./Data/data.zip")}

## check if the unzipped data file exists, and if not, unzip the data file
	if(!file.exists("./Data/household_power_consumption.txt")){unzip("./Data/data.zip", exdir = "./Data")}

## read in the data to a dataframe
	powerdata <- read.table("./Data/household_power_consumption.txt", header = TRUE, sep = ";", dec = ".", na.strings = "?", colClasses = c(NA, NA, rep ("numeric", 7)))

## add a date/time field, converting the date and time string fields to date and time
	powerdata$datetime <- strptime(paste(powerdata$Date, "-", powerdata$Time, sep=""), "%d/%m/%Y-%H:%M:%S")

## subset the data to the two dates requried
	powerdata <- subset(powerdata, (datetime >= "2007-02-01 00:00:00" & datetime < "2007-02-03 00:00:00"))

## draw the required histogram and save as a png file
	png(filename = "Plot2.png", width = 480, height = 480, units = "px")
	with(powerdata, plot(datetime, Global_active_power, type = "n", xlab = NA, ylab = "Global Active Power (kilowatts)"))
	with(powerdata, lines(datetime, Global_active_power))
	dev.off()