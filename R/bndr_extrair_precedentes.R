#' Extrai tabela de precedentes
#'
#' @param numero Número do precedente. Opcional.
#' @param tipo Tipo de precedente: IRDR, RR, IAC, GR, CT, RG
#'     Consulte o dataset tipo para conhecer a descrição.
#' @param origem_id Origem do precedente
#' @param situacao_id Situação do precedente.
#'
#' @return tibble
#' @export
#'
bndr_extrair_precedentes <- function(numero = "",
                                     tipo = "",
                                     origem_id = "",
                                     situacao_id = ""){



  origem_descricao <- origem %>%
    dplyr::filter(id == origem_id) %>%
    dplyr::pull("descricao")

  origem_codigo_res_65 <- origem %>%
    dplyr::filter(id == origem_id) %>%
    dplyr::pull("codigo_res_65")

  situacao_descricao <- situacao %>%
    dplyr::filter(id == situacao_id) %>%
    dplyr::pull("descricao")

  if (rlang::is_empty(situacao_descricao)) situacao_descricao <- ""


  situacao_sigla <- situacao %>%
    dplyr::filter(id == situacao_id) %>%
    dplyr::pull("sigla")

  if (rlang::is_empty(situacao_sigla)) situacao_sigla <- ""



  url <- "https://www.cnj.jus.br/bnpr-web/rest/precedentes"

  pagina <- 1

  body <-
    list(
      numero = numero,
      tipo = tipo,
      origem = list(
        id = origem_id,
        descricao = origem_descricao,
        codigoRes65 = origem_codigo_res_65
      ),
      situacao= list(
        id = situacao_id,
        sigla = situacao_sigla,
        descricao = situacao_descricao
      ),
      pagina = pagina
    )

  if (situacao_id == ""){

  body$situacao <- NULL

  }
  resposta <- httr::POST(url, body = body, encode = "json",
                         httr::accept_json())

  conteudo <- resposta %>%
    httr::content("text") %>%
    jsonlite::fromJSON()


  df <- conteudo$conteudo

  paginas <- conteudo$totalPaginas

  if (paginas> 1){
    db <- purrr::map_dfr(2:paginas,purrr::possibly(~{

      body$pagina <- .x


      resposta <- httr::POST(url, body = body, encode = "json",
                             httr::accept_json())

      conteudo <- resposta %>%
        httr::content("text") %>%
        jsonlite::fromJSON()


      conteudo$conteudo

    },NULL))

    df <- dplyr::bind_rows(df,db)
  }

  return(df)

}
