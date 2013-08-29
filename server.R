library(shiny)
shinyServer(function(input, output, session) {

  # generates test data frames
  testdf1 <- reactive({if (input$btnGen!=0) 
                        data.frame(year = 2000:2013, value = runif(14,-1,1))
                     })
  testdf2 <- reactive({if (input$btnGen!=0)
                        data.frame(var1 = runif(14, -10, 10), var2 = runif(14, 0, 5), var3 = runif(14,3,5) )
                     })
#sets background of cells with negative values to red, positive - to green in first table 
  output$testTbl1 <- renderText({
    if (!is.null(testdf1()))
        HTML(df2html(testdf1(), class = "tbl", id = "testTbl1", 
                     cellClass = cbind(rep(NA, nrow(testdf1())), ifelse(testdf1()[,2]>=0, 'cellGreen', 'cellRed'))
                     )
             )
    })
#highlights highest value in each row in second table
  output$testTbl2 <- renderText({
    if (!is.null(testdf2()))
      HTML(df2html(testdf2(), class = "tbl", id = "testTbl2",
                   cellClass = ifelse(t(apply(testdf2(), 1, function(x) x==max(x))), 'cellGreen', NA)
                  )
           )
  })
})

#generates html table tags from data frame, id is mandatory for binding
# cellClass - a matrix of the same size as df with strings representing CSS class for each cell. 
# Use NA to leave default cell format
df2html <- function(df, class = NULL, id = NULL, cellClass = NULL){
  if (is.null(cellClass))
    cellClass = matrix(NA, nrow(df), ncol(df))
  out <- paste0("<table ", 
                ifelse(is.null(class), "", paste0(" class = \"",class, "\"")),
                ifelse(is.null(id), "", paste0(" id = \"", id, '\"')),
                ">", "<tr>")
  for (i in 1:length(names(df)))
    out <- paste0(out, "<th scope = \"col\">", names(df)[i], "</th>")
  for (i in 1: nrow(df)){
    out <- paste0(out, "<tr>")
    for (j in 1:ncol(df))
      out <- paste0(out,"<td", 
                    ifelse(is.na(cellClass[i,j]), '', paste0(" class = \"", cellClass[i,j], "\"")),
                    '>', df[i, j],"</td>")
    out <- paste0(out, "</tr>")
  }
  return(paste0(out, "</table>"))
}