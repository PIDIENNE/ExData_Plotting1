# Module 4 - Project 1


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

# Converting only Date, Time is not relevant for this plot
PCDF$Date <- as.Date(PCDF$Date, format = "%d/%m/%Y")

# Subsetting the DF for the selected period

PCDF_sub= PCDF[(PCDF$Date == "2007-02-01") | (PCDF$Date == "2007-02-02") ,]

png(filename = "plot1.png")
hist(PCDF_sub$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off() 