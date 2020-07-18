##Across the United States, how have emissions from coal combustion-related sources changed 
##from 1999–2008?

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
png("plot4.png", width = 480, height = 480)
## Extracting data for emissions from coal combustion-related sources
Coals <- SCC[grepl("coal",SCC$Short.Name, ignore.case = TRUE),]
Coal_NEI <- NEI[NEI$SCC %in% Coals$SCC,]
Total <- aggregate(Emissions ~ year + type, Coal_NEI, sum)

## Generating the graphic
print(ggplot(Total, pch=2, aes(year,Emissions, col = type)) +
        geom_line(linetype="dashed",size=1) +
        geom_point(shape=2,fill="red",size=2) +
        ggtitle("Total US PM25 Coal Emissions by Type and Year") + 
        ylab("US PM25 Coal Emissions") +
        xlab("Year") +
        scale_colour_discrete(name = "Sources") 
)
## Closing the channel to save the file 
dev.off()