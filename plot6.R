##Compare emissions from motor vehicle sources in Baltimore City with emissions 
##from motor vehicle sources in Los Angeles County, California (fips == "06037").
##Which city has seen greater changes over time in motor vehicle emissions?

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
png("plot6.png", width = 480, height = 480)
## Extracting Baltimore and Los Angeles emissions from vehicles information from NEI
LAvsBalt_motors <- subset(NEI, NEI$fips %in% c("24510","06037") & NEI$type =="ON-ROAD")
LAvsBalt <- aggregate(Emissions ~ year + fips, LAvsBalt_motors, sum)
## Generating the graphic
print(ggplot(LAvsBalt, aes(year,Emissions,col=fips)) +
        geom_line(linetype="dashed", size=1) +
        geom_point(shape=2,fill="red",size=2) +
        ggtitle("PM25 Motor Vehicle Emissions by Year -Baltimore vs Los Angeles-") + 
        ylab("PM25 Motor Vehicle Emissions") +
        xlab("Year") +
        scale_colour_discrete(name="City", labels=c("Los Angeles", "Baltimore"))
)
## Closing the channel to save the file 
dev.off()