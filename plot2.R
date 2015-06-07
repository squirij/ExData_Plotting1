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

##  attach dataset

attach(elec3)

## Convert variables to numeric

Global_active_power <- as.numeric(as.character(Global_active_power))

#remove large files from memory

remove(temp, elec, elec2, wkday)

## Check for NAs 

colSums(is.na(elec3))

## plot 2 = line chart Global_active_power by Weekday

png(filename="./plot2.png", height=480, width=480, bg="white", pointsize = 12)
plot(Global_active_power, pch="", ylab="Global Active Power (kilowatts)", xlab="", type="n", xaxt="n")
lines(Global_active_power)
axis(1, at=c(0,1440,2881), lab=c("Thu","Fri","Sat"))
dev.off()

## detach dataset

detach(elec3)    
     