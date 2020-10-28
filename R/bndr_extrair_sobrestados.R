#' Extrair processos sobrestados
#'
#' @param id Id do incidente
#'
#' @return tibble
#' @export
#'
bndr_extrair_sobrestados <- function(id){

  pb <- progress::progress_bar$new(total = length(id))

  uri <- "https://www.cnj.jus.br/bnpr-web/rest/precedentes/download/"


  purrr::map_dfr(id, purrr::possibly(~{

    pb$tick()

    url <- paste0(uri,.x,"/SOBRESTADO")

    sobrestados <- readLines(url)

    tibble::tibble(id = .x, sobrestado = sobrestados)


  },NULL))

}
