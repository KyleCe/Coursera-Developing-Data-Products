# Load required libraries
require(data.table)
# library(sqldf)
library(dplyr)
library(DT)
library(rCharts)

# setwd("/data1/shiny-server/dict_lab/")

ksr_data <- fread("./data/ksr_data.csv")
print(ksr_data)
dataColnames = colnames(ksr_data)
ksrPreColumns = dataColnames[1:3]
productArr <- unique(dataColnames[4:length(dataColnames)])

parseData <- function(ksr_data){
  datAll <- c()
  print('debugging::::')
  class(ksr_data)
  print(ksr_data)
  # data <- do.call(rbind.data.frame, data)
  print(ksr_data)
  class(ksr_data)
  for(i in 1:length(productArr)){
    # if(!("d" %in% colnames(ksr_data))){
    #   next
    # }
    p <- productArr[i]
    tmpDat <- subset(ksr_data, select=c(ksrPreColumns))
    # select(ksr_data,1:3)
    print(tmpDat)
    tmpDat[,4] <- subset(ksr_data, select=c(p))
    # tmpDat <- setNames(tmpDat, c(ksrPreColumns, "KSR"))
    # colnames(tmpDat)[4] <- "KSR"
    # names(tmpDat)[1] <- "1"
    # names(tmpDat)[2] <- "2"
    # names(tmpDat)[3] <- "3"
    names(tmpDat)[4] <- "KSR"
    
    tmpDat$Product <- p
    # print(datAll)
    print(tmpDat)
    
    datAll <- rbind(datAll, tmpDat)
  }
  print(datAll)
  datAll$id <- str_c(datAll$product, datAll$TestCase,datAll$TopNum,datAll$PredictMode)
  datAll <- select(datAll, 1:3, Product, KSR, id)
  datAll <- arrange(datAll, TestCase, TopNum, PredictMode)
  return(datAll)
}


ksr_data_selected <- function(data, products, topNums, preditModes, testCases){
  selectedProduct <- data %>% filter(TopNum %in% topNums, PredictMode %in% preditModes, TestCase %in% testCases)
  return(selectedProduct[,c(ksrPreColumns,products)])
}
# 
print(ksr_data)
class(ksr_data)
new_data <- ksr_data_selected(ksr_data, c(productArr), c('T1','T3'), c('MM','PO'), c('Tw','Su','CM'))
# 
print(new_data)
class(new_data)

datAll <- c()
# sub_data <- select(new_data, 1: 5)
# print(sub_data)
# class(sub_data)
datAll <- parseData(new_data)
print(datAll)
