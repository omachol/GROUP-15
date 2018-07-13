#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(ggplot2)
trend_data <- read.csv("complete.csv")
best20_data <- read.csv("BEST25.csv")
trend_description <- read.csv("leagues.txt")
premierleague_clubs <- read.csv("premireleague_clubs.txt")
spanish_clubs <- read.csv("spanishleague_clubs.txt")
german_clubs <- read.csv("german_clubs.txt")
italian_clubs <- read.csv("italian_clubs.txt")
# Define UI for application that draws a histogram
ui <- fluidPage(theme = "bootstrap.css",
                navbarPage("FIFA 18 DATA ANALYSIS SYSTEM",
                           tabPanel("BEST SQUAD'S",
                                    
                                    # Application title
                                    titlePanel(title = h1("FIFA 18 Data Analysis System", align="center",style="font-family:Algerian"
                                    )),
                                    
                                    # Sidebar with a slider input for number of bins 
                                    sidebarLayout(
                                      sidebarPanel(
                                        tags$style("body{background-color:linen;color:blue}"),
                                        selectInput(inputId = "league", label = strong("Select League"),
                                                    choices = c(trend_description)
                                        ),
                                        br(),
                                        
                                        
                                        conditionalPanel(condition = "input.league=='English Premier League'",
                                                         selectInput(inputId = "club", label = strong("Select Clube"),
                                                                     as.character(levels(premierleague_clubs$x),selected="")
                                                         )),
                                        
                                        conditionalPanel(condition = "input.league=='spanish primera division'",
                                                         selectInput(inputId = "club", label = strong("Select Clube"),
                                                                     as.character(levels(spanish_clubs$x),selected="")
                                                         )),
                                        conditionalPanel(condition = "input.league=='German Bundesliga'",
                                                         selectInput(inputId = "club", label = strong("Select Clube"),
                                                                     as.character(levels(german_clubs$x),selected="")
                                                         )),
                                        conditionalPanel(condition = "input.league=='Italian Serie A'",
                                                         selectInput(inputId = "club", label = strong("Select Clube"),
                                                                     as.character(levels(italian_clubs$x),selected="")
                                                         )),
                                        br(),
                                        
                                        
                                        fluidRow(
                                          column(7, radioButtons("locty", "Formation to use",
                                                                 c("4-3-3" = "state",
                                                                   "3-5-2" = "region",
                                                                   "4-4-2"="stregion",
                                                                   "3-6-1"="aregion",
                                                                   "3-4-3" = "country"), selected="state")
                                          ),
                                          column(5, radioButtons("plotty", "Game Type",
                                                                 c("Deffensive" = "week",
                                                                   "Attaking" = "weekly",
                                                                   "Strong midfield" = "cumuy"), selected="week"))
                                        ),
                                        br()
                                        
                                      ),
                                      
                                      
                                      # Show a plot of the generated distribution
                                      dataTableOutput('table1')
                                    )
                           ),
                           tabPanel("DATA VISUALIZATION",
                                    
                                    titlePanel(title=h2("FIFA 18 DISTRIBUTION BETWEEN PLAYER'S AGE, OVERALL AND POTENTIAL",style="font-family:Algerian")),
                                    sidebarLayout(
                                      sidebarPanel(
                                        radioButtons("pType", "CHOOSE DISTRIBUTION BETWEEN",
                                                     c(" Age and Overall " = "A",
                                                       " Age and Potential" = "B",
                                                       "Histogram for players Age" = "C",
                                                       "Histogram for players Overall Rating"="D",
                                                       "Histogram for players Potential"="E",
                                                       "Scatter plot of Age and Overall rating" = "P"
                                                     ))
                                        
                                      ),
                                      
                                      # Show a plot of the generated distribution
                                      mainPanel(
                                        plotOutput('plot')
                                      )
                                    )
                           ),
                           tabPanel("TOP 25",
                                    
                                    titlePanel(title = h2("TO 25 BEST PLAYERS",style="font-family:Algerian",align="center")),
                                    ## Only run this example in interactive R sessions
                                    if (interactive()) {
                                      # table example
                                      shinyApp(
                                        ui = fluidPage(
                                          fluidRow(
                                            column(12,
                                                   tableOutput('table')
                                            )
                                          )
                                        ),
                                        server = function(input, output) {
                                          output$table <- renderTable(best20_data )
                                        }
                                      )
                                      
                                      
                                      # DataTables example
                                      shinyApp(
                                        ui = fluidPage(
                                          fluidRow(
                                            column(12,
                                                   dataTableOutput('table')
                                            )
                                          )
                                        ),
                                        server = function(input, output) {
                                          output$table <- renderDataTable(best20_data )
                                        }
                                      )
                                    }
                                    
                           ),
                           
                           
                           tabPanel("PREDICTIONS",
                                    
                                    titlePanel(title = h2("PREDICTION ON WHICH CLUB WILL TAKE THE TROPHY",style="font-family:Algerian",align="center")),
                                    sidebarLayout(
                                      sidebarPanel(
                                        selectInput(inputId = "lea", label = strong("Select League"),
                                                    choices = c(trend_description)
                                        ),
                                        radioButtons("plots", "WHICH ",
                                                     c("WIN LEAGUE" = "ity",
                                                       "BEST TEAM IN THAT LEAGUE" = "egionP",
                                                       "TAKE THE GOLDEN BOOT" = "tateP",
                                                       "TAKE THE GOLDEN GLOVES"="tregion"
                                                     ))
                                        
                                      ),
                                      
                                      # Show a plot of the generated distribution
                                      mainPanel(
                                        plotOutput("istPlot")
                                      )
                                    )
                           ),
                           
                           tabPanel("More Information",   # Information about data collection.
                                    "Data are updated weekly on Thursday at 20:00 CT.",
                                    br(),
                                    br(),
                                    "Please visit", 
                                    a("this site", href="http://wwwn.cdc.gov/nndss/document/ProvisionalNationaNotifiableDiseasesSurveillanceData20100927.pdf"),
                                    "for more information on how the data were collected.  All data are provisional.",
                                    br(),
                                    br(),
                                    a("See the code", href="https://github.com/NLMichaud/WeeklyCDCPlot"),
                                    br(),
                                    br(),
                                    "Any questions or comments can be sent to",
                                    br(),
                                    "NSUBUGA MOSES: " ,
                                    a("nsubugamoses93@gmail.com", href="mailto:nsubugamoses93@gmail.com"),
                                    br(),
                                    "OMACHOL JAMES: ",
                                    a("omacholjames@gmail.com", href="mailto:omacholjames@gmail.com"),
                                    br(),
                                    "SSEBUUFU EDDY: ",
                                    a("ssebuufueddyson@yahoo.com", href="ssebuufueddyson@yahoo.com")
                           )
                           
                           
                ))
# Define server logic required to draw a histogram

server <- function(input, output) {
  
  
  myData <- trend_data
  plotType <- function(x, type) {
    switch(type,
           A = boxplot(age~overall, data=trend_data ,col=(c("magenta","green")),
                       main="Player Age and Overall rating", xlab="Overall rating",ylab="player's age"),
           B = boxplot(age~potential, data=trend_data,col=(c("magenta","green")),
                       main="Player Age and Potential", xlab="Player Potential", ylab="player's age"),
           C = hist(trend_data$age, main="Histogram for players Age", xlab="Age",  border="blue", 
                    col="green",las=1, breaks=40),
           D = hist(trend_data$overall, main="Histogram for players Overall Rating",  xlab="Overall rating", 
                    border="blue", col="magenta", las=1, breaks=20),
           E = hist(trend_data$potential,  main="Histogram for players Potential",  xlab="Potential", 
                    border="black", col="red", las=1,  breaks=20),
           P = scatterplot(age ~ overall, data=trend_data, xlab="Overall Rating", ylab="Age", 
                           main="Scatter plot of Age and Overall rating", labels=row.names(trend_data))
    )
  }
  output$plot <- renderPlot({ 
    plotType(myData, input$pType)
  })
  output$table1 <-renderTable({
    
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

