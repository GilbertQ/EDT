##Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
##which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
##Which have seen increases in emissions from 1999–2008? 
##Use the ggplot2 plotting system to make a plot answer this question.

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
png("plot3.png", width = 480, height = 480)
## Extracting Baltimore information from NEI
Baltimore <- subset(NEI, NEI$fips=="24510")
## Extracting the information from NEI for Baltimore by Type
BaltimorebyType <- aggregate(Emissions ~ year + type, Baltimore, sum)
## Generating the graphic
print(ggplot(BaltimorebyType, pch=2, aes(year,Emissions, col = type)) +
  geom_line(linetype="dashed",size=1) +
  geom_point(shape=2,fill="red",size=2) +
  ggtitle("Total Baltimore PM25 Emissions by Year") + 
  ylab("Total Baltimore PM25 Emissions by Year") +
  xlab("Year") +
  scale_colour_discrete(name = "Sources") 
)
## Closing the channel to save the file 
dev.off()