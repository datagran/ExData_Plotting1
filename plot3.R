# section 1:checks if processed file exists,if it doesnt reads raw file , subsets required days, formats dates and writes tidy file. Saves
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
#Section 2:creates plot3
dev.copy(png,file="plot3.png")
plot(tidypower$datetime, tidypower[,"Sub_metering_1"], col="black",type="l",ylab="Energy sub metering", main="", xlab="")
lines(tidypower$datetime, tidypower[,"Sub_metering_2"], col="red" )
lines(tidypower$datetime, tidypower[,"Sub_metering_3"], col="blue")
legend("topright",lty=1,lwd=2,cex=0.7,col=c("black","red","blue"),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
