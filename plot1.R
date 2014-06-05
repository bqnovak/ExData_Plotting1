plot1 <- function(){
	require(sqldf)

	f <- file("household_power_consumption.txt")
	hpc <- sqldf("select * from f where Date IN ('1/2/2007','2/2/2007')", dbname = tempfile(), file.format = list(header = T, row.names = F, sep=";"))
	close(f)

	hpc$DateAndTime <- with(hpc, strptime(paste(Date,Time),format ="%d/%m/%Y %H:%M:%S"))

	png(filename = "plot1.png", width = 480, height = 480, units = "px")
	with(hpc, hist(Global_active_power, cex.axis=0.9, cex.lab=0.9, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power"))

	dev.off()
	message("File plot1.png is created successfully in your working directory")
}