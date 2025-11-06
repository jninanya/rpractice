# Este simbolo (#) es un comentario


### TIPOS DE VARIABLES ---------------------------

# Numerico
x <- 1 + 2

# Caracteres
x <- "Johan"   # Siempre con doble comilla

# logicos
x <- TRUE      # TRUE o FALSE
x <- 4 > 5
x <- 4 == 4


## TIPOS DE OBJETOS --------------------------

# NOTA: funcion tiene la siguiente forma
#    nombre_de_la_funcion()

# Vector
x1 <- c(1, 2, 3, 5, 7, 8)
x2 <- c("T1", "T2", "T3", "T4", "T5", "T6")
x3 <- c(TRUE, FALSE, TRUE, TRUE, FALSE, TRUE)
x4 <- x1 >= 3

# Data Frame
df <- data.frame(x1, x2, x3, x4)

# Matriz
mtx <- matrix(runif(10),5,2)

# Listas
L <- list(x1, x2, df, mtx)
names(L) <- c("vector1","vector2","dataframe","matriz")

## ACCEDER AL DATO USAR []  ----------------
# Vector
x1[5]

# Data Frame  [fila, columna]
df[5,2]
df$x2[5]

# Listas
L[[3]]
L[[3]][,4]
L[[3]]$x4


## INSTALACION DE PAQUETES/LIBRERIAS ------------
#install.packages("nombre_del_paquete")

install.packages("agricolae")
install.packages("openxlsx")
install.packages("dplyr")

### 
file <- url("https://raw.githubusercontent.com/jninanya/rpractice/refs/heads/main/dataR.csv")
df <- read.csv(file)

df %>% 
  group_by(FACTOR1, FACTOR2, FACTOR3) %>% 
  summarise_if(is.numeric, sd)













