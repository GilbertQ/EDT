##How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

##Loading the needed libraries
library(dplyr)
library(ggplot2)

##If the zip file doesn't exist it is downloaded 
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
png("plot5.png", width = 480, height = 480)
## Extracting Baltimore and emissions from vehicles information from NEI
BaltimoreM <- subset(NEI, NEI$fips=="24510" & NEI$type =="ON-ROAD")
BaltimoreVehicle <- aggregate(Emissions ~ year, BaltimoreM, sum)
## Generating the graphic
print(ggplot(BaltimoreVehicle, pch=2, aes(year,Emissions)) +
        geom_line(linetype="dashed", color="red", size=1) +
        geom_point(shape=2,fill="red",size=2) +
        ggtitle("Baltimore PM25 Motor Vehicle Emissions by Year") + 
        ylab("PM25 Motor Vehicle Emissions") +
        xlab("Year")
)
## Closing the channel to save the file 
dev.off()