
source("data_processing.R")
topNumArr <- unique(ksr_data$TopNum)
predictModeArr <-unique(ksr_data$PredictMode)
testCaseArr <- unique(ksr_data$TestCase)

processInShinyR <- function(input,output,session){
  output$setid <- renderText({input$setid})
  
  # Initialize reactive values
  values <- reactiveValues()
  values$product <- productArr
  values$topNum <- topNumArr
  values$predictMode <- predictModeArr
  values$testCase <- testCaseArr
  
  # product
  observe({
    if(input$selectAllProduct > 0) {
      updateCheckboxGroupInput(session=session, inputId="product", choices=productArr, selected=productArr)
      values$product <- productArr
    }
  })
  observe({
    if(input$clearAllProduct > 0) {
      print('product')
      print(productArr)
      updateCheckboxGroupInput(session=session, inputId="product", choices=productArr, selected=NULL)
      values$product <- c()
    }
  })
  output$productControl <- renderUI({
    checkboxGroupInput('product','Products', productArr, selected = values$product)
  })    
  
  # TopNum
  observe({
    if(input$selectAllTopNum > 0) {
      updateCheckboxGroupInput(session=session, inputId="topNum", choices=topNumArr, selected=topNumArr)
      values$topNum <- topNumArr
    }
  })
  observe({
    if(input$clearAllTopNum > 0) {
      updateCheckboxGroupInput(session=session, inputId="topNum", choices=topNumArr, selected=NULL)
      values$topNum <- c()
    }
  })
  output$topNumControl <- renderUI({
    checkboxGroupInput('topNum', 'Top Num (T1-- Top1, T3-- Top3)', topNumArr, selected = values$topNum)
  })
  
  # PredictMode
  observe({
    if(input$selectAllPredictMode > 0) {
      updateCheckboxGroupInput(session=session, inputId="predictMode", choices=predictModeArr, selected=predictModeArr)
      values$predictMode <- predictModeArr
    }
  })
  observe({
    if(input$clearAllPredictMode > 0) {
      updateCheckboxGroupInput(session=session, inputId="predictMode",choices=predictModeArr, selected=NULL)
      values$predictMode <- c()
    }
  })
  output$predictModeControl <- renderUI({
    checkboxGroupInput('predictMode', 'Predict Mode (MM--MixMode, PO--PredictOnly)', predictModeArr, selected = values$predictMode)
  })
  
  # test case
  observe({
    if(input$selectAllTestCase > 0) {
      updateCheckboxGroupInput(session=session, inputId="testCase",choices=testCaseArr, selected=testCaseArr)
      values$testCase <- testCaseArr
    }
  })
  observe({
    if(input$clearAllTestCase > 0) {
      updateCheckboxGroupInput(session=session, inputId="testCase", choices=testCaseArr, selected=NULL)
      values$testCase <- c()
    }
  })
  output$testCaseControl <- renderUI({
    checkboxGroupInput('testCase', 'Test Case(Tw--Twitter, Su--Subtitle, CM--CheetachMobileTest)', testCaseArr, selected = values$testCase)
  })
  
  insureNotEmpty <- function(arr, fullArr){
    if(length(arr) != 0) arr else fullArr
  }
  
  # Render data table
  output$dTable <- renderDataTable({
    ksr_data_selected(ksr_data
                      , insureNotEmpty(input$product,productArr)
                      , insureNotEmpty(input$topNum,topNumArr) 
                      , insureNotEmpty(input$predictMode,predictModeArr) 
                      , insureNotEmpty(input$testCase,testCaseArr) 
    )
  } , options = list(iDisplayLength = 20))
  
  ksr_data_selected <- function(data, products, topNums, preditModes, testCases){
    selectedProduct <- data %>% filter(TopNum %in% topNums, PredictMode %in% preditModes, TestCase %in% testCases)
    return(selectedProduct[,c(ksrPreColumns,products)])
  }
  
  output$toPlot <- renderChart({
    datAll <- c()
    tmp <- ksr_data_selected(ksr_data
                             , insureNotEmpty(input$product,productArr)
                             , insureNotEmpty(input$topNum,topNumArr) 
                             , insureNotEmpty(input$predictMode,predictModeArr) 
                             , insureNotEmpty(input$testCase,testCaseArr) 
    )
    datAll <- parseData(tmp)
    plotData(datAll)
  })
}