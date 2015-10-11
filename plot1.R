library(dplyr)

# Load Data
houseData <- read.csv('household_power_consumption.txt', 
                      sep = ';', header = TRUE, na.strings = "?")

# Merge Date and Time and Convert to POSIXct
houseData <- houseData %>% mutate(DateTime = paste(Date, Time))
houseData$Date  <- as.POSIXct(strptime(houseData$DateTime, format = "%d/%m/%Y %T"))

# Subset required data
startTime <- as.POSIXct(strptime("01/02/2007 00:00:00", format = "%d/%m/%Y %T"))
endTime <- as.POSIXct(strptime("02/02/2007 23:59:59", format = "%d/%m/%Y %T"))
houseData <- houseData %>% filter(Date >= startTime & Date <= endTime) %>%
    select(-Time,-DateTime)

# Open Device
png("plot1.png", width = 480, height = 480)

# Plot
with(houseData, 
     hist(Global_active_power, col = "red",
          xlab = "Global Active Power (kilowatts)",
          main = "Global Active Power"))

# Save
dev.off()