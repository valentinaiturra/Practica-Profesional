#Script para realizar histogramas para caracterizar capas finas

#Valentina Iturra Rosales
#Geofísica Universidad de Concepción

#En el contexto de práctica profesional en centro i-mar


cat("\014")
rm(list=ls()) 

library(readxl)
folderPath <- "C:/Users/iturr/OneDrive/Escritorio/I-mar/5_octubre_2024/Resultados_en_R/Parametros.xlsx"

datos <- read_excel(folderPath)

a <- 0
layers <- data.frame()
for (i in 1:length(datos$Station)) {
  if (as.numeric(datos$Thickness[i]) <= 5 & as.numeric(datos$Intensity[i]) >= 3*(as.numeric(datos$Background[i]))) {
    a <- a+1
    layers[a,1:5] <- datos[i,1:5]
    
  }else {
    
    next
  }
}


#png(file = "C:/Users/iturr/OneDrive/Escritorio/I-mar/1_septiembre_2023/imagen.png",
    #width=1000, height=2600, units="px", res=300)

windows(width=1000, height=2600)
par(mfrow=c(4,1),mar=c(5,5,0.5,3),oma=c(0,0,5,0))
hist(as.numeric(layers$Background),
     breaks = 8,
     xlab = "Background",
     ylab = "Frecuencia",
     main = "",
     las = 1,
     col = '#EDB120'
     )
mtext(text="Parámetros capas finas en campaña",side=3,cex=1,line=3.5)
mtext(text=" Septiembre 2023",side=3,cex=1,line=2)
hist(as.numeric(layers$Intensity),
     breaks = 4,
     ylab = "Frecuencia",
     xlab = "Intensity",
     main = "",
     las = 1,
     col = '#0072BD',
     )
hist(as.numeric(layers$Thickness)*100,
     breaks = 3,
     ylab = "Frecuencia",
     xlab = "Thickness",
     main = "",
     las = 1,
     col = '#A2142F'
     )
hist(as.numeric(layers$Depth),
     breaks = 5,
     ylab = "Frecuencia",
     xlab = "Depth",
     main = "",
     las = 1,
     col = '#77AC30'
     )

dev.off()
