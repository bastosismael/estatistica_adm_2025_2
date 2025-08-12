x11()

vertices = list(
  A = c(0, 0),
  B = c(1, 0),
  C = c(0.5, 1)
)

# Inicializa ponto
ponto = c(0.3, 0.6)

# Lista para armazenar todos os pontos desenhados
todos_pontos = list(ponto)

while (TRUE) {
  # Escolhe um vértice
  ponto_destino_nome = sample(names(vertices), 1)
  destino = vertices[[ponto_destino_nome]]
  
  # Mostra qual foi
  cat("Vértice escolhido:", ponto_destino_nome, "\n")
  
  # Redesenha o gráfico todo com linha temporária
  plot(NULL, xlim = c(0, 1), ylim = c(0, 1), asp = 1,
       xlab = "", ylab = "", main = "Jogo Caótico")
  
  # Desenha vértices
  points(vertices$A[1], vertices$A[2], col = "red", pch = 19)
  points(vertices$B[1], vertices$B[2], col = "red", pch = 19)
  points(vertices$C[1], vertices$C[2], col = "red", pch = 19)
  
  # Desenha pontos anteriores
  for (pt in todos_pontos) {
    points(pt[1], pt[2], col = "blue", pch = 19, cex = 0.3)
  }
  
  # Desenha segmento temporário
  segments(ponto[1], ponto[2], destino[1], destino[2], col = "gray", lwd = 2)
  ponto = (ponto + destino) / 2
  readline("Tomando ponto médio do segmento ")
  points(ponto[1], ponto[2], col = "blue", pch = 19, cex = 0.3)
  
  # Espera ENTER
  readline("Gerar novo ponto")
  
  # Atualiza lista de pontos
  todos_pontos[[length(todos_pontos) + 1]] = ponto
}
