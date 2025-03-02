# Crear un conjunto de datos de ejemplo
datos <- data.frame(
  Mes = rep(c("Febrero"), each = 22),
  Estado = "Hola"
)

datos$Mes[1:10] = "Febrero"
datos$Estado[1:9] = "Encima"
datos$Estado[10] = "Abajo"

datos$Mes[11] = "Junio"
datos$Estado[11] = "Abajo"

datos$Mes[12:22] = "Octubre"
datos$Estado[12:18] = "Encima"
datos$Estado[19:22] = "Abajo"
datos

# Crear la tabla de contingencia
tabla_variables <- table(datos$Estado,datos$Mes)

#png("C:/Users/iturr/OneDrive/Escritorio/I-mar/barras.png",width=2600, height=2600, units="px", res=300)

windows(height = 2600,width = 2600)
nf<-layout(matrix(c(1,1,1,1,1,1,1,2,2), 3, 3, byrow = TRUE), widths=c(1,0.7), heights=c(1,1.1))
layout.show(nf)
# Crear el gráfico de barras
par(mar=c(4,6,4,1.5),oma=c(1.5,0,1,1))
barplot(tabla_variables,
        main = "Distribución de capas finas en campañas de 2024",
        xlab = "Meses", ylab = "Cantidad",
        col = c('#77AC30', '#EDB120'),  # Colores para "Encima", "Abajo" y "Sobre"
        #legend.text = c(expression("Sobre el máximo de" ~ N^2),expression("Bajo el máximo de" ~ N^2)),  # Leyenda con los estados
        beside = TRUE,
        yaxt = "n",
        #xaxt = "n",
        #legend.text = c(expression(paste("Sobre el máximo de ", N^2)),expression(paste("Bajo el máximo de ", N^2))),
        cex.main =2.5,
        cex.axis = 2,
        cex.lab = 2.5,
        cex.names =2,
        font.main = 4
        )  # Barras agrupadas
axis(2,las = 1,yaxp = c(0, 9, 9),cex.axis = 2)
legend("topright", legend = c(expression(paste("Sobre el máximo de ", N^2)),expression(paste("Bajo el máximo de ", N^2))),
       cex =2, fill = c('#77AC30','#EDB120'))


#axis(1, xaxp = c(10,60,4))
dev.off()
     