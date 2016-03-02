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
#section 2:creates plot2
dev.copy(png,file="plot2.png")
with(tidypower,plot(datetime,Global_active_power,type="l",ylab="Global Active Power(kilowatts)", xlab=""))
dev.off()

