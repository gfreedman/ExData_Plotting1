## load SQL library:
library(sqldf)

# Get into the right folder:
setwd("/Users/freeg007/Documents/Coursera/Johns\ Hopkins\ University/Data\ Science/Exploratory\ Data\ Analysis/ExData_Plotting1")
getwd()

# if we don't have the data yet, download as a zip file and then unzip it:
if(!file.exists("household_power_consumption.txt"))
{
  url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  file <- basename(url)
  download.file(url, file, method = "curl")
  rawPowerData <- unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip")
}

# Read in data between 2007-02-01 and 2007-02-02:
ds <- read.csv.sql(rawPowerData, sep = ";", sql = 'select * from file where Date = "1/2/2007" OR Date = "2/2/2007"')

# Write a CSV to inspect in Excel that the data set is what we need it to be:
# write.csv(ds, file = "data.csv") 

# Concatenate date and time into one column:
ds$Date <- strptime(paste(ds$Date, ds$Time), "%d/%m/%Y %H:%M:%S")

# Frequency - Y Axis
# Global Active Power - X Axis --> Global_active_power

# Plot a histogram:
png(file = "plot1.png", width = 480, height = 480) 
with(ds, hist(Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red", bg = "transparent"))
dev.off()