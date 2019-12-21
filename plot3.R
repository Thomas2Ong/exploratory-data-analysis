rm(list=ls())
filename <- "./Data/household_power_consumption.txt"
dat <- read.table(filename, sep=";", header=TRUE)

## paste & strptime column Date & Time
dat$newDate <- paste(dat$Date, dat$Time)
dat$newDate <- strptime(dat$newDate,"%d/%m/%Y %H:%M:%S")
dat$newDate <- as.POSIXct(dat$newDate)

## Filter date "2007-02-01" & "2007-02-02"
library(lubridate)
library(dplyr)
dat$Date <- dmy(dat$Date)
dat$Time <- hms(dat$Time)
date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")
dat <- filter(dat, Date==date1 | Date==date2)

## Create column for Weekday
dat$Weekday <- weekdays(dat$newDate)

## Convert from factor to numeric
dat$Sub_metering_1 <- as.numeric(as.character(dat$Sub_metering_1))
dat$Sub_metering_2 <- as.numeric(as.character(dat$Sub_metering_2))

## Create plot
par(xpd=TRUE)
with(dat, plot(newDate, Sub_metering_1, type="l", xlab="", 
               ylab="Energy sub metering", col="black"))
par(new=T)
with(dat, plot(newDate, Sub_metering_2, type="l", ylim=c(0,30), xlab="", axes=FALSE, 
               ylab="", col="red"))
par(new=T)
with(dat, plot(newDate, Sub_metering_3, type="l", ylim=c(0,30), xlab="", axes=FALSE,
               ylab="", col="blue"))
legend("topright", col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, cex=0.6)

## create png file
dev.print(device=png, filename="plot3.png", width=480, height=480)
dev.off()
