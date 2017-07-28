###########################################################################
#
#           Funcion para hacer un grafico que represente la ley de Titius-Bode
#
#          Eje X el orden del planeta
# 
#           Eje Y la distancia a la estrella en U.A.
#
#
#########################################################################


Grafico <- function(NombreEstrella,DatosY){
  
  DatosX <- seq.int(from = 1, to = length(DatosY),by = 1)
  plot(DatosX,DatosY,type = 'p',
       xlab = "Planetas del sistema",
       ylab = "Distancia a la estrella en U.A.", 
       ylim = c(0,max(DatosY)))
  
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
