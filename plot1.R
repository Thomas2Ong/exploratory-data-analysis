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

## Create plot
dat$Global_active_power<- as.numeric(as.character(dat$Global_active_power))
hist(dat$Global_active_power, col="red", main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.print(device=png, filename="plot1.png", width=480, height=480)
dev.off()

