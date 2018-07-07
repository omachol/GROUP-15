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
   titlePanel("FIFA 18 Data Analysis System"),
   
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
      plotOutput('plot1')
   )
                           ),
                 tabPanel("DATA VISUALIZATION",
            
                  titlePanel("FIFA 18 VISUALISATION"),
                  sidebarLayout(
                    sidebarPanel(
                      radioButtons("plot", "CHOOSE DISTRIBUTION BETWEEN ",
                                   c("Player Age and Overall rating" = "cit",
                                     "Player Age and Potential" = "region",
                                     "Histogram for players Age" = "state",
                                     "Histogram for players Overall Rating"="ctregio",
                                     "Histogram for players Potential"="aregion",
                                     "Scatter plot of Age and Overall rating" = "total"))
                      
                    ),
                    
                    # Show a plot of the generated distribution
                    mainPanel(
                      plotOutput("dist1")
                    )
                  )
                 ),
   
              
   
                           tabPanel("PREDICTIONS",
            
                                titlePanel("PREDICTION ON WHICH CLUB WILL TAKE THE TROPHY"),
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
   
  
  output$dist1 <- renderUI({     
    if(is.null(input$plot))return()
    switch(input$plot,
           "city" =     return(),
           "regionP" =  return( ),
           "ctregion" =  return(),
           "stateP" =  return(),
           "aregion" = return()
    )
  })
   
}

# Run the application 
shinyApp(ui = ui, server = server)

