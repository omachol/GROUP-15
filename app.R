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
#View(trend_data)
best20_data <- read.csv("BEST25.csv")
trend_description <- read.csv("leagues.txt")
premierleague_clubs <- read.csv("premireleague_clubs.txt")
spanish_clubs <- read.csv("spanishleague_clubs.txt")
german_clubs <- read.csv("german_clubs.txt")
italian_clubs <- read.csv("italian_clubs.txt")
# Define UI for application that draws a histogram
ui <- fluidPage(theme = "bootstrap.css",
                tags$head(
                ),
                h1("FIFA 18 DATA ANALYSIS SYSTEM",
                   style = "font-family: 'Times new roman', cursive;
       font-weight: 200; line-height: 1.1; 
       color: #0000FF;
       text-align:center;
       font-weight: bold;
       border: 2px solid #660033;
       border-radius: 5px;
       font-size: 3.5em;
       border-bottom:red solid 5px;
       border-right:red solid 2px;
       border-left:red solid 2px;
       border-top:red solid 5px;
       background-color:white;
       box-shadow: 0 4px 4px 0 rgba(50, 50, 50, 0.4);
                   margin-top:-10px;"
                ),
                navbarPage("",
                           tabPanel("BEST SQUAD",style="color:#0000FF;margin-left:30px",

                        
                                    
                                    
                                    # Sidebar with a slider input for number of bins 
                                    sidebarLayout(
                                      sidebarPanel(
                                        tags$style("body{background-image:url('F1.jpg');
                                        
                                      margine-top:-30px;
                                                   }"),
                            
                                        selectInput(inputId = "league", label = strong("Select League"),
                                                    choices = c(trend_description)
                                        ),
                                        br(),
                                        
                                        
                                        conditionalPanel(condition = "input.league=='English Premier League'",
                                                         selectInput(inputId = "club", label = strong("Select Club"),
                                                                     as.character(levels(premierleague_clubs$x),selected="")
                                                         )),
                                        
                                        conditionalPanel(condition = "input.league=='spanish primera division'",
                                                         selectInput(inputId = "club", label = strong("Select Club"),
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
                           tabPanel("DATA VISUALIZATION",style="color:#0000FF",
                                    
                                    titlePanel(title=h2("FIFA 18 DISTRIBUTION BETWEEN PLAYER'S AGE, OVERALL AND POTENTIAL",style="font-family:Times new roman;color:white;align:centre")),
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
                           tabPanel("TOP 25 PLAYERS",style="color:#0000FF",
                                    
                                    titlePanel(title = h2("TO 25 BEST PLAYERS",style="font-family:Times new roman;color:white")),
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
                           
                           
                           tabPanel("PREDICTIONS",style="color:#0000FF",
                                    
                                    titlePanel(title = h2("PREDICTION ON WHICH CLUB WILL TAKE THE TROPHY",style="font-family:Times new roman;color:white")),
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
                           
                           tabPanel( 
                             "MORE INFORMATION",   # Information about data collection.
                                    a("Data are updated weekly on Thursday at 20:00 CT.",style="font-family:Times new roman;color:#F0F8FF;font-weight: bold;font-size:20px"),
                                    br(),
                                    br(),
                                    a("Please visit",style="font-family:Times new roman;color:#F0F8FF;font-weight: bold;font-size:20px"), 
                                    a("this site", href="http://wwwn.cdc.gov/nndss/document/ProvisionalNationaNotifiableDiseasesSurveillanceData20100927.pdf",style="font-family:Times new roman;color:#F0F8FF;font-weight: bold;font-size:20px"),
                                    a("for more information on how the data were collected.",style="font-family:Times new roman;color:#F0F8FF;font-weight: bold;font-size:20px"),
                                    br(),
                                    br(),
                                    a("See the code", href="https://github.com/NLMichaud/WeeklyCDCPlot",style="font-family:Times new roman;color:#F0F8FF;font-weight: bold;font-size:20px"),
                                    br(),
                                    br(),
                                    a("Any questions or comments can be sent to",style="font-family:Times new roman;color:#F0F8FF;font-weight: bold;font-size:20px"),
                                    br(),
                                    a("NSUBUGA MOSES:",style="font-family:Times new roman;color:#F0F8FF;font-weight: bold;font-size:20px") ,
                                    a("nsubugamoses93@gmail.com", href="mailto:nsubugamoses93@gmail.com",style="font-family:Times new roman;color:#F0F8FF;font-weight: bold;font-size:20px"),
                                    br(),
                                    a("OMACHOL JAMES:",style="font-family:Times new roman;color:#F0F8FF;font-weight: bold;font-size:20px"),
                                    a("jamesomachol@gmail.com", href="mailto:omacholjames@gmail.com",style="font-family:Times new roman;color:#F0F8FF;font-weight: bold;font-size:20px"),
                                    br(),
                                    a("SSEBUUFU EDDY: ",style="font-family:Times new roman;color:#F0F8FF;font-weight: bold;font-size:20px"),
                                    a("ssebuufueddyson@yahoo.com", href="ssebuufueddyson@yahoo.com",style="font-family:Times new roman;color:#F0F8FF;font-weight: bold;font-size:20px"),
                                    br(),
                                    a("KAZIBWE DAVIS: ",style="font-family:Times new roman;color:#F0F8FF;font-weight: bold;font-size:20px"),
                                    a("kazibwedavis@gmail.com", href="ssebuufueddyson@yahoo.com",style="font-family:Times new roman;color:#F0F8FF;font-weight: bold;font-size:20px")
                             )
                           
                           
                ),
                tags$style(".well{
                           background-color:lightblue;
                           height:400px;
                           }
                           .row{
                           margin-top:20px;
                           }
                           
                           ul{
                           background-color:lightblue;
                           height:auto;
                           border-radius:5px;
                           border-bottom: 5px solid red;
                           }
                           ul li{
                           background-color:lightblue;
                           border-radius:5px;
                           }"
               
                )

                            )
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

