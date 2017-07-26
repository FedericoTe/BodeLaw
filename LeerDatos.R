# Importar los datos de los planetas que se ha  extraído de
# 
# 

LeerDatos <- function(NombreFichero,Directorio){
  
  direccion <- paste(Directorio,NombreFichero,sep="/")
  planetas <- read.csv2(direccion)
}


