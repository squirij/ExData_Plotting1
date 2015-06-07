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

## attach dataset

attach(elec3)

## Convert variables to numeric

Global_active_power <- as.numeric(as.character(Global_active_power))
Global_reactive_power <- as.numeric(as.character(Global_reactive_power))
Voltage <- as.numeric(as.character(Voltage))
Global_intensity <- as.numeric(as.character(Global_intensity))
Sub_metering_1 <- as.numeric(as.character(Sub_metering_1))
Sub_metering_2 <- as.numeric(as.character(Sub_metering_2))

#remove large files from memory

remove(temp, elec, elec2, wkday)

## Check for NAs 

colSums(is.na(elec3))

## plot 4
png(filename="./plot4.png", height=480, width=480, bg="white", pointsize = 12)
par(mfrow=c(2,2))
plot(Global_active_power, pch="", ylab="Global Active Power", xlab="", type="n", xaxt="n")
lines(Global_active_power)
axis(1, at=c(0,1440,2881), lab=c("Thu","Fri","Sat"))

plot(Voltage, pch="", ylab="Voltage", xlab="datetime", type="n", xaxt="n")
lines(Voltage)
axis(1, at=c(0,1440,2881), lab=c("Thu","Fri","Sat"))

plot(Sub_metering_1, pch="", ylab="Energy sub metering", xlab="", type="n", xaxt="n")
lines(Sub_metering_1)
axis(1, at=c(0,1440,2881), lab=c("Thu","Fri","Sat"))
lines(Sub_metering_2, col="red")
lines(Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n", cex=.8, xjust=1)

plot(Global_reactive_power, pch="", ylab="Global_reactive_power", xlab="datetime", type="n", xaxt="n")
lines(Global_reactive_power)
axis(1, at=c(0,1440,2881), lab=c("Thu","Fri","Sat"))
axis(2, las=1, at=1:6, lab=c("0.0","0.1","0.2","0.3","0.4","0.5"))

dev.off() 

## detach dataset

detach(elec3)    
     