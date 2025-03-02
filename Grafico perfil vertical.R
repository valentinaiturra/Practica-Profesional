#Script para determinar capas finas

#Valentina Iturra Rosales
#Geofísica Universidad de Concepción

#En el contexto de práctica profesional en centro I-mar


cat("\014")
rm(list=ls()) 

folderPath <- "C:/Users/iturr/OneDrive/Escritorio/I-mar/6_febrero_2025/"
fileList <- list.files(path = paste0(folderPath,"Data"), pattern = "*.xlsx", full.names = TRUE)
posiciones <- read.csv("C:/Users/iturr/OneDrive/Escritorio/I-mar/estaciones_fondecyt_2022.csv",sep = ";", header = TRUE)

estaciones <- matrix(nrow = length(fileList),ncol = 1)
parametros <- matrix(nrow = length(fileList),ncol = 6)


for (i in 3) {
  
  #Se cargan los datos 
  library(readxl)
  filename <- fileList[i]
  datos <- read_excel(filename)
  
  A <- gregexpr("PUYUHUAPI", filename)
  
  #Se realiza un corte de los datos hasta una cierta profundad
  preg <- readline(prompt = paste0("¿Deseas cortar los datos de ", substr(filename, start=(as.numeric(A) + 10), stop=(as.numeric(A) + 12)), " a cierta profundidad? [Y/N] "))
  
  if (tolower(preg) == "y") {
    preg2 <- readline(prompt = "¿Hasta que profundidad [metros] deseas cortarlos? ")
    preg2 <- as.numeric(preg2)
    
    # Encontrar el índice del valor mínimo de esa diferencia
    stop <- which.min(abs(datos$Depth - preg2))
  } else if (tolower(preg) == "n"){
    stop <- which.min(abs(datos$Depth - tail(datos$Depth,1)))
  }
  
  #Se guardan los datos que se usarán en nuevas variables
  clorofila <- datos[(1:stop),5]
  Temperatura <- datos[(1:stop),3]
  salinidad <- datos[(1:stop),10]
  oxigeno <- datos[(1:stop),7]
  profundidad <- datos[(1:stop),9]
  densidad <- datos[(1:stop),14]
  
  #Se grafican los datos
  #png("C:/Users/iturr/OneDrive/Escritorio/I-mar/perfilvertical.png",width=2000, height=2600, units="px", res=300)
  windows(width=2000, height=2600)
  par(mar=c(18,8,2,8))
  plot(
    clorofila$`Chlorophyll a`, profundidad$Depth,
    ylim = rev(range(profundidad$Depth)),
    type = 'l',
    col = '#77AC30',
    lwd = 3,
    axes = F,
    xlab = "",
    ylab ="",
    main = paste("Vertical profile at ", substr(filename, start=(as.numeric(A) + 10), stop=(as.numeric(A) + 12)), "on" , substr(filename, start=(as.numeric(A) + 17), stop=(as.numeric(A) + 18)), "/", substr(filename, start=(as.numeric(A) + 14), stop=(as.numeric(A) + 15)), "/", substr(filename, start=(as.numeric(A) + 20), stop=(as.numeric(A) + 23)))
    
  )
  axis(1,xaxp = c(0, 45, 5),col = '#77AC30',col.ticks = '#77AC30',col.axis = '#77AC30')
  axis(2)
  mtext("Clorofila [µg/L]",side = 1,line = 2,col = '#77AC30')
  par(new=T)
  plot(
    oxigeno$`Dissolved O??? concentration`, profundidad$Depth,
    ylim = rev(range(profundidad$Depth)),
    type = 'l',
    col = '#FFC125',
    lwd = 3,
    axes = F,
    xlab = "",
    ylab ="Profundidad [m]"
    )
  axis(1, line = 4,xaxp = c(225, 285, 6),col = '#FFC125',col.ticks = '#FFC125',col.axis = '#FFC125') 
  mtext("Oxígeno [µmol/L]",side = 1,line = 6,col = '#FFC125')
  par(new=T)
  plot(
    salinidad$Salinity, profundidad$Depth,
    ylim = rev(range(profundidad$Depth)),
    type = 'l',
    col = '#EE2C2C',
    lwd = 3,
    axes = F,
    xlab = "",
    ylab =""
   )
  axis(1, line = 8,xaxp = c(18, 32, 5),col = '#EE2C2C',col.ticks = '#EE2C2C',col.axis = '#EE2C2C') 
  mtext("Salinidad [PSU]",side = 1,line = 10,col = '#EE2C2C')
  par(new=T)
  
  plot(
    Temperatura$Temperature...3, profundidad$Depth,
    ylim = rev(range(profundidad$Depth)),
    type = 'l',
    col = '#1874CD',
    axes = F,
    lwd = 3,
    xlab = "",
    ylab =""
    )
  axis(1, line = 12, xaxp = c(12, 17, 5),col = '#1874CD',col.ticks = '#1874CD',col.axis = '#1874CD')
  mtext("Temperatura [°C]",side = 1,line = 14,col = '#1874CD')
  dev.off()
}

