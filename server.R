library(shiny)
shinyServer(function(input, output) {
      library(quantmod)
      
      #Reactive Statements
      adj_ticker <- reactive({
            ticker <- input$ticker
      })
      adjust_financial <- reactive({
            adj_ticker <- getFin(adj_ticker())
            financial <- get(adj_ticker)
      })
      NCAVPS <- reactive({
            balance_sheet <-as.data.frame(viewFinancials(adjust_financial(),
                                                         type = "BS",
                                                         period = "Q"))
            NCAVPS <- (balance_sheet[10,1] - balance_sheet[31,1])/balance_sheet[42,1]
            NCAVPS
      })
      
      #Ouputs
      output$last_price <- renderText({
            paste("$",
                  round(getQuote(adj_ticker())$Last, 2),
                  sep = " ")
      })
      output$NCAVPS <- renderText({
            paste("$", round(NCAVPS(), digits = 2), sep = " ")
      })
      output$grahams_rule <- renderText({
            if(NCAVPS() > getQuote(adj_ticker())$Last) {
                  print("Pass")
            } else {
                  print("Fail")
            }
      })
      output$MOS <- renderText({
            if( (getQuote(adj_ticker())$Last/NCAVPS()) < 0) {
                  print("Invalid")
            } else {
                  paste(
                        round(
                              (1 - (getQuote(adj_ticker())$Last/NCAVPS()))*100,
                              digits = 2),
                        "%",
                        sep = ""
                  )      
                        
            }
      })
      output$annual_bs <- renderTable({
            cbind(
                  rownames(
                        as.data.frame(
                              viewFinancials(adjust_financial(), type = "BS", period = "A")
                        )
                  ),
                  viewFinancials(adjust_financial(), type = "BS", period = "A")
            )
      })
      output$annual_cf <- renderTable({
            cbind(
                  rownames(
                        as.data.frame(
                              viewFinancials(adjust_financial(), type = "CF", period = "A")
                        )
                  ),
                  viewFinancials(adjust_financial(), type = "CF", period = "A")
            )      
      })
      output$annual_is <- renderTable({
            cbind(
                  rownames(
                        as.data.frame(
                              viewFinancials(adjust_financial(), type = "IS", period = "A")
                        )
                  ),
                  viewFinancials(adjust_financial(), type = "IS", period = "A")
            )      
                  
      })
      output$quarter_bs <- renderTable({
            cbind(
                  rownames(
                        as.data.frame(
                              viewFinancials(adjust_financial(), type = "BS", period = "Q")
                        )
                  ),
                  viewFinancials(adjust_financial(), type = "BS", period = "Q")
            )      
      })
      output$quarter_cf <- renderTable({
            cbind(
                  rownames(
                        as.data.frame(
                              viewFinancials(adjust_financial(), type = "CF", period = "Q")
                        )
                  ),
                  viewFinancials(adjust_financial(), type = "CF", period = "Q")
            )      
      })
      output$quarter_is <- renderTable({
            cbind(
                  rownames(
                        as.data.frame(
                              viewFinancials(adjust_financial(), type = "IS", period = "Q")
                        )
                  ),
                  viewFinancials(adjust_financial(), type = "IS", period = "Q")
            )      
      })
})
            
        


