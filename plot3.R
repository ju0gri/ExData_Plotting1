path <- getwd()
zip_file <- "household_power_consumption.zip"
data_file <- "household_power_consumption.txt"
download_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"


if (!file.exists(file.path(path, data_file))) {
  download.file(download_url, zip_file, "curl")
  unzip(zipfile=file.path(path, zip_file))
}

household_data <- read.table(data_file, header=TRUE, sep=";", na.strings="?")

feb_household_data <- household_data[household_data$Date %in% c("1/2/2007","2/2/2007"),]

StrTime <-strptime(paste(feb_household_data$Date, feb_household_data$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
feb_household_data <- cbind(StrTime, feb_household_data)

png("plot3.png", width=480, height=480)
plot(feb_household_data$StrTime, feb_household_data$Sub_metering_1, type="l", col="black", ylab="Energy sub metering", xlab="")

lines(feb_household_data$StrTime, feb_household_data$Sub_metering_2, col="red")
lines(feb_household_data$StrTime, feb_household_data$Sub_metering_3, col="blue")

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty="solid")

dev.off()