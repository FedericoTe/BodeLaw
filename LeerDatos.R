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
#########################################################################


# Para usar las funciones select(), filter() y group_by() del paquete dplyr
library(dplyr) 


LeerDatos <- function(Enlace){
  
  
  direccion <- Enlace
  
  
  Cabecera <- c("StarName","StarMass","RadiusMass","NumberOfPlanetsInSystem","PlanetName","OrbitalPeriod-Days","Planet-SemiMajor-Axis","Planet-Eccentricity","Ratio-Distance-StellarRadius")
  planetas <- read.csv(direccion, sep =',',header = FALSE, col.names = Cabecera, stringsAsFactors = FALSE)
  
  
  # Seleccionamos los datos relevantes que están por columnas:
  Seleccion <- select(planetas,StarName,Planet.SemiMajor.Axis)
  
  #########################
  # En la Seleccion que hacemos abajo hay algun error. Revisarlo posteriormente.
  ###########################
  
  #Seleccionamos aquellos sistemas donde tenemos como mínimo cuatro planetas 
  
  Seleccion <- Seleccion[as.numeric(planetas$NumberOfPlanetsInSystem)>3,]
  
  # Filtramos los datos donde no conocemos la distancia de la órbita
  
  Seleccion <- filter(Seleccion,(as.numeric(as.character(Planet.SemiMajor.Axis)) != 0))
  
  # Ahora ordenamos los datos por StarName y por Planet.SemiMajor.Axis
  
  Seleccion <- arrange(Seleccion,StarName,Planet.SemiMajor.Axis) # Incluir as.numeric y as.character???
  
  # Ahora agrupamos por nombre de Estrella y trasponemos la columna con los datos de los semiejes
  
  Seleccion <- Seleccion %>% 
    group_by(StarName) %>% 
    do (Distancias = t(as.numeric(as.character(.$Planet.SemiMajor.Axis))))
  
  # ahora se puede graficar cada valor segun el indice con: 
  #Grafico(Seleccion[indice,1][[1]],as.numeric(unlist(Seleccion[indice,][[2]])))

  
  # Añadimos  el sistema solar
  #SistemaSolar <- c("Sol",c("0.39","0.72","1","1.52","5.2","9.58","19.23","30.1"))
  
  SistemaSolar <- c(0.39,0.72,1,1.52,5.2,9.58,19.23,30.1)
  
  df <- data.frame("Sol",SistemaSolar,stringsAsFactors = FALSE)
  
  
  
  # Ahora agrupamos los planetas del sol
  
  df <- df %>% 
    group_by(X.Sol.) %>% 
    do (Distancias = t(as.numeric(as.character( .$SistemaSolar))))
  
  # Y por ultimo nombramos a las columnas igual y lo añado al final de la Seleccion
  colnames(df) <- colnames(Seleccion)
  Seleccion <- bind_rows(Seleccion,df)

  # ahora se puede graficar cada valor segun el indice con: 
  #Grafico(Seleccion[indice,1][[1]],as.numeric(unlist(Seleccion[indice,][[2]])))
  
  return(Seleccion)
  
}


