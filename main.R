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

data <- read.table(paste("./data2/",list.files("./data2"),sep=''),sep = ";",header=TRUE)
names(data)
str(data)
data$Date <- as.Date(data$Date, format='%d/%m/%Y')
str(data$Date)
data$Time<-as_hms(data$Time)
str(data$Time)

#Delete File when the execution ends
file.remove(paste("./data2/",list.files("./data2"),sep=''))
            