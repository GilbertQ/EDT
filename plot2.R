## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
## from 1999 to 2008? Use the base plotting system to make a plot answering this question.
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
png("plot2.png", width = 480, height = 480)
## Extracting Baltimore information from NEI
Baltimore <- subset(NEI, NEI$fips=="24510")
## Extracting the information from NEI for Baltimore
TotalB <- aggregate(Emissions ~ year, Baltimore, sum)
## Generating the graphic
plot(TotalB$year,TotalB$Emissions,type="o",pch=2,col="red",
     main="Total Baltimore PM25 Emissions by Year", 
     ylab="Total Baltimore PM25 Emissions by Year", xlab="Year")
## Closing the channel to save the file 
dev.off()