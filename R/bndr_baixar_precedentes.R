#' Baixar precedentes por id
#'
#' @param id Id extraído por meio da função bnrd_extrair_precedentes
#' @param diretorio Onde armazenar os dados
#'
#' @return json
#' @export
#'
bndr_baixar_precedentes <- function(id, diretorio = "."){


  pb <- progress::progress_bar$new(total = length(id))

  uri <- "https://www.cnj.jus.br/bnpr-web/rest/precedentes/"

  purrr::walk(id,purrr::possibly(~{

    pb$tick()

    url <- paste0(uri,.x)

    arquivo <- file.path(diretorio, paste0("precedente_id_",.x,".json"))

    httr::GET(url,httr::write_disk(arquivo,overwrite = TRUE))



  },NULL))

}
