# The user-interface definition of the Shiny web app.
library(shiny)
library(BH)
library(rCharts)
require(markdown)
require(data.table)
library(dplyr)
library(DT)
library(shinydashboard)
library(timeDate)
library(ggvis)
library(stringr)


# this is for ui and
dashboardPage(
  dashboardHeader(title = "Dict"),
  dashboardSidebar(sidebarMenu(
    menuItem("Competitor Analyze(Dev)", tabName = "competitor_analyze", icon = icon("line-chart")),
    hr())),
  dashboardBody(
    tags$style(HTML("
                    .box.box-solid.box-primary>.box-header {
                    color:#fff;
                    background:#666666
                    }
                    .box.box-solid.box-primary{
                    border-bottom-color:#666666;
                    border-left-color:#666666;
                    border-right-color:#666666;
                    border-top-color:#666666;
                    border-center-color:#666666;
                    }")),
    tabItems(
      tabItem(tabName = "competitor_analyze" 
              , fluidPage(
                tabPanel("Aspects to inspect",
                                  sidebarPanel(
                                    h4('Aspects to inspect', align = "center"),
                                    box(width = 12, status = "primary", solidHeader = TRUE, uiOutput("productControl") 
                                        ,actionButton(inputId = "selectAllProduct",label = "Select all",icon = icon("check-square-o"))
                                        ,actionButton(inputId = "clearAllProduct",label = "Clear selection",icon = icon("square-o"))
                                     ),
                                    box(width = 12, status = "primary", solidHeader = TRUE, uiOutput("topNumControl")
                                        ,actionButton(inputId = "selectAllTopNum",label = "Select all",icon = icon("check-square-o"))
                                        ,actionButton(inputId = "clearAllTopNum",label = "Clear selection",icon = icon("square-o"))
                                    ),
                                    box(width = 12, status = "primary", solidHeader = TRUE, uiOutput("predictModeControl")
                                        ,actionButton(inputId = "selectAllPredictMode",label = "Select all",icon = icon("check-square-o"))
                                        ,actionButton(inputId = "clearAllPredictMode",label = "Clear selection",icon = icon("square-o"))
                                    ),
                                    box(width = 12, status = "primary", solidHeader = TRUE, uiOutput("testCaseControl")
                                        ,actionButton(inputId = "selectAllTestCase",label = "Select all",icon = icon("check-square-o"))
                                        ,actionButton(inputId = "clearAllTestCase",label = "Clear selection",icon = icon("square-o"))
                                    ),
                                    h4('CMCM presents', align = "center")
                         ),
                                  mainPanel(
                                      tabsetPanel(
                                        tabPanel(p(icon("table"), "Dataset"), dataTableOutput(outputId="dTable")
                                        ), 
                                        tabPanel(p(icon("line-chart"), "Visualize the Data"),
                                                 h3('Ksr ratio by the mode you choose to Inspect', align = "center"),
                                                 h5(HTML(paste("Illustration::", "TopNum : T1-- Top1  T3-- Top3"
                                                               ,"PredictMode : MM-- MixMode  PO-- PredictOnly"
                                                               , "TestCase: Tw-- Twitter Su-- Subtitle CM-- CM test"
                                                               , sep="<br/>")), align = "center"),
                                                 showOutput("toPlot", "nvd3")
                                        ) # end of "Visualize the Data" tab panel
                                      )
                                 )
                             ) # end of "Explore Dataset" tab panel
              )
      )
    ),
    singleton(
      tags$head(tags$script('Shiny.addCustomMessageHandler("testmessage",
                            function(message) {
                            alert(message);
                            }
      );'))
    )
      )
      )
