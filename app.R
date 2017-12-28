

#setwd("~/R/Dog/Dog")

library(shiny)
library(rsconnect)
library(plotly)


ui <- fluidPage(
  
   headerPanel("Select your puppy ! " ),HTML("</BR</BR></BR></BR><i><h3 style='color:#FF152A'>
   This Shiny app is best viewed in Chrome. IE is very slow"),HTML("</BR></i></h3>"),
   
   
   sidebarLayout(
      sidebarPanel(
        
         checkboxGroupInput("IQ", "Select Intelligence/Obedience:",
                        c(                          "Brightest" = "Brightest Dogs",
                        "Excellent"="Excellent Working Dogs",
                       "Above Average" = "Above Average Working Dogs",
                       "Average" = "Average Working/Obedience Intelligence",
                       "Fair"="Fair Working/Obedience Intelligence"
                       
                       ),selected=c("Brightest Dogs","Excellent Working Dogs","Above Average Working Dogs","Average Working/Obedience Intelligence","Fair Working/Obedience Intelligence")),HTML("</BR></BR>"),
         
         
         sliderInput("Heightrange", "Height (Inches):",
                     min = 1, max = 40,
                     value = c(0,40)),HTML("</BR></BR>"),
         
         
         sliderInput("Weightrange", "Weight (lbs):",
                     min = 1, max = 160,
                     value = c(0,160)),HTML("</BR></BR>"),HTML("<h4>"),
         
         
         checkboxInput("ShowText", "Show Dog Breed Names",FALSE),HTML("</h4>")
                       
         
         
      ),
      
      
      
      
      # Show a plot of the generated distribution
      mainPanel(
        
        tags$style(type="text/css",
                   ".shiny-output-error { visibility: hidden; }",
                   ".shiny-output-error:before { visibility: hidden; }"
        ),
        
        tabsetPanel(
          
        
        tabPanel(HTML("<h4><B> Plot </h4></B>"),plotlyOutput("Plot",height="auto",width="auto"),
        HTML("</BR></BR>")),
        
        tabPanel(HTML("<h4><B> Table </h4></B>"),tableOutput('table')),
        tabPanel(HTML("<h4><B>Documentation </h4></B>"),HTML("<br/><br/> <h4> <B>This app shows the following details of some well known Dog breeds.</B></h4> <br/><br/> 1)Average Height (inches) <br/> 2)Average Weight (lbs) <br/> 3)Intelligence <br/> <br/> On the left side in the Plot tab , we have 4 selectors <br/> <br/> 1)Select Intelligence - Click the check boxes to select Breed Intelligence. <br/> 2)Select Height Range - Select the Height Range <br/> 3)Select Weight Range - Select the Weight Range <br/> 4)Show/Hide Dog Breed Names <br/> <br/> On the right side of the Plot tab we have <br/> 1) Scatter Plot on top and <br/> 2)Table in the bottom. <br/> <br/> <h4> <B>Data Source:</B></h4> <br/> <br/> The data for this visual is available in https://data.world/ <br/> <br/> 1) AKC Breed Info.csv <br/> 2) dog_intelligence.csv <br/> <br/>  "))
           
              )
            )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  
  df1<-read.csv(file="AKC Breed Info_r.csv",sep = ",",header=TRUE,stringsAsFactors=FALSE)
  
  df1$Breed <- toupper(df1$Breed) 
  df2<-read.csv(file="Breed_intelligence_r.csv",sep = ",",header=TRUE,stringsAsFactors=FALSE)
  
  df2$Breed <- toupper(df2$Breed) 
  
  df<-merge(df1, df2, all.x = TRUE,by =c("Breed"))
  df$Classification<-as.factor(df$Classification)
  
  df[df == '#N/A'] <- NA
  df[df == 'n/a'] <- NA
  df[df == 'na'] <- NA
  df[df == 'not found'] <- NA
  df[df == 'VIZSLA'] <- NA # Appears to have incorrect data for this breed . Height shown  is 66 inches !. 
  df <- df[complete.cases(df), ]
  
  df$height_low_inches<-as.numeric(df$height_low_inches)
  df$height_high_inches<-as.numeric(df$height_high_inches)
  
  
  ## Loading and Cleansing Data  (R CODE) ..continued
  
  df$height_inches <- (df$height_low_inches + df$height_high_inches)/2 # Average Height
  
  
  df$weight_low_lbs<-as.numeric(df$weight_low_lbs)
  df$weight_high_lbs<-as.numeric(df$weight_high_lbs)
  
  df$weight_lbs <- (df$weight_low_lbs+df$weight_high_lbs)/2 # Average Weight
  
  df <- df[,c("Breed","height_inches","weight_lbs","Classification")]
  
 #dfs <- reactive({
   
   
  
#   s <- data.frame(subset(df, Classification %in% input$IQ & height_inches >=input$Heightrange[1] & height_inches<=input$Heightrange[2] &  weight_lbs >=input$Weightrange[1] & weight_lbs <=input$Weightrange[2]))
   
 #  return(s)
 #})

  
 dfs <- reactive({
  
  
  
     s <- df[df$Classification %in% input$IQ & df$height_inches >=input$Heightrange[1] & df$height_inches<=input$Heightrange[2] &  df$weight_lbs >=input$Weightrange[1] & df$weight_lbs <=input$Weightrange[2],]
     
   #  s <- s[,c("Breed","height_inches","weight_lbs","Classification")]
     
     
     
  
    return(s)
  })
  
 output$table <- renderTable(dfs())
 
  
  
 
  
 uicol <- reactive({
   
   if(input$ShowText==FALSE) {c <- rgb(0,0,0,alpha=0.3) } else {c <- c("blue")}
   return(c)
   
 })
   
   output$Plot <- renderPlotly({

     

     plot_ly(dfs(), x = ~weight_lbs, y = ~height_inches,
             
             text = ~Breed, textposition = 'right',
             textfont = list( color =uicol(),size = 10,family = "sans serif"),
             
             
             
             type = "scatter", mode = "markers", color = ~Classification,colors=c("red", "blue", "green","orange","pink","purple"),marker = list(line = list(color = 'rgba(0, 0, 0, 0)',width=2),opacity = 0.9,size=15))%>%
       layout(legend = list(orientation = "l",bordercolor = "#00FFFF",
                            borderwidth = 1 )
       ,xaxis=list(title="Weight (lbs)"))

   })
}

# Run the application 
shinyApp(ui = ui, server = server)

