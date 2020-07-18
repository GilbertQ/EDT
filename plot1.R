##Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
##Using the base plotting system, make a plot showing the total PM2.5 emission from all 
##sources for each of the years 1999, 2002, 2005, and 2008.

##Loading the needed libraries
library(dplyr)

##If the zip file doesn't exist it's downloaded
filename <- "exdata_data_NEI_data.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileURL,filename)
}

##If one of the rds doesn't exist the zip file is uncompressed
if (!file.exists("Source_Classification_Code.rds") | !file.exists("summarySCC_PM25.rds")){
  unzip(filename)
}

##Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Opening the channel to save the image 
png("plot1.png", width = 480, height = 480)
## Extracting the information from NEI
Totals <- aggregate(Emissions ~ year, NEI, sum)
## Generating the graphic
plot(Totals$year,Totals$Emissions,type="o",pch=2,col="red",
     main="Total US PM25 Emissions by Year", 
     ylab="Total US PM25 Emissions by Year", xlab="Year")
## Closing the channel to save the file 
dev.off()
