plot2 <- function(){
	require(sqldf)

	f <- file("household_power_consumption.txt")
	hpc <- sqldf("select * from f where Date IN ('1/2/2007','2/2/2007')", dbname = tempfile(), file.format = list(header = T, row.names = F, sep=";"))
	close(f)

	hpc$DateAndTime <- with(hpc, strptime(paste(Date,Time),format ="%d/%m/%Y %H:%M:%S"))

	png(filename = "plot2.png", width = 480, height = 480, units = "px")
	with(hpc, plot(DateAndTime, Global_active_power, type = "l", cex.axis=0.9, cex.lab=0.9, ylab = "Global Active Power (kilowatts)", xlab = ""))

	dev.off()
	message("File plot2.png is created successfully in your working directory")
}