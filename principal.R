# Programa principal


#Indicar el directorio de trabajo

setwd("~/Personal/Interest/Programming/R-Cran/BodeLaw")

# Donde se encuentran los datos:

#directorio, sin acabar en /
Directorio <- "../Data"

#fichero
Fichero <- "planets.sincabecera.csv"

# Importar los datos con la funcion creada

LeerDatos(Fichero,Directorio);



