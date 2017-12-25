
# Load required libraries
require(data.table)
# library(sqldf)
library(dplyr)
library(DT)
library(rCharts)

print(datAll)

themesByYear <- nPlot(
  KSR ~ id,
  data = datAll,
  width = 1050,
  group= 'Product',
  type = "multiBarChart"
)
# themesByYear$yAxis(axisLabel = 'KSR', width = 80)
themesByYear$xAxis(axisLabel = 'Randomness' , width = 80, rotateLabels = -70)
themesByYear$chart(tooltipContent = "#! function(key, x, y, e){ 
                   return '<b>Type</b>: ' + e.point.id + '<br>' + '<b>Ksr</b>: ' + e.point.KSR + '<br>'
                   + '</h5>'
                   } !#")
themesByYear$chart(color = c('green', 'gold', 'grey', 'orange'))
themesByYear


plotKSRByModeAndTestCase <- function(dt, dom = "themesByYear", 
                                     xAxisLabel = "Year",
                                     yAxisLabel = "Number of Themes") {
  themesByYear <- nPlot(
    count ~ year,
    data = dt,
    type = "multiBarChart",
    dom = dom, width = 650
  )
  themesByYear$chart(margin = list(left = 100))
  themesByYear$yAxis(axisLabel = yAxisLabel, width = 80)
  themesByYear$xAxis(axisLabel = xAxisLabel, width = 70)
  themesByYear$chart(tooltipContent = "#! function(key, x, y, e){ 
                     return '<h5><b>Year</b>: ' + e.point.year + '<br>' + '<b>Total Themes</b>: ' + e.point.count + '<br>'
                     + '</h5>'
} !#")
  themesByYear
  }