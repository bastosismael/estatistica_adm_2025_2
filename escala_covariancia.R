require(lubridate)
require(ggplot2)
library(dplyr)

dados = read.csv(file.choose())
dados_brasil = dados[dados$Country == "Brazil",]
dados_brasil = dados_brasil[complete.cases(dados_brasil),]
dados_brasil$dt = ymd(dados_brasil$dt)
dados_brasil_1980 = dados_brasil[dados_brasil$dt >= ymd("1980-01-01"), ]
dados_brasil_1980$umidade = sample(seq(60, 99), nrow(dados_brasil_1980), replace=TRUE)



# Temperatura em Celsius
p <- ggplot(dados_brasil_1980, aes(x=dt, y=AverageTemperature)) +
  geom_line() + 
  xlab("")
p
plot(dados_brasil_1980$umidade,  dados_brasil_1980$AverageTemperature)
cat("Covariancia: ", cov(dados_brasil_1980$umidade, dados_brasil_1980$AverageTemperature))
cat("Coeficiente de correlacao: ", cor(dados_brasil_1980$umidade, dados_brasil_1980$AverageTemperature))

# Temperatura estivesse em Farenheit
dados_brasil_1980$temperatura_farenheit = (9*dados_brasil_1980$AverageTemperature + 160)/5
plot(dados_brasil_1980$umidade,  dados_brasil_1980$temperatura_farenheit)
p <- ggplot(dados_brasil_1980, aes(x=dt, y=temperatura_farenheit)) +
  geom_line() + 
  xlab("")
p
cat("Covariancia: ", cov(dados_brasil_1980$umidade, dados_brasil_1980$temperatura_farenheit))
cat("Coeficiente de correlacao: ", cor(dados_brasil_1980$umidade, dados_brasil_1980$temperatura_farenheit))
