# rpractice

library(openxlsx)

# URL al archivo RAW (importante que sea "raw")
url <- "https://github.com/jninanya/rpractice/raw/refs/heads/main/dataR.xlsx"

# Crear un archivo temporal
temp <- tempfile(fileext = ".xlsx")

# Descargar correctamente en modo binario
download.file(url, destfile = temp, mode = "wb")

# Leer el archivo descargado
datos <- read.xlsx(temp, sheet = 1)

head(datos)
