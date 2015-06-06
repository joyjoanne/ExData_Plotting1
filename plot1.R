# Exploratory Data Analysis Course Project 1
# Coder: Joanne Lee. June 5, 2015
# Goal: Examine how household energy usage varies over a 2-day period in February, 2007. 
#       Reconstruct plot1 using the base plotting system.

## Calculate rough estimate of how much memory the dataset will require in memory before reading into R
object.size("household_power_consumption.txt")
# Answer: 120 bytes

## Read subset of data  from the dates 2007-02-01 and 2007-02-02 from "household_power_consumption.txt" file
mydata = read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?")
mydata$Date = as.Date(mydata$Date,"%d/%m/%Y")
d = strptime(mydata$Time, "%H:%M:%S")
mydata$Time = strftime(d, format="%H:%M:%S")
mydata2 = mydata[mydata$Date >= "2007-02-01" & mydata$Date <= "2007-02-02", ]

## Plot histogram of Global Active Power
hist(mydata2$Global_active_power,main = paste("Global Active Power"),xlab = "Global Active Power (kilowatts)",
     col="red")
axis(side=2, at=seq(0,1200, 200), labels=seq(0,1200,200))

## Save plot as plot1.png
dev.copy(png,'plot1.png',width = 480, height = 480)
dev.off()
