
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bndr

<!-- badges: start -->

[![R build
status](https://github.com/jjesusfilho/bndr/workflows/R-CMD-check/badge.svg)](https://github.com/jjesusfilho/bndr/actions)
<!-- badges: end -->

Baixa e organização dados dos incidentes de demandas repetitivas

## Instalação

Para instalá-lo, basta chamar o seguinte código:

``` r
remotes::install_github("jjesusfilho/bndr")
```

## Como usar

A função mais básica chama-se `bndr_extrair_precedentes`. Por ela, você
extrai um dataframe com informações básicas dos precedentes ou
incidentes. Para tanto, você deve informar opcionalmente o número do
precedente, necessariamente o id da origem, o tipo de precedente e
opcionalmente o id da situação do procedente.

Há três datasets no pacote, os quais você pode consultar para saber o id
da origem, o id da situação e a sigla do tipo de precedente.

Por exemplo, se você quiser extrair os dados do IRDR tema 3 to TJSP:

``` r
tema3 <- bndr_extrair_precedentes(numero = 3, tipo ="IRDR", origem_id = 33)
```

Essa função é particularmente útil quando se quer buscar todos os IRDRs,
por exmplo, de um tribunal:

``` r
irdrs <- bndr_extrair_precedentes(tipo = "IRDR", origem_id = 33)
```

A função anterior irá fornecer os ids dos precedentes. Use a função
`bndr_baixar_precedentes` para baixar informações detalhadas dos
precedentes com base no id obtido:

``` r
dir.create("precedentes")
bndr_baixar_precedentes(irdrs$id, diretorio = "precedentes")
```

Para ler os detalhes dados baixados, basta usar a funcão
`bndr_ler_precedentes`:

``` r
detalhes <- bndr_ler_precedentes(diretorio = "precedentes")
```

Caso queira obter os processos sobrestados pelo incidente:

``` r
sobrestados <- bndr_extrair_sobrestados(irdrs$ids)
```
