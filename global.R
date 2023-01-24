
library(dplyr)
library(tmap)
library(tmaptools)
library(sf)
library(ggplot2)
library(leaflet)


AfghanRef_dist <- read.csv("C:\\Users\\Saad Bin Tariq\\Desktop\\AfghanRef_dist.csv")
#summary(AfghanRef_dist)

AfghanRef_Ethcinity <- read.csv("C:\\Users\\Saad Bin Tariq\\Desktop\\AfghanRef_Ethcinity.csv")
#summary(AfghanRef_dist)

AfghanRef_age_group <- read.csv("C:\\Users\\Saad Bin Tariq\\Desktop\\AfghanRef_age_group.csv")
#summary(AfghanRef_age_group)

#to check the class of data set
sapply(AfghanRef_dist, class) 

AfghanRef_prov<-AfghanRef_dist %>% 
  group_by(Province) %>% 
  summarise(sum(No_of_Individuals),sum(Urban),sum(Rural))

pak<-st_read("C:\\Users\\Saad Bin Tariq\\Desktop\\SDA Project\\PAK_B.shp")


#datatype conversion
#AfghanRef_dist$No_of_Individuals <- as.numeric(as.character(AfghanRef_dist$No_of_Individuals))

AfghanRef_prov<-AfghanRef_dist %>% 
  group_by(Province) %>% 
  summarise(sum(No_of_Individuals))


#structure of data
AfghanRef_dist %>%
  str()

#summary
AfghanRef_dist%>%
  summary()

#few observation
AfghanRef_dist%>%
  head()

#map
tm_shape(pak)+
  tm_fill("AfghanRe_2",popup.vars = c("Afghan Refugees "="AfghanRe_2","Afghan Refugees in Urban Areas"="AfghanRe_3","Afghan Refugees in Rural Areas"="AfghanRe_4"), id="NAME_3",title="Afghan Refugees",breaks = c(0,100,500,1000,2000,4000,8000,25000,75000,100000,Inf))+
  tm_borders()
tmap_mode("view")
tmap_last()

#barplot
ggplot(AfghanRef_prov)+
  geom_col(aes(x = Province, 
               y = `sum(No_of_Individuals)`),
           fill = "light blue",
           width = .8)+
  theme_classic() +
  ggtitle("Afghan Refugees in Pakistan",
          subtitle = "December 2020")+
  labs(x = "Provinces",
       y = "Total Immigrants")+
  theme(axis.title = element_text(size = 11, face = "bold"),
        axis.text = element_text(size = 10),
        plot.title = element_text(size = 20, hjust = 0.5),
        plot.subtitle = element_text(size = 10, hjust= 0.5))

#choice s
AfghanRef_prov%>%
  select()%>%
  names()


ggplot(AfghanRef_age_group, aes(x=AfghanRef_age_group$Age.Group, y=AfghanRef_age_group$Male)) + 
  geom_bar(stat = "identity")
