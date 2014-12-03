# Module 4 - Project 1

library(dplyr)

fileZipURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileZipLocal <- "HPC.zip"
download.file(fileZipURL, destfile = fileZipLocal)

unzip(fileZipLocal)
filename <- unzip(fileZipLocal, list=TRUE)

# Dataset size estimation
nrow <- 2075259
byterow <- 10*9
kbytetotal <- nrow*byterow/2^10
Mbytetotal <- kbytetotal/2^10
# OK for size

DFClasses = c("character", "character", rep("numeric",7))
PCDF <- read.table(filename$Name, header=TRUE, sep=";", na.strings="?", colClasses = DFClasses)

# Converting Date...
PCDF$Date <- as.Date(PCDF$Date, format = "%d/%m/%Y") # Note : this could be skipped and included in strptime
PCDF$Date <- as.character(PCDF$Date)
# Combining it with the time...
PCDF <- mutate(PCDF, datetime = paste(Date,Time))
PCDF$datetime <- strptime(PCDF$datetime, format = "%Y-%m-%d %H:%M:%S")

# Subsetting the DF for the selected period

PCDF_sub= PCDF[(PCDF$Date == "2007-02-01") | (PCDF$Date == "2007-02-02") ,]

# CHange the language to avoid weekdays in French...
language <- "English" 
Sys.setlocale("LC_TIME", language) 

png(filename = "plot2.png")
plot(PCDF_sub$datetime, PCDF_sub$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type = "l")
dev.off() 
