cat("\014")
rm(list=ls()) 

library(readxl)
folderPath <- "C:/Users/iturr/OneDrive/Escritorio/I-mar/Archivos_juntos"
fileList <- list.files(folderPath, pattern = "*.xlsx", full.names = TRUE)


filename <- fileList[1]
datos <- read_excel(filename)

filename <- fileList[2]
datos2 <- read_excel(filename)

filename <- fileList[3]
datos3 <- read_excel(filename)

filename <- fileList[4]
datos4 <- read_excel(filename)

filename <- fileList[5]
datos5 <- read_excel(filename)

combinacion <- rbind(datos5,datos3,datos,datos2,datos4)
library(writexl)
station <- c('E01','E02','E03','E04','E05','E06','E07','E08','E09','E10','E11','E12','E13','E14','E15','E16','E17')


folderName <- paste0(folderPath,"/Resultados/")

if (!dir.exists(folderName)) {
  dir.create(folderName)
}

for (i in 1:17) {
  idx <- which(combinacion$Station == station[i])
  E <- combinacion[idx,1:24]
  write_xlsx(E, paste0(folderName,station[i],'.xlsx'))
  
}


