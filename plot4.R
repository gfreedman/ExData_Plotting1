## load SQL library:
library(sqldf)

# Get into the right folder:
setwd("/Users/freeg007/Documents/Coursera/Johns\ Hopkins\ University/Data\ Science/Exploratory\ Data\ Analysis/ExData_Plotting1")
getwd()

# if we don't have the data yet, download as a zip file and then unzip it:
if(!file.exists("household_power_consumption.txt")){
  url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  file <- basename(url)
  download.file(url, file, method = "curl")
  rawPowerData <- unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip")
}else{
  rawPowerData <- "household_power_consumption.txt"
}

# Read in data between 2007-02-01 and 2007-02-02:
ds <- read.csv.sql(rawPowerData, sep = ";", sql = 'select * from file where Date = "1/2/2007" OR Date = "2/2/2007"')

# Concatenate date and time into one column:
ds$Date <- strptime(paste(ds$Date, ds$Time), "%d/%m/%Y %H:%M:%S")

# Create a new blank PNG file:
png(file = "plot4.png", width = 480, height = 480, bg = "transparent", units = 'px')
# I also make pngs at 504 X 504 to compare them to the original files for accuracy

# Plot a histogram:
# I'm making it transparent just to match what's in the example:

par(mfrow = c(2, 2), mar = c(5, 4, 4, 2), oma = c(0, 0, 0, 0))
with(ds, {
  # plot 1:
  plot(Date, Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")
  
  # plot 2:
  plot(Date, Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
  
  # plot 3:
  plot(Date, Sub_metering_1, type="s", ylab="Energy sub metering", xlab="", col="black")
  lines(Date, Sub_metering_2, type="s", ylab="Energy sub metering", xlab="", col="red")
  lines(Date, Sub_metering_3, type="s", ylab="Energy sub metering", xlab="", col="blue")
  legend("topright", lty = c(1,1), cex = 1.0, bty = "n", col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))  
  
  # plot 4:
  plot(Date, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
})

# Close the graphics connection to finish the file:
dev.off()

# close any connections that may still be open:
closeAllConnections()

# garbage collection to be safe:
gc()