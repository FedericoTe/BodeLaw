###########################################################################
#
#Importar los datos de los planetas que se ha  extraído de:
#
#   NASA Exoplanets Archive
# 
# Con esta consulta:
#
#  https://exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI/nph-nstedAPI?table=exoplanets&select=pl_hostname,st_mass,st_rad,pl_pnum,pl_name,pl_orbper,pl_orbsmax,pl_orbeccen,pl_ratdor
#
#
# 
# En consola he extraído los datos con:
#
#  wget "https://exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI/nph-nstedAPI?table=exoplanets&select=pl_hostname,st_mass,st_rad,pl_pnum,pl_name,pl_orbper,pl_orbsmax,pl_orbeccen,pl_ratdor&format=csv" -O "planets.txt"
#
#   Despues he creado un data.frame con los valores por filas de
#   Nombre_Estrella, Distancia_de cada Planeta_NA
#
#
#   Se trabaja con los datos extraídos y se devuelve un data frame de tres columnas:
#
#   NombreEstrella |  NumeroPlanetas  |  SistemaSolar
#
# La primera es un caracter con el nombre de la estrella
# La segunda es otro caracter con el número de planetas en ese sistema
# La tercera es una lista con las distancias ordenadas de cada planeta en U.A.
#
#
#########################################################################


# Para usar las funciones select(), filter() y group_by() del paquete dplyr
library(dplyr) 


LeerDatos <- function(Enlace){
  
  Enlace <- "https://exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI/nph-nstedAPI?table=exoplanets&select=pl_hostname,st_mass,st_rad,pl_pnum,pl_name,pl_orbper,pl_orbsmax,pl_orbeccen,pl_ratdor&format=csv"
  
  direccion <- Enlace
  
  
  Cabecera <- c("StarName","StarMass","RadiusMass","NumberOfPlanetsInSystem","PlanetName","OrbitalPeriod-Days","Planet-SemiMajor-Axis","Planet-Eccentricity","Ratio-Distance-StellarRadius")
  planetas <- read.csv(direccion, sep =',',header = FALSE, col.names = Cabecera, stringsAsFactors = FALSE)
  
  #Seleccionamos aquellos sistemas donde tenemos como mínimo cuatro planetas 
  
  Seleccion <- planetas[as.numeric(planetas$NumberOfPlanetsInSystem)>3,]
  
  # Seleccionamos los datos relevantes que están por columnas:
  Seleccion <- select(Seleccion,StarName,Planet.SemiMajor.Axis,NumberOfPlanetsInSystem)
  
  
  # Filtramos los datos donde no conocemos la distancia de la órbita
  
  Seleccion <- filter(Seleccion,(as.numeric(as.character(Planet.SemiMajor.Axis)) != 0))
  
  # Ahora ordenamos los datos por StarName y por Planet.SemiMajor.Axis
  
  Seleccion <- arrange(Seleccion,StarName,Planet.SemiMajor.Axis) # No es necesario incluir as.numeric y as.character???
  
  # Ahora agrupamos por nombre de Estrella y trasponemos la columna con los datos de los semiejes
  
  Seleccion <- Seleccion %>% 
    group_by(StarName,NumberOfPlanetsInSystem) %>% 
    do (Distancias = t(as.numeric(as.character(.$Planet.SemiMajor.Axis))))
  
  # ahora se puede graficar cada valor segun el indice con: 
  #Grafico(Seleccion[indice,1][[1]],as.numeric(unlist(Seleccion[indice,][[2]])))

  
  # Añadimos  el sistema solar
  #SistemaSolar <- c("Sol",c("0.39","0.72","1","1.52","5.2","9.58","19.23","30.1"))
  
  NombreEstrella <- "Sol"
  SistemaSolar <- c(0.39,0.72,1,1.52,5.2,9.58,19.23,30.1)
  NumeroPlanetas <- as.character(rep(8))
  
  df <- data.frame(NombreEstrella,SistemaSolar,NumeroPlanetas,stringsAsFactors = FALSE)
  
  
  
  # Ahora agrupamos los planetas del sol
  
  df <- df %>% 
    group_by(NombreEstrella,NumeroPlanetas) %>% 
    do (Distancias = t(as.numeric(as.character( .$SistemaSolar))))
  
  # Y por ultimo nombramos a las columnas igual y lo añado al final de la Seleccion
  colnames(Seleccion) <- colnames(df)
  Seleccion <- bind_rows(Seleccion,df)

  # ahora se puede graficar cada valor segun el indice con: 
  #  Grafico(Datos$NombreEstrella[indice], Datos$NumeroPlanetas[indice], as.numeric(unlist(Datos$Distancias [indice])))
  
  return(Seleccion)
  
}

