library(tidyverse)
library(ggplot2)
library(solitude)
library(readr)

dados_historico <- read_csv("./dados_historicos.csv")
#view(dados_historico)

#Aprendizado não supervisionado, usando o random Forest

?isolationForest # chama o objeto isolationForest

modelo_ml_historico = isolationForest$new()

modelo_ml_historico$fit(dados_historico)

# Previsões do modelo
previsoes_historico = dados_historico %>%
    modelo_ml_historico$predict() %>%
    arrange(desc(anomaly_score))

#densidade plot 
#plot(density(previsoes_historico$anomaly_score))

indices_historico = previsoes_historico[which(previsoes_historico$anomaly_score > 0.63)] 

anomalias_historico = dados_historico[indices_historico$id,]
normais_historico = dados_historico[-indices_historico$id,]

colors()
ggplot() +
    geom_point(data = normais_historico,
        mapping = aes(transacao1,transacao2),
        col = "#8a87eb",
        alpha =0.5 ) +
    geom_point(data = anomalias_historico,
         mapping = aes(transacao1,transacao2),
        col= "#d72929",
        alpha = 0.8)

novos_dados <- read.csv("./novos_dados.csv")
view(novos_dados)

previsoes_novos_dados = modelo_ml_historico$predict(novos_dados)

indices_novos_dados = previsoes_novos_dados[which(previsoes_novos_dados$anomaly_score > 0.63)]

anomalias_novas_historico = novos_dados[indices_novos_dados$id,]
normais_novas_historico = novos_dados[-indices_novos_dados$id,]

ggplot() +
    geom_point(data = normais_novas_historico,
        mapping = aes(transacao1,transacao2),
        col = "#8a87eb",
        alpha =0.5 ) +
    geom_point(data = anomalias_novas_historico,
         mapping = aes(transacao1,transacao2),
        col= "#d72929",
        alpha = 0.8) +
    labs(title = "Anomalias detectadas nos novos dados",
         x = "Transação 1",
         y = "Transação 2")

previsoes_novos_dados <- previsoes_novos_dados %>%
    mutate(anomaly_score = round(anomaly_score, 2))
view(previsoes_novos_dados)

previsoes_novos_dados <- previsoes_novos_dados %>%
    mutate(status= ifelse(anomaly_score > 0.63, "Anomalia", "Normal"))
view(previsoes_novos_dados)

write.csv(previsoes_novos_dados, "./previsoes_novos_dados.csv")