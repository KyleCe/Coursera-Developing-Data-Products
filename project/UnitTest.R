# Load required libraries
require(data.table)
# library(sqldf)
library(dplyr)
library(DT)
library(rCharts)

setwd('/Users/elex/AndroidStudioProjects/Coursera-Developing-Data-Products/project/')

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
datAll <- c()
datAll <- parseData(ksr_data)
print(datAll)
plotData(datAll)

plotData <- function(dt){
    toPlot <- nPlot(
      KSR ~ id,
      data = dt,
      width = 850,
      group= 'Product',
      type = "multiBarChart"
    )
    toPlot$xAxis(axisLabel = 'Randomness' , width = 80, rotateLabels = -70)
    toPlot$chart(tooltipContent = "#! function(key, x, y, e){ 
                       return '<b>Type</b>: ' + e.point.id + '<br>' + '<b>Ksr</b>: ' + e.point.KSR + '<br>'
                       + '</h5>'
  } !#")
    toPlot$chart(color = c('green', 'gold', 'grey', 'orange'))
    toPlot
}

  
  

themesByYear <- nPlot(
  KSR ~ id,
  data = datAll,
  type = "multiBarChart"#,
  # dom = dom
  , width = 650
  # , group= TestCase
)
# themesByYear$yAxis(axisLabel = 'KSR', width = 80)
themesByYear$xAxis(axisLabel = ' ', width = 70)
themesByYear$chart(tooltipContent = "#! function(key, x, y, e){ 
                   return '<b>Type</b>: ' + e.point.id + '<br>' + '<b>Ksr</b>: ' + e.point.KSR + '<br>'
                   + '</h5>'
                   } !#")
themesByYear$chart(color = c('green', 'yellow', '#594c26', 'red'))
themesByYear





print(dat[ ,c('CMK','Kika')])

testCaseRowNameArr = colnames(dat)[4:7]
parseMissed <- function(selected, array){
  
}

testCaseIndex = 0
modeIndexArr = c(2,3,4,5)
T1 = 1
T3 = 2
T1PO = 3
T3PO = 4
modeSum = 2 * 2
colnames(dat)
testCaseCursor = testCaseIndex*modeSum
testCaseRowNameArr = colnames(dat)[(testCaseCursor + modeIndexArr[T1]):(testCaseCursor + modeIndexArr[T3PO])]

greplArray <- function(target, array) {
  for (a in array) {
    if (grepl(target, a))
      return(TRUE)
  }
  return(FALSE)
}

greplArray(tn, testCaseRowNameArr)
