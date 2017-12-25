library(shiny)

# Load data processing file
source("competitor_analyze.R")

# Shiny server
shinyServer(
  function(input, output, session) {
    processInShinyR(input, output, session)
 
  } # end of function(input, output)
  
)