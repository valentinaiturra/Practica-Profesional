cat("\014")
rm(list=ls()) 

library(sp)
library(akima)
library(ncdf4)
library(plotrix)
library(sf)
library(terra)

setwd("C:/Users/iturr/OneDrive/Escritorio/Rcurso/R2025/Instrucciones/mapa.base")
lagos<-st_read("los_lagos.shp")
lagos <- lagos$geometry

chile<-st_read("chile_continental_utm19.shp")
chile <- chile$geometry

setwd('C:/Users/iturr/OneDrive/Escritorio/Rcurso/R2025/Instrucciones/cuerpos_agua/')
rios1<-st_read("Rios.shp")
rios1 <- rios1$geometry

rios2<-st_read("geo_cuerpos_agua.shp")
rios2 <- rios2$geometry

rios3<-st_read("riosX.shp")
rios3 <- rios3$geometry

rios4<-st_read("lagosX.shp")
rios4 <- rios4$geometry

estaciones <- read.csv("C:/Users/iturr/OneDrive/Escritorio/I-mar/estaciones_fondecyt_2022.csv",sep = ";", header = TRUE)


datos <- rast("C:/Users/iturr/OneDrive/Escritorio/I-mar/gebco_2024_n-44.263_s-45.0234_w-73.5_e-72.5.nc")
elevacion <- as.data.frame(datos, xy = TRUE)

png("C:/Users/iturr/OneDrive/Escritorio/I-mar/mapajunto.png",width=3600, height=2600, units="px", res=300)
#windows(width=3600, height=2600)


layout.matrix <- matrix(c(2, 2,2,0,2,2,2,0,0,1,1,1,0,1,1,1), nrow = 4, ncol = 4)

nf <- layout(mat = layout.matrix,
       heights = c(1, 1,2,2), # Heights of the two rows
       widths = c(2,1, 2,2))
layout.show(nf)

par(mar=c(4,1,1,1))
plot(lagos, 
     ylim=c(-45.0234,-44.2630),
     xlim=c(-73.3,-72.7), 
     axes=T, 
     cex.axis=1.2, 
     col="#9ACD32", 
     las=1, 
     border="#698B22", 
     mgp=c(0,0.7,0), 
     lwd=1.5,
     bg="#B2DFEE"
     )



points(-72.924750,-44.619836, pch = 17, col = "blue",cex = 2)
text(-72.854750,-44.619836,"Seno 
     Magdalena",srt = 0,cex = 1.5,font = 2)

text(-73.5,-44.6,"Canal Moraleda",srt = 80,font = 2,cex=2.5)

points(-72.762331,-44.449510, pch = 17, col = "blue",srt = 90, ,cex = 2)
text(-72.72,-44.44, "Canal 
     Jacaf",srt = 0,font = 2,cex = 1.5)

text(-73.105339,-44.693203, "Parque Nacional 
     Isla Magdalena",font = 2,cex = 2)
points(-72.680494,-44.727254, pch = 15, col = "#EE7600",cex = 2)
text(-72.560494,-44.727254, "Puerto Cisnes",srt = 0,font = 2,cex = 1.5)

points(-72.558398,-44.325590, pch = 15, col = "#EE7600",cex = 2)
text(-72.648398,-44.315590, "Puyuhuapi",srt = 0,font = 2,cex = 1.5)

text(-72.833472,-44.761594, "Fiordo Puyuhuapi",srt = 45,font = 2,cex = 1.5)

points(-72.709196,-44.762117, pch = 17, col = "blue",cex = 2)
text(-72.613472,-44.761594, "Río Cisnes",srt = 0,font = 2,cex = 1.5)

 par(mar=c(1,4,1,3))
 plot(lagos, 
      ylim=c(-45,-42.3),
      xlim=c(-74.3,-73.8), 
      axes=T, 
      cex.axis=1.2, 
      col="#9ACD32", 
      las=1, 
      border="#698B22", 
      mgp=c(0,0.7,0), 
      lwd=1.5,
      bg="#B2DFEE", add=T
 )

 
 
 polygon(c(-73.52,-72.509,-72.509,-73.52), c(-45.0234,-45.0234,-44.2630,-44.2630), border = "black",lwd=2.5)
 text(-75.3,-43.3, "Océano Pacífico",srt = 80,font = 2,cex = 3.5)
 text(-73.9,-42.69, "Isla Grande de Chiloé",srt = 80,font = 2,cex = 1.5)
 
dev.off() 


#png("C:/Users/iturr/OneDrive/Escritorio/I-mar/mapaestaciones.png",width=2600, height=2600, units="px", res=300)
#windows(width=2600, height=2600)

#par(mar=c(4,4,1,1))
#plot(lagos, 
#     ylim=c(-45.0234,-44.2630),
#     xlim=c(-73.3,-72.7), 
#     axes=T, 
#     #cex.axis=0.8, 
#     col="#9ACD32", 
#     las=1, 
#     border="#698B22", 
     #mgp=c(0,0.7,0), 
     #lwd=0.5,
#     bg="#B2DFEE"
#)
#nombres <- c("E01","E02","E03","E04","E05","E06","E07","E08","E09","E10","E11","E12","E13","E14","E15","E16","E17")
#points(estaciones$long,estaciones$lat,
#      pch=16,
#     col="red")
#for (i in 1:17){
#  text(estaciones$long[i]+0.03,(estaciones$lat[i]+0.01), nombres[i],font = 2)
#}
#dev.off()
