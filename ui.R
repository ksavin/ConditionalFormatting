library(shiny)
shinyUI(pageWithSidebar(
  
  headerPanel("Conditional Formatting"),
  
  sidebarPanel(
    tags$head(
      tags$link(rel="stylesheet", type="text/css", href="css/styles.css")
    ), 
    actionButton("btnGen", label="Generate"),
    HTML("<br><br>Highlights positive and negative values in first table, <br> 
         highlights maximum in each row in second table")
  ),
  
  mainPanel(
    htmlOutput(outputId="testTbl1"),
    htmlOutput(outputId="testTbl2")
  )
))