plot4 <- function(){

	## reading data from file in working directory using sql language
	require(sqldf)
	f <- file("household_power_consumption.txt")
	hpc <- sqldf("select * from f where Date IN ('1/2/2007','2/2/2007')", dbname = tempfile(), file.format = list(header = T, row.names = F, sep=";"))
	close(f)

	## adding new formated and concatenated field date and time
	hpc$DateAndTime <- with(hpc, strptime(paste(Date,Time),format ="%d/%m/%Y %H:%M:%S"))

	## setting graphics device to png
	png(filename = "plot4.png", width = 480, height = 480, units = "px")

	## setting graphics parameters: 2 rows and 2 colums
	par(mfrow = c(2,2))

	## plotting
	with(hpc, {
		plot(DateAndTime, Global_active_power, type="l", col="black", axes=T, ann=T, xlab="", ylab="Global Active Power", cex.axis=0.9, cex.lab=0.9, lwd=1)
		plot(DateAndTime, Voltage, type="l", col="black", axes=T, ann=T, xlab="datetime", ylab="Voltage", cex.axis=0.9, cex.lab=0.9, lwd=1)
		plot(DateAndTime, Sub_metering_1, type="l", col="black", axes=T, ann=T, xlab="", ylab="Energy sub metering", cex.axis=0.9, cex.lab=0.9, lwd=1)
			lines(DateAndTime, Sub_metering_2, type="l", lwd=1, col = "red")
			lines(DateAndTime, Sub_metering_3, type="l", lwd=1, col = "blue")
			legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex=0.9, col=c("black","red","blue"), lwd=1, bty="n")
		plot(DateAndTime, Global_reactive_power, type="l", col="black", axes=T, ann=T, xlab="datetime", ylab="Global_reactive_power", cex.axis=0.9, cex.lab=0.9, lwd=1)
	})

	## closing graphics device connection
	dev.off()
	message("File plot4.png is created successfully in your working directory")
}