###########################################################################
#
#           Funcion para hacer un grafico que represente la ley de Titius-Bode
#
#          Eje X el orden del planeta
# 
#           Eje Y la distancia a la estrella en U.A.
#
#   Llamando a la funcion con
#   #Grafico(Seleccion[indice,1][[1]],as.numeric(unlist(Seleccion[indice,][[2]])))
#   Se grafica bien siendo Seleccion el return de la funcion LeerDatos.R
#
#  La estructura de Seleccion es: str(Seleccion)
#  Classes ‘rowwise_df’, ‘tbl_df’, ‘tbl’ and 'data.frame':	66 obs. of  2 variables:
#     $ StarName  : chr  "55 Cnc" "GJ 3293" "GJ 667 C" "GJ 676 A" ...
#     $ Distancias:List of 66
#
#   Y tail(Seleccion)
#
#    # A tibble: 6 x 2
#     StarName    Distancias
#     <chr>        <list>
#  1  Kepler-85 <dbl [1 x 2]>
#  2    KOI-351 <dbl [1 x 7]>
#  3     KOI-94 <dbl [1 x 4]>
#  4 TRAPPIST-1 <dbl [1 x 6]>
#  5    WASP-47 <dbl [1 x 4]>
#  6        Sol     <dbl [8]>
#
# Y los valores del elemento 66 son:
#     > Seleccion[66,][[1]]
#     [1] "Sol"
#     > Seleccion[66,][[2]]
#     [[1]]
#     [1]  0.39  0.72  1.00  1.52  5.20  9.58 19.23 30.10
#
#
#
#########################################################################


Grafico <- function(NombreEstrella,DatosY){
  
  
  DatosX <- seq_len(length(DatosY))
  LimiteEjeY <- max(DatosY)
  
  plot(DatosX,DatosY,type = 'p',
       xlab = "Planetas del sistema",
       ylab = "Distancia a la estrella en U.A." ,
       ylim = c(0,LimiteEjeY))
  
  Subtitulo <- paste("Sistema de la estrella ",NombreEstrella)
  
  title("Ley de Titius-Bode", cex.main = 2,   font.main= 4, col.main= "blue",
        sub = Subtitulo, cex.sub = 1.25, font.sub = 2, col.sub = "red",
        outer = FALSE)
  
}

#############################################
#
#   POR HACER
#
#   Añadir al grafico los valores teoricos segun la ley de Bode
#   se me ocurre en forma de gráfica a rayas con otro color
#
############################################


