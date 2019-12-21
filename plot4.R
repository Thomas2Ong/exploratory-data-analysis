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


par(mfrow=c(2,2), mar=c(5,5,2,1), oma=c(0,0,2,0), ps=8)


## Create plot-1
dat$Global_active_power<- as.numeric(as.character(dat$Global_active_power))
plot(dat$newDate, dat$Global_active_power, type="l", xlab="", ylab="Global Active Power")

## Create plot-2
dat$Voltage <- as.numeric(as.character(dat$Voltage))
with(dat, plot(newDate, Voltage, ylim=c(234, 246), xlab="datetime", type="l"))

## Create plot-3
## Convert from factor to numeric
dat$Sub_metering_1 <- as.numeric(as.character(dat$Sub_metering_1))
dat$Sub_metering_2 <- as.numeric(as.character(dat$Sub_metering_2))

## plot
par(xpd=TRUE)
with(dat, plot(newDate, Sub_metering_1, type="l", xlab="", 
               ylab="Energy sub metering", col="black"))
par(new=T)
with(dat, plot(newDate, Sub_metering_2, type="l", ylim=c(0,30), xlab="", axes=FALSE, 
               ylab="", col="red"))
par(new=T)
with(dat, plot(newDate, Sub_metering_3, type="l", ylim=c(0,30), xlab="", axes=FALSE,
               ylab="", col="blue"))
legend("topright", inset=0.01, box.lty=0, col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, cex=0.6)

## Create plot-4
dat$Global_reactive_power <- as.numeric(as.character(dat$Global_reactive_power))
with(dat, plot(newDate, Global_reactive_power, xlab="datetime", ylim=c(0.0, 0.5), type="l"))

## create png file
dev.print(device=png, filename="plot4.png", width=480, height=480)
dev.off()












