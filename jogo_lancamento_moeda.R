library(shiny)
library(bslib)
library(later)

ui <- fluidPage(
  theme = bs_theme(bootswatch = "minty"),
  titlePanel("Lançamento de Moeda - R$1"),
  sidebarLayout(
    sidebarPanel(
      actionButton("lancar", "🪙 Lançar Moeda", class = "btn-primary btn-lg"),
      br(), br(),
      textOutput("mensagem")
    ),
    mainPanel(
      imageOutput("imagem_moeda", height = "300px")
    )
  )
)

server <- function(input, output, session) {
  # Variável para controlar a rodada
  rodada <- reactiveVal(1)
  
  # Resultados fixos para as primeiras 4 rodadas
  resultados_fixos <- c("cara", "coroa", "coroa", "cara")
  
  resultado <- reactiveVal(NULL)
  mostrando_resultado <- reactiveVal(FALSE)
  
  observeEvent(input$lancar, {
    rodada_atual <- rodada()
    
    # Reseta a variável de controle antes de cada lançamento
    mostrando_resultado(FALSE)
    
    # Define o resultado da rodada com base na rodada atual
    if (rodada_atual <= 4) {
      res <- resultados_fixos[rodada_atual]
    } else {
      res <- sample(c("cara", "coroa"), 1)
    }
    
    resultado(res)
    rodada(rodada_atual + 1)  # Incrementa a rodada
    
    # Mostra o gif da moeda girando
    output$imagem_moeda <- renderImage({
      list(
        src = "/home/ismael/Documents/estatistica_eng_quimica/figures/coin_toss_movies.gif",
        contentType = "image/gif",
        alt = "Moeda girando"
      )
    }, deleteFile = FALSE)
    
    # Espera 2.5 segundos e então mostra o resultado
    later::later(function() {
      output$imagem_moeda <- renderImage({
        imagem_arquivo <- if (res == "cara") "/home/ismael/Documents/estatistica_eng_quimica/figures/cara.png" else "/home/ismael/Documents/estatistica_eng_quimica/figures/coroa.png"
        list(
          src = imagem_arquivo,
          contentType = "image/png",
          alt = paste("Resultado:", res)
        )
      }, deleteFile = FALSE)
      
      # Agora que a imagem foi trocada, mostra o resultado no texto
      mostrando_resultado(TRUE)
    }, delay = 2.5)
  })
  
  output$mensagem <- renderText({
    if (!mostrando_resultado()) {
      "Clique no botão para lançar a moeda!"
    } else {
      paste("Resultado:", toupper(resultado()))
    }
  })
}

# Rode o app
shinyApp(ui, server)
