library(DT)
library(dplyr)
library(tmap)
library(tmaptools)
library(sf)
library(ggplot2)
library(leaflet)
library(plotrix)

AfghanRef_dist <- read.csv("C:\\Users\\Saad Bin Tariq\\Desktop\\AfghanRef_dist.csv")
#summary(AfghanRef_dist)

AfghanRef_Ethcinity <- read.csv("C:\\Users\\Saad Bin Tariq\\Desktop\\AfghanRef_Ethcinity.csv")
#summary(AfghanRef_dist)

AfghanRef_age_group <- read.csv("C:\\Users\\Saad Bin Tariq\\Desktop\\AfghanRef_age_group.csv")
#summary(AfghanRef_age_group)

Afgh_area <- read.csv("C:\\Users\\Saad Bin Tariq\\Desktop\\PakRef_area.csv")

#to check the class of data set
sapply(AfghanRef_dist, class) 

pak<-st_read("C:\\Users\\Saad Bin Tariq\\Desktop\\SDA Project\\PAK_Bt.shp")

function(input, output, session){
  
  #structure
  output$structure<-renderPrint(
    #structure of data
    AfghanRef_dist %>%
      str()
  )
  
  #summary
  output$summary<-renderPrint(
    AfghanRef_dist%>%
      summary()
  )
  
  #data table
  output$dataT<-renderDataTable(
    AfghanRef_dist
  )
  #map
 # output$map<-renderLeaflet({
  output$map <- renderTmap({
    tm_shape(pak)+
      tm_fill("AfghanRe_2",popup.vars = c("Province "="NAME_1","Afghan Refugees "="AfghanRe_2","Afghan Refugees in Urban Areas"="AfghanRe_3","Afghan Refugees in Rural Areas"="AfghanRe_4"), id="NAME_3",title="Afghan Refugees",breaks = c(0,3,48,977,17372,308933,Inf))+
      tm_borders()
    tmap_mode("view")
    tmap_last()
  })
 # })
  #pie chart prov
  output$pie<-renderPlot({
    pie3D(AfghanRef_prov$`sum(No_of_Individuals)`,
          #labels=AfghanRef_prov$Province,
          radius = 1.75,
          col = 1:8,
          labelcex = 0.75,
          main="Afghan Refugees in Province",
          border = "white"
          #explode = .2,
    )
    legend("left",
           legend = AfghanRef_prov$Province,
           fill =1:8,
           cex = 1, # Legend size
           #lwd = 2,
           title = "Afghan Refugees in Provinces",
           bty = "n",
           
           inset = c(-1, 0),
           xpd = TRUE,
           horiz = FALSE
    )
  })
  
  #pie chart disctric
  output$pieD<-renderPlot({
    pie3D(AfghanRef_dist$No_of_Individuals,
          #labels=AfghanRef_prov$Province,
          radius = 1.75,
          col = 1:8,
          labelcex = 0.75,
          main="Afghan Refugees in Destricts",
          border = "white"
          #explode = .2,
    )
    legend("left",
           legend = AfghanRef_dist$District,
           fill =1:8,
           cex = .6, # Legend size
           #lwd = 2,
           title = "Afghan Refugees in Provinces",
           bty = "n",
           
           inset = c(-.6, 0),
           xpd = TRUE,
           horiz = FALSE
    )
  })
  
  #valueBox
  output$value1 <- renderValueBox({
    valueBox(
     value = sum(AfghanRef_dist$No_of_Individuals),
     subtitle = "Total Afghan Refugees in 2020",
     color = "purple"
      
     )
  })
  
  #valueBox2
  output$value2 <- renderValueBox({
    valueBox(
      value = max(AfghanRef_dist$No_of_Individuals),
      subtitle = "Hightest Number of Afghan Refugees are in district Peshawar",
      color = "purple"
      
    )
  })
  
  
  #scatter plot
  output$scater<-renderPlot({
    
    
    plot(Afgh_area$AfghanRe_2,Afgh_area$Shape_Area, main = "Regression for Number of Refugees in Districts on District Area",
         xlab = "Number of Refugees in Districs", ylab = "District Area in sq.km")
   # abline(lm(AfghanRe_2~Shape_Area,data = Afgh_area), col="blue")
  })
  
  
  #bar plot
  output$bar<-renderPlot({
    
    #ref<-AfghanRef_age_group[,c(AfghanRef_age_group$Age.Group,input$varX)]
    
    ggplot(AfghanRef_age_group, aes(x=Age.Group,y=Male)) + 
      geom_bar(stat = "identity")
  })
}

