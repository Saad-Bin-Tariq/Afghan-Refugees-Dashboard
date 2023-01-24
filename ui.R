library(shiny)
library(shinydashboard)
library(dplyr)
library(tmap)
library(tmaptools)
library(sf)
library(ggplot2)
library(leaflet)
dashboardPage(title = "Afghan Refugees in Pakistan",skin = "purple",
  dashboardHeader(title = "Afghan Refugees in Pakistan",
                  titleWidth = 300
                 ),
  
  dashboardSidebar(
    sidebarMenu(
      id="sidebar",
      #1st menu item
      menuItem("Dataset",tabName = "data",icon = icon("database")),
      menuItem(text = "Statistics", tabName = "stats",icon = icon("chart-line")),
      menuItem(text = "Spatial Visualization", tabName = "map",icon = icon("map"))
      
    )
  ),
  dashboardBody(
    

    
    
    tabItems(
      tabItem(tabName = "data",
              tabBox(id="t1",width = 12,
                     tabPanel("About", icon = icon("address-card"),
                              fluidRow(
                                valueBoxOutput('value1', width = 4),valueBoxOutput('value2', width = 7)
                              ),
                              fluidRow(column(width = 8, tags$img(src="ref.jpg", width =520 , height = 360),
                                              tags$br() , 
                                              tags$a(""), align = "center"),
                                       column(width = 4,
                                              tags$p("Afghan refugees have been present in Pakistan for several decades, with the largest influx occurring during the Soviet-Afghan War in the 1980s. As of 2020, there were an estimated 2.5 million Afghan refugees living in Pakistan, making it the largest refugee-hosting country in the world. Many of these refugees live in camps along the Afghanistan-Pakistan border, while others have settled in urban areas."),
                                              tags$p("In recent years, there has been a push for the voluntary repatriation of Afghan refugees, with the Pakistani government and UNHCR working together to facilitate the return of refugees to Afghanistan. However, the ongoing conflict and instability in Afghanistan has made it difficult for many refugees to return home. As a result, many Afghan refugees in Pakistan continue to live in a state of limbo, uncertain about their future."))),
                              ),
                     tabPanel(title="Data Observations", icon = icon("table"),dataTableOutput("dataT")),
                     tabPanel(title = "Data structure", icon = icon("uncharted"),verbatimTextOutput("structure")),
                     tabPanel(title = "Statistical Summary", icon = icon("chart-pie"),verbatimTextOutput("summary"))
                     )
              ),
      
      tabItem(tabName = "stats",
              tabBox(id="t2",width = 12,
                     tabPanel(title = "Refugees trend by District", value = "trends_d",plotOutput("pieD")),
                     tabPanel(title = "Refugees trend by Province", value = "trends_p",plotOutput("pie")),
                     tabPanel(title = "Refugees by Age and Gender", value = "trends_d",selectInput(inputId = "varX",label = "Choose gender",choices = list("Male","Female"),selected = "male") ,plotOutput("bar")),
                     tabPanel(title = "Refugees and Provice Area",plotOutput("scater"))
                     )
        
             ),
      tabItem(tabName ="map",
              
                     fluidRow(
                       tmapOutput('map',height = 565)
                       #column(width=10, offset = 2.5,)
                     )
                    
              
              )
    )
  )
)