library(readr)

setwd("/Desktop/Data Science Course Notes/4_ExpDataAnalysis")
# Loading the data
filename <- "Coursera_EDA_Wk1.zip"

# Check if archive already exists
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, filename, method="curl")
}  

unzip(filename)

# Load text file
DOI <- read.table("household_power_consumption.txt", 
                  header=TRUE, 
                  colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'),
                  sep=";", 
                  na.strings = "?")

# Remove incomplete cases
DOI <- DOI[complete.cases(DOI),]

# Format date to Type Date
DOI$Date <- as.Date(DOI$Date, "%d/%m/%Y")

# Filter data from Feb. 1, 2007 to Feb. 2, 2007
DOI <- subset(DOI,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# Combine Date and Time columns into One
DTcol <- paste(DOI$Date, DOI$Time)
DTcol <- setNames(DTcol, "DTcol")

# Add DTcol and format column
DOI <- cbind(DTcol, DOI)
DOI$DTcol <- as.POSIXct(DTcol)

# Remove Date and Time columns
DOI <- DOI[ ,!(names(DOI) %in% c("Date","Time"))]

# Generate and Save Plot 1
png("plot1.png", width = 480, height = 480)

hist(DOI$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

dev.off()