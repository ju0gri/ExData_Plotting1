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

png("plot1.png", width=480, height=480)

hist(feb_household_data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")

dev.off()