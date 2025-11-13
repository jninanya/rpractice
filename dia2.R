
### CONFIGURACION AREA DE TRABAJO
# setwd("ruta_area_de_trabajo")
# setwd("C:/Users/jninanya/OneDrive - CGIAR/Desktop/Dra_Edtih/RTaller")

### INSTALAR LIBRERIAS
# install.packages("dplyr")
# install.packages("agricolae")
 
### CARGAR LIBRERIAS
library(dplyr)
library(agricolae)

### LEER DATOS
file0 <- "file0.csv"   # Dataframe ejemplo
file1 <- "file1.csv"   # Datos para DCA
file2 <- "file2.csv"   # Datos para DBCA
file3 <- "file3.csv"   # Datos para Arreglo Factorial

d0 <- read.csv(file0)
d1 <- read.csv(file1)
d2 <- read.csv(file2)
d3 <- read.csv(file3)

#############################################################
### USO DE DPLYR
#############################################################
# Paquete para manipular facilmente dataframes
#
# USAMOS d0
head(d0)
d0$ID <- as.factor(d0$ID)
d0$BLOCK <- as.factor(d0$BLOCK)
d0$FACTOR1 <- as.factor(d0$FACTOR1)
d0$FACTOR2 <- as.factor(d0$FACTOR2)
d0$FACTOR3 <- as.factor(d0$FACTOR3)

# SUMMARISE
smr <- d0 %>%
  group_by(FACTOR1, FACTOR2) %>%
  summarise(N = n(),
            CC_mean = mean(CC),
            CC_cv = sd(CC)/mean(CC)*100,
            FTY_mean = mean(FTY),
            FTY_cv = sd(FTY)/mean(CC)*100
            )


# SUMMARISE AT
# Indicamos las variables en vars()
smr <- d0 %>%
  group_by(FACTOR1, FACTOR2) %>%
  summarise_at(vars(c("CC","FTY","MTY","BCR","CF")), mean)


# SUMMARISE IF
smr <- d0 %>%
  group_by(FACTOR1, FACTOR2) %>%
  summarise_if(is.numeric, mean)


###########################################################
# USO DE AGRICOLAE
###########################################################
# 
### DISENO: DCA ------------------------------------------
head(d1)
str(d1)
d1$OBS <- as.factor(d1$OBS)
d1$TRT <- as.factor(d1$TRT)

d1[,2:4] %>% 
  pivot_wider(names_from = TRT, values_from = YIELD)

# Modelo Anova
modelo <- aov(YIELD ~ TRT, data = d1)
sm <- summary(modelo)

# Normalidad de residuos: p > 0.05 (Es normal)
shapiro.test(residuals(modelo))

# Homogeneidad de varianzas: p > 0.05 (Varianzas homogeneas)
bartlett.test(YIELD ~ TRT, data = d1)

# Gráfico de diagnóstico
#par(mfrow=c(2,2))
#plot(modelo)

# Comparaciones multiples TUKEY
TK <- TukeyHSD(modelo)

# Comparaciones multiples LSD
out1 <- HSD.test(modelo, "TRT", group = TRUE)
out2 <- LSD.test(modelo, "TRT", p.adj = "none")




### DISENO: DBCA ------------------------------------------
head(d2)
str(d2)
d2$REP <- as.factor(d2$REP)
d2$TRT <- as.factor(d2$TRT)

d2[,2:4] %>% 
  pivot_wider(names_from = REP, values_from = YIELD)

# Modelo Anova
modelo <- aov(YIELD ~ TRT + REP, data = d2)
sm <- summary(modelo)

# Normalidad de residuos: p > 0.05 (Es normal)
shapiro.test(residuals(modelo))

# Homogeneidad de varianzas: p > 0.05 (Varianzas homogeneas)
bartlett.test(YIELD ~ TRT, data = d1)

# Gráfico de diagnóstico
#par(mfrow=c(2,2))
#plot(modelo)

# Comparaciones multiples TUKEY
TK <- TukeyHSD(modelo)

# Comparaciones multiples LSD
out1 <- HSD.test(modelo, "TRT", group = TRUE)
out2 <- LSD.test(modelo, "TRT", p.adj = "none")



### DISENO: DBCA ------------------------------------------
head(d3)
str(d3)
d3$REP <- as.factor(d3$REP)
d3$TRT <- as.factor(d3$TRT)
d3$GENO <- as.factor(d3$GENO)
d3$IND <- as.factor(d3$IND)

#d3[,2:4] %>% 
#  pivot_wider(names_from = REP, values_from = YIELD)

# Modelo Anova
modelo <- aov(YIELD ~ GENO*IND + REP, data = d3)
sm <- summary(modelo)

# Normalidad de residuos: p > 0.05 (Es normal)
shapiro.test(residuals(modelo))

# Homogeneidad de varianzas: p > 0.05 (Varianzas homogeneas)
bartlett.test(YIELD ~ TRT, data = d3)

# Gráfico de diagnóstico
#par(mfrow=c(2,2))
#plot(modelo)

# Comparaciones multiples TUKEY
TK <- TukeyHSD(modelo)

# Comparaciones multiples LSD
out1 <- HSD.test(modelo, "GENO", group = TRUE)
out2 <- HSD.test(modelo, "IND", group = TRUE)

