# Exploratory Data Analysis Course Project 1
# Coder: Joanne Lee. June 5, 2015
# Goal: Examine how household energy usage varies over a 2-day period in February, 2007. 
#       Reconstruct plot4 below using the base plotting system.

## Calculate rough estimate of how much memory the dataset will require in memory before reading into R
object.size("household_power_consumption.txt")
# Answer: 120 bytes

## Read subset of data  from the dates 2007-02-01 and 2007-02-02 from "household_power_consumption.txt" file
mydata = read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?")
mydata$Date = as.Date(mydata$Date,"%d/%m/%Y")
d = strptime(mydata$Time, "%H:%M:%S")
mydata$Time = strftime(d, format="%H:%M:%S")
mydata2 = mydata[mydata$Date >= "2007-02-01" & mydata$Date <= "2007-02-02", ]

## Plot 4 multiple base plots across two days. Insert legend
par(mfrow=c(2,2))
# Subplot (1,1)
plot(mydata2$Global_active_power, type="l", xlab="",ylab="Global Active Power (kilowatts)",xaxt = "n" ) 
axis(side=1, at=seq(0,2880, 1440), labels=c("Thu","Fri","Sat"))

# Subplot (1,2)
plot(mydata2$Voltage, type="l", xlab="datetime",ylab="Voltage",xaxt = "n" ) 
axis(side=1, at=seq(0,2880, 1440), labels=c("Thu","Fri","Sat"))
axis(side=2, at=seq(234,246,4), labels=c("234","238","242","246"))

# Subplot (2,1)
# Calculate range from 0 to max of the three sub_metering data
g_range = range(0, mydata2$Sub_metering_1, mydata2$Sub_metering_2,mydata2$Sub_metering_3)  
plot(mydata2$Sub_metering_1, type="l", xlab="",ylab="Energy sub metering",xaxt = "n" ,ylim=g_range)
axis(side=1, at=seq(0,2880, 1440), labels=c("Thu","Fri","Sat"))
lines(mydata2$Sub_metering_2,col="red")
lines(mydata2$Sub_metering_3,col="blue")
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.5, lty=c(1,1,1))

# Subplot (2,2)
plot(mydata2$Global_reactive_power, type="l", xlab="datetime",ylab="Global_reactive_power",xaxt = "n" ) 
axis(side=1, at=seq(0,2880, 1440), labels=c("Thu","Fri","Sat"))
axis(side=2, at=seq(0.0,0.5,0.1), labels=c("0.0","0.1","0.2","0.3","0.4","0.5"))

## Save plot as plot4.png
dev.copy(png,'plot4.png',width = 480, height = 480)
dev.off()
