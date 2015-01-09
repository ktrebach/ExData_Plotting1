setwd("~/Desktop/Data Scientist JH MOOC/Exploratory")
library(dplyr)

##    data is located at this url:
##    https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
##    I placed the file in my workspace
##    I unzipped it using unzip()

powerdata<-
      read.table("household_power_consumption.txt",sep=";",header=T, na.strings="?",
                 colClasses=c("character","character",rep("numeric",7)))

##create a POSIXct variable out of the Date and Time variables:
powerdata$fulldate <- as.POSIXct(paste(powerdata$Date, powerdata$Time), 
                                       format="%d/%m/%Y %H:%M:%S")

## above takes about 30-45 seconds to read

##Subset data from the dates 2007-02-01 and 2007-02-02

powerdata2<-powerdata[powerdata$fulldate>=as.POSIXct("2007-02-01")&
                           powerdata$fulldate<as.POSIXct("2007-02-03"),]

## Create the requested plot
png(filename = "plot3.png",width = 480, height = 480)

with(powerdata2, {
      plot(x=powerdata2$fulldate, y=powerdata2$Sub_metering_1,type="l", col="black", xlab="",ylab="Energy sub metering")
      lines(x=powerdata2$fulldate, y=powerdata2$Sub_metering_2,type="l", col="red")
      lines(x=powerdata2$fulldate, y=powerdata2$Sub_metering_3,type="l", col="blue")
      legend("topright",col=c("black","red","blue"),lty=1,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
})


dev.off()
