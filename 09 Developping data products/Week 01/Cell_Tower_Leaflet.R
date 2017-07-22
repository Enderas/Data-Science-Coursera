## Locate cell towers near my location, and display them on a map with LeafLet
### Assignment for week 1 of "Data products" course
library(leaflet)

## Load data on cell towers near my location
df <- read.csv(file.path("./Antennes_relais.csv"), sep = ";", header = TRUE)

## Prepare subsets from data
cell_towers_coord <- data.frame(
   lat = df$Latitude  + ifelse(df$Operateur == "BOUYGUES TELECOM" | df$Operateur == "FREE MOBILE", 0.0013, 0), 
   lng = df$Longitude + ifelse(df$Operateur == "BOUYGUES TELECOM" | df$Operateur == "SFR", 0.0017, 0)
)  # Extract latitude and longitude

cell_towers_col <- ifelse(df$Operateur == "BOUYGUES TELECOM", "red", ifelse(df$Operateur == "FREE MOBILE", "blue", ifelse(df$Operateur == "SFR", "green", "orange")))

cell_towers_popup <- paste("<B>", df$Operateur, "</B><BR />", df$Adresse.complete)

## Display the map
cell_towers_coord %>%
   leaflet() %>%
   addTiles() %>%
   addCircleMarkers(col = cell_towers_col, popup = cell_towers_popup) %>%
   addLegend(labels = c("BOUYGUES TELECOM", "FREE MOBILE", "SFR", "ORANGE"), colors = c("red", "blue", "green", "orange")) %>%
   addMarkers(lat=48.7272893, lng=2.5702044, popup="My home")



