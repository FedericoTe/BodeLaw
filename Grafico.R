###########################################################################
#
#           Funcion para hacer un grafico que represente la ley de Titius-Bode
#
#          Eje X el orden del planeta
# 
#          Eje Y la distancia a la estrella en U.A.
#
#   Llamando a la funcion con
#   Grafico(Seleccion$NombreEstrella[indice], Seleccion$NumeroPlanetas[indice], 
#           as.numeric(unlist(Seleccion$Distancias [indice])))
#
#
#  Como ejemplo, los valores de indice = 66, el sistema solar, son:
#
#   > Seleccion[66,]
#     # A tibble: 1 x 3
#     NombreEstrella NumeroPlanetas    Distancias
#             <chr>          <chr>        <list>
#   1          Sol            8       <dbl [1 x 8]>
#
#   > Seleccion$Distancias[66]
#   [[1]]
#         [,1] [,2] [,3] [,4] [,5] [,6]  [,7] [,8]
#   [1,] 0.39 0.72    1 1.52  5.2 9.58 19.23 30.1
#
#########################################################################


Grafico <- function(NombreEstrella,CuantosPlanetas,DatosY){
  
  
  DatosX <- seq_len(length(DatosY))
  LimiteEjeY <- max(DatosY)
  
  plot(DatosX,DatosY,type = 'p',
       xlab = paste (CuantosPlanetas, " planetas en el sistema estelar"),
       ylab = "Distancia a la estrella en U.A." ,
       ylim = c(0,LimiteEjeY))
  
  # Titulo <- "Ley de Titius-Bode"
  Titulo <- paste("Sistema estelar", NombreEstrella)
  #Subtitulo <- paste("Sistema de la estrella ",NombreEstrella)
  
  #title(Titulo, cex.main = 2,   font.main= 4, col.main= "blue",
        #sub = Subtitulo, cex.sub = 1.25, font.sub = 2, col.sub = "red",
        #outer = FALSE)
  title(Titulo, cex.main = 1.5,   font.main= 4, col.main= "blue", outer = FALSE)
  
}

#############################################
#
#   POR HACER
#
#   Añadir al grafico los valores teoricos segun la ley de Bode
#   se me ocurre en forma de gráfica a rayas con otro color
#
############################################


