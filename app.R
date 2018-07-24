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
library (DT)
library(car)
trend_data <- read.csv("complete.csv")
#View(trend_data)
arsenal <- read.csv("arsenal1.csv")
bournemouth <- read.csv("bournemouth.csv")
spaish_c<- read.csv("spain2.csv")
bright <- read.csv("bright.csv")
chelsea <- read.csv("chelsea.csv")
group1 <- read.csv("group_1.csv")
group2 <- read.csv("group_2.csv")
best_club <- read.csv("best_club.csv")
group3 <- read.csv("group_3.csv")
group4 <- read.csv("group_4.csv")
burn <- read.csv("burnley.csv")
cry <- read.csv("CRY.csv")
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
                                                       "Scatter plot of Age and Overall rating" = "P",
                                                       "Histogram for players weight"="z",
                                                       "Histogram for players height"="k",
                                                       "gg plot on players overall rating" = "w",
                                                       "ggplot on Players Height" = "t",
                                                       "ggplot on Players Overall and potential" = "m",
                                                       "Variations with Age" = "S"
                                                     ))
                                        
                                      ),
                                      
                                      # Show a plot of the generated distribution
                                      mainPanel(
                                        plotOutput('plot')
                                      )
                                    )
                           ),tabPanel("TOP 25 PLAYERS",style="color:#0000FF",
                                      
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
                                        
                                        br()
                                        
                                        ),
                                      
                                      mainPanel(
                                        tableOutput("table1"),style="background-color:lightblue;,color:Orange"
                                      )
                                    )
                ), tabPanel("Best Players",style="color:#0000FF",
                            
                            
                            sidebarLayout(
                              sidebarPanel(
                                h1("Some Describtion"),
                                h4("As it was verified that in Group 1 there are players with higher ratings,
                                   it can be verified that in this group are the star players.
                                   The other groups, despite having players with worse ratings, have World class players.")
                                
                                ),
                              
                              # Show a plot of the generated distribution
                              mainPanel(
                                tabsetPanel( type = "tab",
                                             tabPanel("Group 1",
                                                      tableOutput("table2"),style="background-color:#FAEBD7;,color:Orange"
                                             ),
                                             tabPanel("Group 2",
                                                      tableOutput("table3"),style="background-color:#FAEBD7;,color:Orange"
                                             ),
                                             tabPanel("Group 3",
                                                      tableOutput("table4"),style="background-color:#FAEBD7;,color:Orange"
                                             ),
                                             tabPanel("Group 4",
                                                      tableOutput("table5"),style="background-color:#FAEBD7;,color:Orange"
                                             ),
                                             tabPanel("Best Club",
                                                      tableOutput("table6"),style="background-color:#FAEBD7;,color:Orange"
                                             )
                                             
                                )
                              )
                              )
                            ),
                
                
                
                tabPanel("PLAYER VALUE'S",style="color:#0000FF",
                         
                         
                         sidebarLayout(
                           sidebarPanel(
                             
                             h1("Some Describtion"),
                             h4("You can see that Group 1 has the most expensive players, followed by Group 3, 
                                then Group 4 and the Group 2 has the least valued players.")
                             ),
                           
                           # Show a plot of the generated distribution
                           mainPanel(
                             tabsetPanel( type = "tab",
                                          tabPanel("Group 1",
                                                   plotOutput('plot5')
                                          ),
                                          tabPanel("Group 2",
                                                   plotOutput('plot6')
                                          ),
                                          tabPanel("Group 3",
                                                   plotOutput('plot7')
                                          ),
                                          tabPanel("Group 4",
                                                   plotOutput('plot8')
                                          )
                                          
                             )
                           )
                           )
                ),
                tabPanel("GGPLOTS",style="color:#0000FF",
                         
                         sidebarLayout(
                           sidebarPanel(
                             h1("Some Describtion"),
                             h4("From the plot's  , we realize that group 1 has the players with the 
                                highest overall, followed by Group 3, then Group 4 
                                and in Group 2 are the worst players.")
                             
                             ),
                           
                           # Show a plot of the generated distribution
                           mainPanel(
                             tabsetPanel( type = "tab",
                                          tabPanel("Group 1",
                                                   plotOutput('plot1')
                                          ),
                                          tabPanel("Group 2",
                                                   plotOutput('plot2')
                                          ),
                                          tabPanel("Group 3",
                                                   plotOutput('plot3')
                                          ),
                                          tabPanel("Group 4",
                                                   plotOutput('plot4')
                                          )
                                          
                             )
                           )
                           )
                         ),
                tabPanel("PREDICTIONS",style="color:#0000FF",
                         
                         titlePanel(title = h4("WE ARE GOING TO PREDICT THE OVERALL OF A PLAYER BASED ON THE PLAYER'S ATTRIBUTES
                                               ",style="font-family:Times new roman;color:white;")),
                         sidebarLayout(
                           sidebarPanel(
                             
                             
                           ),
                           
                           # Show a plot of the generated distribution
                           mainPanel(
                             tabsetPanel( type = "tab",
                                          tabPanel("Liner regression",
                                                   plotOutput('plot9')
                                          ),
                                          tabPanel("Group 2",
                                                   tableOutput("table11")
                                          ),
                                          tabPanel("table"
                                                   
                                          ),
                                          tabPanel("testing"
                                                   
                                          )
                                          
                             )
                           )
                         )
                         ),
                
                
                
                tabPanel( 
                  "MORE INFORMATION",   # Information about data collection.
                  h1(a("Data are updated weekly on Thursday at 20:00 CT.",style="font-family:Times new roman;color:#F0F8FF;font-weight: bold;font-size:20px"),
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
                     a("kazibwedavis@gmail.com", href="ssebuufueddyson@yahoo.com",style="font-family:Times new roman;color:#F0F8FF;font-weight: bold;font-size:20px"),
                     style = "font-family: 'Times new roman', cursive;color: #0000FF;")
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
                           main="Scatter plot of Age and Overall rating", label=row.names(trend_data)),
           z = hist(trend_data$weight_kg,  main="Histogram for players weight",  xlab="players weight", 
                    border="black", col="Orange", las=1,  breaks=20),
           k =  hist(trend_data$height_cm,  main="Histogram for players height",  xlab="players height", 
                     border="black", col="Violet", las=1,  breaks=20),
           w = ggplot(trend_data,aes(x = overall, fill = factor(overall))) +
             geom_bar(color = "grey20") + guides(fill = FALSE)+labs(title="Player's Overall "),
           t  =  ggplot(trend_data,aes(x = height_cm, fill = factor(height_cm))) +
             geom_bar(color = "grey20") + guides(fill = FALSE)+
             labs(title="Players Height"),
           m = ggplot(trend_data,aes(overall, potential)) +
             geom_point( size = 2, alpha = .9) + geom_jitter() + 
             theme( panel.grid.major = element_blank(),
                    panel.grid.minor = element_blank(),
                    panel.background = element_blank(), 
                    axis.line = element_line(colour = "black")),
           S = ggplot(trend_data) +
             geom_tile(aes(overall, potential, fill = age)) + 
             scale_fill_distiller(palette = "Spectral") + 
             theme( panel.grid.major = element_blank(),
                    panel.grid.minor = element_blank(),
                    panel.background = element_blank(), 
                    axis.line = element_line(colour = "black"))
    )
  }
  output$plot <- renderPlot({ 
    plotType(myData, input$pType)
  })
  
  output$table1 <- renderTable({
    
    leagtype<- input$league
    clubtype<- input$club
    if(leagtype=="English Premier League" && clubtype=="Arsenal"){
      data(arsenal)
      arsenal[1:10,]}
    else if(leagtype=="English Premier League" && clubtype=="Bournemouth"){
      data(bournemouth)
      bournemouth[1:10,]
    }
    else if(leagtype=="English Premier League" && clubtype=="Brighton & Hove Albion"){
      data(bright)
      bright[1:10,]
    }
    else if(leagtype=="English Premier League" && clubtype=="Burnley"){
      data(burn)
      burn[1:11,]
    }
    else if(leagtype=="English Premier League" && clubtype=="Chelsea"){
      data(chelsea)
      chelsea[1:11,]
    }
    else if(leagtype=="English Premier League" && clubtype=="Crystal Palace"){
      data(cry)
      cry[1:11,]
    }
    else if(leagtype=="English Premier League" && clubtype=="Everton"){
      data(burn)
      burn[1:11,]
    }
    
    
  },width = 750,striped = TRUE,spacing = "l")
  output$table2<-renderTable(
    {
      data(group1)
      group1[1:11,]
    },width = 750,striped = TRUE,spacing = "l")
  output$table3<-renderTable(
    {
      data(group2)
      group2[1:10,]
    },width = 750,striped = TRUE,spacing = "l")
  output$table4<-renderTable(
    {
      data(group3)
      group3[1:10,]
    },width = 750,striped = TRUE,spacing = "l")
  output$table5<-renderTable(
    {
      data(group4)
      group4[1:10,]
    },width = 750,striped = TRUE,spacing = "l")
  output$table6<-renderTable(
    {
      data(best_club )
      best_club [1:10,]
    },width = 750,striped = TRUE,spacing = "l")
  
  output$plot1<-renderPlot(
    {
      ggplot(group1,aes(x = OVERALL, fill = factor(OVERALL))) +
        geom_bar(color = "grey20") + guides(fill = FALSE)+
        labs(title="Raiting de los Jugadores")
    })
  output$plot2<-renderPlot(
    {
      ggplot(group2,aes(x = OVERALL, fill = factor(OVERALL))) +
        geom_bar(color = "grey20") + guides(fill = FALSE)+
        labs(title="Raiting de los Jugadores")
    })
  output$plot3<-renderPlot(
    {
      ggplot(group3,aes(x = OVERALL, fill = factor(OVERALL))) +
        geom_bar(color = "grey20") + guides(fill = FALSE)+
        labs(title="Raiting de los Jugadores")
    })
  output$plot4<-renderPlot(
    {
      ggplot(group4,aes(x = OVERALL, fill = factor(OVERALL))) +
        geom_bar(color = "grey20") + guides(fill = FALSE)+
        labs(title="Raiting de los Jugadores")
    })
  output$plot5<-renderPlot(
    {
      ggplot(group1, aes(EUR_VALUE, fill = EUR_VALUE )) +
        geom_density(position = "stack")
    })
  output$plot6<-renderPlot(
    {
      ggplot(group2, aes(EUR_VALUE, fill = EUR_VALUE )) +
        geom_density(position = "stack")
    })
  output$plot7<-renderPlot(
    {
      ggplot(group3, aes(EUR_VALUE, fill = EUR_VALUE )) +
        geom_density(position = "stack")
    })
  output$plot8<-renderPlot(
    {
      ggplot(group4, aes(EUR_VALUE, fill = EUR_VALUE )) +
        geom_density(position = "stack")
    })
  output$plot9 <- renderPlot({
    ggplot(trend_data , aes(eur_value,overall )) + geom_point()
    
  })
  output$table11<-renderTable(
    {
      datatable(head(best20_data, 6),options = list(scrollX = TRUE, pageLength = 3))
    },width = 750,striped = TRUE,spacing = "l")
}

# Run the application 
shinyApp(ui = ui, server = server)

