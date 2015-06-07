setwd("~/Desktop/Exploratory/Data")

library(lubridate)

## Retrieve total dataset

elec <- read.table(file = "./household_power_consumption.txt", header = TRUE, sep=";", na.strings="NA", stringsAsFactors=FALSE)

## Convert date and subset data retrieving only 2/1/2007 and 2/2/2007 data

temp <- as.Date(elec$Date, "%d/%m/%Y")
elec2 <- cbind(elec, temp)
elec3 <- subset(elec2, temp=="2007-02-01"|temp=="2007-02-02")
wkday <- wday(elec3$temp, label=TRUE, abbr=TRUE)
elec3 <- cbind(elec3,wkday)
elec3 <-within(elec3, { timestamp=format(as.POSIXct(paste(temp, Time)), "%d/%m/%Y %H:%M:%S") })

attach(elec3)

## Convert variables to numeric

Global_active_power <- as.numeric(as.character(Global_active_power))

#remove large files from memory

remove(temp, elec, elec2, wkday)

## Check for NAs 

colSums(is.na(elec3))

## plot 1
png(filename="./plot1.png", height=480, width=480, bg="white", pointsize = 12)
hist(Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)",)
dev.off()

detach(elec3)    
     