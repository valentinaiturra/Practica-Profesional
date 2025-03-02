#valores <- c(30, 20, 50)
#categorias <- c("A", "B", "C")

# Gráfico de torta
#pie(valores, labels = categorias, main = "Gráfico de Torta")

cat("\014")
rm(list=ls()) 

library(readxl)

datos_feb <- read_excel("C:/Users/iturr/OneDrive/Escritorio/I-mar/3_febrero_2024/Resultados_en_R/Parametros.xlsx")

a <- 0
layers_feb <- data.frame()
for (i in 1:length(datos_feb$Station)) {
  if (as.numeric(datos_feb$Thickness[i]) <= 5 & as.numeric(datos_feb$Intensity[i]) >= 3*(as.numeric(datos_feb$Background[i]))) {
    a <- a+1
    layers_feb[a,1:6] <- datos_feb[i,1:6]
    
  }else {
    
    next
  }
}

datos_jun <- read_excel("C:/Users/iturr/OneDrive/Escritorio/I-mar/4_junio_2024/Resultados_en_R/Parametros.xlsx")

a <- 0
layers_jun <- data.frame()
for (i in 1:length(datos_jun$Station)) {
  if (as.numeric(datos_jun$Thickness[i]) <= 5 & as.numeric(datos_jun$Intensity[i]) >= 3*(as.numeric(datos_jun$Background[i]))) {
    a <- a+1
    layers_jun[a,1:6] <- datos_jun[i,1:6]
    
  }else {
    
    next
  }
}

datos_oct <- read_excel("C:/Users/iturr/OneDrive/Escritorio/I-mar/5_octubre_2024/Resultados_en_R/Parametros.xlsx")

a <- 0
layers_oct <- data.frame()
for (i in 1:length(datos_oct$Station)) {
  if (as.numeric(datos_oct$Thickness[i]) <= 5 & as.numeric(datos_oct$Intensity[i]) >= 3*(as.numeric(datos_oct$Background[i]))) {
    a <- a+1
    layers_oct[a,1:6] <- datos_oct[i,1:6]
    
  }else {
    
    next
  }
}

layers_feb$Thickness <- as.numeric(layers_feb$Thickness)* 100
layers_jun$Thickness <- as.numeric(layers_jun$Thickness)* 100
layers_oct$Thickness <- as.numeric(layers_oct$Thickness)* 100

which(as.numeric(layers_feb$Depth) < 50 & as.numeric(layers_feb$Depth) > 40)

datos <- data.frame(
  Mes = rep(c("Febrero"), each = 22),
  Estado = "Hola"
)

datos$Mes[1] = "Junio"
datos$Estado[1] = "[10-20["

datos$Mes[2:11] = "Febrero"
datos$Estado[2:4] = "[30-40["
datos$Estado[5:7] = "[40-50["
datos$Estado[8:10] = "[50-60["
datos$Estado[11] = "[50-60["

datos$Mes[12:22] = "Octubre"
datos$Estado[12:15] = "[20-30["
datos$Estado[16:18] = "[30-40["
datos$Estado[19:22] = "[40-50["
datos
tabla_variables_a <- table(datos$Mes,datos$Estado)

#png("C:/Users/iturr/OneDrive/Escritorio/I-mar/grosor.png",width=2600, height=2600, units="px", res=300)
windows(height = 2600,width = 2600)
# Crear el gráfico de barras
nf<-layout(matrix(c(1,1,1,1,1,1,1,2,2), 3, 3, byrow = TRUE), widths=c(1,0.7), heights=c(1,1.1))
layout.show(nf)
par(mar=c(4,6,4,1.5),oma=c(1.5,0,1,1))
barplot(tabla_variables_a,
        main = "Grosor de capas finas en campañas de 2024",
        xlab = "Thickness [cm]", 
        ylab = "Frecuencia",
        col = c('#77AC30','#EDB120','#0072BD'),  # Colores para "Encima", "Abajo" y "Sobre"
        #legend.text = c(expression("Sobre el máximo de" ~ N^2),expression("Bajo el máximo de" ~ N^2)),  # Leyenda con los estados
        beside = TRUE,
        yaxt = "n",
        #xaxt = "n",
        space = c(-0.5, 0.5),
        ylim = c(0,5),
        cex.main =2.5,
        cex.axis = 2,
        cex.lab = 2.5,
        cex.names = 2,
        font.main = 4
)  # Barras agrupadas
legend("topright", legend = c("Febrero","Junio","Octubre"), fill = c('#77AC30','#EDB120','#0072BD'),cex = 2)
axis(2,las = 1,yaxp = c(0, 6, 6),cex.axis = 2)
#axis(1, xaxp = c(10,60,5),side =1)
dev.off()


#png("C:/Users/iturr/OneDrive/Escritorio/I-mar/depth.png",width=3600, height=2600, units="px", res=300)
windows(width=3600, height=2600)
par(mfrow=c(1,2),mar=c(5,5,0.5,3),oma=c(0,0,5,0))
hist(as.numeric(layers_feb$Depth),
     xlab = "Depth [m]",
     ylab = "Frecuencia",
     main = "",
     las = 1,
     col = '#77AC30',
     ylim=c(0,5),
     cex.axis = 1.5,
     cex.lab = 1.5,
    xlim = c(0,11)
)
mtext(text="Profundidades de capas finas en campañas de 2024",side=3,cex=2,line=1.5,outer=TRUE,font = 4)
mtext(text="Febrero",side=3,cex=1.5,line=-0.5)
hist(as.numeric(layers_oct$Depth),
     breaks = 11,
     ylab = "Frecuencia",
     xlab = "Depth [m]",
     main = "",
     las = 1,
     col = '#0072BD',
     ylim = c(0,5),
     cex.axis = 1.5,
     cex.lab = 1.5,
     #axes = FALSE
     xlim = c(0,11)
)
#axis(1, at = seq(1, 10, by = 1)) 
mtext(text="Octubre",side=3,cex=1.5,line=-0.5)
dev.off()
