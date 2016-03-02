# Section1:checks if processed file exists,if it doesnt reads raw file , subsets required days, formats dates and writes tidy file. Saves
#processing time when running multiple Rscripts.
if(file.exists("tidypower.txt")){
  cat("processed power consumption file  exists")
  
} else {
  cat("reading data and creating subsetted file with required dates")
  #reads raw file
  household_power_consumption <- read.csv("household_power_consumption.txt",header=TRUE, sep=";",na.strings="?")
  # subsets required days
  powerdays<-subset(household_power_consumption ,Date == "1/2/2007" | Date == "2/2/2007")
  
  #formats dates 
  datetime <-strptime(paste(powerdays$Date, powerdays$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
  tidypower <- cbind(datetime, powerdays)
  #writes processed file 
  write.table(tidypower, "tidypower.txt",row.names = FALSE)
}

#section2:creates plot4
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

with(tidypower,plot(datetime,Global_active_power,type="l",ylab="Global Active Power", xlab=""))

with(tidypower,plot(datetime,Voltage,type="l"))

plot(tidypower$datetime, tidypower[,"Sub_metering_1"], col="black" ,type="l",ylab="Energy sub metering", main="", xlab="")
lines(tidypower$datetime, tidypower[,"Sub_metering_2"], col="red" )
lines(tidypower$datetime, tidypower[,"Sub_metering_3"], col="blue")
legend("topright",lty=1,lwd=2,cex=0.6,bty="n",col=c("black","red","blue"),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

with(tidypower,plot(datetime,Global_reactive_power,type="l"))


dev.off()