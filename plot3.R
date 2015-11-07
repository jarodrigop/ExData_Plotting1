##
## plot3.R
##

# Verify that household_power_consumption.txt exists. If not, download and uncompress.
 if (file.exists("household_power_consumption.txt")==FALSE) {
    print ("The data file is not present. Download.")
    fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, destfile="./household_power_consumption.zip", method="curl")
    unzip("./household_power_consumption.zip", exdir=".")
   }

# Extract the data 
 alldata<- read.table("./household_power_consumption.txt", 
                      header     =TRUE, 
                      sep        = ";",
                      na.strings ="?",
                      colClasses = c('character','character','numeric','numeric',
                                     'numeric','numeric','numeric') 
                     )

# Create new field with data and time
 alldata$dateTime <- strptime( paste(alldata$Date, alldata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

# Extract data
 fromDate<- as.Date("2007-02-01")
 toDate  <- as.Date("2007-02-02")

# Extract the data between fromDate and toDate
 subdata <- subset(alldata, as.Date(dateTime) >= fromDate & as.Date(dateTime) <= toDate)

# Create plot
 ## Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
 png("plot3.png", width=480, height=480)

 ## Generate plot from extrated data
  plot( x    = subdata$dateTime, 
        xlab = "",       
        y    = subdata$Sub_metering_1, 
        ylab = "Energy sub metering", 
        type = "l", 
        col  = "black",
        lty  = 1
      )
  lines( x    = subdata$dateTime,
         y    = subdata$Sub_metering_2,
         col  = "red"
       )
  lines( x    = subdata$dateTime,
         y    = subdata$Sub_metering_3,
         col  = "blue"
       )
  legend("topright",
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col = c("black","red","blue"),
         lty = c(1,1,1)
        )

  dev.off()
