# setwd("./Desktop/Online Coursera/Coursera-Developing-Data-Products/project/")

# Load required libraries
require(data.table)
# library(sqldf)
library(dplyr)
library(DT)
library(rCharts)

# Read data
ksr_data <- fread("./data/ksr_data.csv")
dataColnames = colnames(ksr_data)
ksrPreColumns = dataColnames[1:3]
productArr <- sort(unique(dataColnames[4:length(dataColnames)]))

parseData <- function(ksr_data){
    dataColnames = colnames(ksr_data)
    ksrPreColumns = dataColnames[1:3]
    productArr <- sort(unique(dataColnames[4:length(dataColnames)]))
    datAll <- c()
    for( p in productArr){
      tmpDat <- select(ksr_data, ksrPreColumns, p, KSR=p)
      tmpDat$Product = p
      datAll <- rbind(datAll, tmpDat)
    }
    datAll$id <- str_c(datAll$product, datAll$TestCase,datAll$TopNum,datAll$PredictMode)
    datAll <- select(datAll, ksrPreColumns, Product, KSR, id)
    datAll <- arrange(datAll, TestCase, TopNum, PredictMode)
    return(datAll)
}

plotData <- function(dt, dom = "toPlot", 
                     xAxisLabel = "Year",
                     yAxisLabel = "Number of Themes"){
      toPlot <- nPlot(
        KSR ~ id,
        data = dt,
        width = 850,
        group= 'Product',
        dom = dom,
        type = "multiBarChart"
      )
      toPlot$yAxis(axisLabel = yAxisLabel, width = 80)
      toPlot$xAxis(axisLabel = xAxisLabel, width = 80, rotateLabels = -70)
      toPlot$chart(tooltipContent = "#! function(key, x, y, e){ 
                   return '<b>Type</b>: ' + e.point.id + '<br>' + '<b>Ksr</b>: ' + e.point.KSR + '<br>'
                   + '</h5>'
    } !#")
      toPlot$chart(color = c('green', 'gold', 'grey', 'orange'))
      toPlot
}
