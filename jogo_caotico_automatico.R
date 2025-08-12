x11()

vertices = list(A = c(0,0), B = c(1,0), C=c(0.5, 1)) 
  
  matrix(c(0, 0,
                     1, 0,
                     0.5, 1), ncol = 2, byrow = TRUE)


# Cria o gráfico
plot(NULL, xlim = c(0, 1), ylim = c(0, 1), asp = 1,
     xlab = "", ylab = "", main = "Jogo caótico")


# Desenha os vértices
points(vertices$A[1], vertices$A[2], col = "red", pch = 19)
points(vertices$B[1], vertices$B[2], col = "red", pch = 19)
points(vertices$C[1], vertices$C[2], col = "red", pch = 19)

#Ponto inicial
ponto <- c(0.3, 0.6)
points(ponto[1], ponto[2], col="blue", pch=19, cex=0.5)

while(TRUE) {
  ponto_destino <- sample(names(vertices), 1)
  cat("Vértice escolhido:", ponto_destino, "\n")
  ponto <- (ponto + vertices[[ponto_destino]]) / 2
  points(ponto[1], ponto[2], col = "blue", pch = 19, cex = 0.5)
  Sys.sleep(0.02)
}

