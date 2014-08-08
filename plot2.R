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
png(file = "plot2.png", width = 480, height = 480, bg = "transparent", units = 'px')
# I also make pngs at 504 X 504 to compare them to the original files for accuracy

# Plot a histogram:
# I'm making it transparent just to match what's in the example:
with(ds, plot(Date, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))

# Close the graphics connection to finish the file:
dev.off()

# close any connections that may still be open:
closeAllConnections()

# garbage collection to be safe:
gc()