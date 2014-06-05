plot3 <- function(){
	require(sqldf)

	f <- file("household_power_consumption.txt")
	hpc <- sqldf("select * from f where Date IN ('1/2/2007','2/2/2007')", dbname = tempfile(), file.format = list(header = T, row.names = F, sep=";"))
	close(f)

	hpc$DateAndTime <- with(hpc, strptime(paste(Date,Time),format ="%d/%m/%Y %H:%M:%S"))

	png(filename = "plot3.png", width = 480, height = 480, units = "px")

	with(hpc, {
		plot(DateAndTime, Sub_metering_1, type="l", col="black", ylim=range(hpc$Sub_metering_1), axes=T, ann=T, xlab="", ylab="Energy sub metering", cex.axis=0.9, cex.lab=0.9, lwd=1)
			lines(DateAndTime, Sub_metering_2, type="l", lwd=1, col = "red")
			lines(DateAndTime, Sub_metering_3, type="l", lwd=1, col = "blue")
	})

	legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex=0.9, col=c("black","red","blue"), lwd=1)

	dev.off()
	message("File plot3.png is created successfully in your working directory")
}