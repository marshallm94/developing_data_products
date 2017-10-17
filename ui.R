library(shiny)
shinyUI(
      fluidPage(
            tabsetPanel(type = "tabs",
                        tabPanel("Simple Investments",
                                 titlePanel("Simple Investments"),
                                 sidebarLayout(
                                       sidebarPanel(
                                             h3("How It Works"),
                                             p("Input the ticker symbol of a publicly traded company,
                                                and view the Balance Sheet, Income Statement
                                                and Cash Flow statement, both annually and quarterly, of
                                                said company, along with some relevant metrics."),
                                             textInput("ticker",
                                                       "Company Ticker",
                                                       value = "AAPL",
                                                       placeholder = "Enter ticker symbol here"),
                                             submitButton("Submit"),
                                             br(),
                                             h4("Last Price Traded"),
                                             textOutput("last_price"),
                                             h4("Net Current Asset Value per Share*"),
                                             textOutput("NCAVPS"),
                                             h4("Graham's Rule*"),
                                             textOutput("grahams_rule"),
                                             h4("Margin of Safety*"),
                                             textOutput("MOS"),
                                             br(),
                                             p("*See Documentation")
                                       ),
                                       mainPanel(
                                             tabsetPanel(type = "tabs",
                                                         tabPanel("Annual",
                                                                  tabsetPanel(type = "tabs",
                                                                              tabPanel("Balance Sheet",
                                                                                       br(),
                                                                                       p("All numbers expressed in Millions (USD)"),
                                                                                       tableOutput("annual_bs")
                                                                              ),
                                                                              tabPanel("Cash Flow",
                                                                                       br(),
                                                                                       p("All numbers expressed in Millions (USD)"),
                                                                                       tableOutput("annual_cf")
                                                                              ),
                                                                              tabPanel("Income Statement",
                                                                                       br(),
                                                                                       p("All numbers expressed in Millions (USD)"),
                                                                                       tableOutput("annual_is")
                                                                              )
                                                                  )
                                                         ),
                                                         tabPanel("Quarter",
                                                                  tabsetPanel(type = "tabs",
                                                                              tabPanel("Balance Sheet",
                                                                                       br(),
                                                                                       p("All numbers expressed in Millions (USD)"),
                                                                                       tableOutput("quarter_bs")
                                                                              ),
                                                                              tabPanel("Cash Flow",
                                                                                       br(),
                                                                                       p("All numbers expressed in Millions (USD)"),
                                                                                       tableOutput("quarter_cf")
                                                                              ),
                                                                              tabPanel("Income Statement",
                                                                                       br(),
                                                                                       p("All numbers expressed in Millions (USD)"),
                                                                                       tableOutput("quarter_is")
                                                                              )
                                                                  )
                                                         )
                                             )      
                                       )
                                 )   
                        ),
                        tabPanel("Documentation",
                                 br(),
                                 p("Version 1.0.0"),
                                 p("Date: 10/17/2017"),
                                 h3("Net Current Asset Value per Share"),
                                 p("In the context of this application, the Net 
                                    Current Asset Value per Share (NCAVPS) is 
                                    defined as the per share value of current assets 
                                    minus total liabilities, as stated in the 
                                    footnote on page 391 of The Intelligent Investor."),
                                 h3("Graham's Rule"),
                                 p("In The Intelligent Investor, once again on page 391,
                                    Benjamin Graham states that a diversified portfolio of
                                    stocks whose NCAVPS is greater than the current price
                                    at which their stock is trading, should produce more than
                                    satisfactory results. Graham's Rule returns Pass if the company's
                                    NCAVPS is greater than the price at which their stock
                                    is currently trading and Fail if the current price is greater than
                                    the NCAPVS."),
                                 strong("Note that the vast majority of companies will not
                                         pass this test."),
                                 h3("Margin of Safety"),
                                 p("The Margin of Safety is the percentage difference between
                                    the last price at which the stock was traded and the NCAVPS
                                    of the company."),
                                 em("If Graham's Rule is not passed, the Margin of Safety will return Invalid.")
                                 
                        )
            )
      )
)
            
                        
                  
