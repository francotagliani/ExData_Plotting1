initial_folder <- "./data2/"
filename <- paste(initial_folder,"Final_Exam.zip",sep="")

# Checking if archieve already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename)
  unzip(filename,exdir=gsub("/$","",initial_folder))
  file.remove(filename)
}  

library(hms)

data <- read.table("./data2/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
names(data)
str(data)
data$Date <- as.Date(data$Date, format='%d/%m/%Y')
str(data$Date)
data$Time<-as_hms(data$Time)
str(data$Time)

data_interest <- data[which(data$Date == "2007-02-01"|data$Date == "2007-02-02"),]
data_interest <- data_interest[complete.cases(data_interest),]

#Combine both date and time columns
date_complete <- with(data_interest,paste(Date,Time))
date_complete <- setNames(date_complete,"date_complete")
date_complete<- as.POSIXct(date_complete)
data_interest <- data_interest[,3:9]
data_interest <- cbind(date_complete,data_interest)

#1 plot
name_plot = "plot1.png"
hist(data_interest$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power",breaks=11)
dev.print(png,file=name_plot,width=480,height=480,units = "px")
dev.off()
#2 plot
name_plot = "plot2.png"
plot(data_interest$Global_active_power~data_interest$date_complete,xlab = "",ylab= "Global Active Power (kilowatts)",type="l")
dev.print(png,file=name_plot,width=480,height=480,units = "px")
dev.off()
#3 plot
name_plot = "plot3.png"
with(
  data_interest,{plot(Sub_metering_1~date_complete,type="l",xlab = "",ylab="Global Active Power(kilowatts)")
  lines(Sub_metering_2~date_complete,type="l",col="red")
  lines(Sub_metering_3~date_complete,type="l",col="blue")
  })
legend("topright",lwd=c(1,1,1),col=c("black","blue","red"),legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), adj = c(0, 0.6), cex=0.75)
dev.print(png,file=name_plot,width=480,height=480,units = "px")
dev.off()
#4 plot
name_plot = "plot4.png"
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data_interest,plot(Global_active_power~date_complete, type="l",ylab="Global Active Power (kilowatts)", xlab=""))
with(data_interest,plot(Voltage~date_complete, type="l",ylab="Voltage (volt)", xlab=""))
with(
  data_interest,{plot(Sub_metering_1~date_complete,type="l",xlab = "",ylab="Global Active Power(kilowatts)")
    lines(Sub_metering_2~date_complete,type="l",col="red")
    lines(Sub_metering_3~date_complete,type="l",col="blue")
  })
legend("topright",lwd=c(1,1,1),col=c("black","blue","red"),legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), adj = c(0, 0.6), cex=0.7)

with(data_interest,plot(Global_reactive_power~date_complete, type="l",ylab="Global Rective Power (kilowatts)",xlab=""))

dev.print(png,file=name_plot,width=480,height=480,units = "px")
dev.off()
#Delete File when the execution ends
file.remove(paste("./data2/",list.files("./data2"),sep=''))
            
