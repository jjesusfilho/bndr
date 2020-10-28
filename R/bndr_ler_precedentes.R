#' Lê dados sobre precedentes baixados com bndr_baixar_precedentes
#'
#' @param arquivos Vetor de arquivos
#' @param diretorio Informar diretório se arquivos não forem informados
#'
#' @return tibble
#' @export
#'
bndr_ler_precedentes <- function(arquivos = NULL, diretorio = "."){

  if (is.null(arquivos)){

    arquivos <- list.files(diretorio, pattern = "json$", full.names = TRUE)

  }


  pb <- progress::progress_bar$new(total = length(arquivos))

  purrr::map_dfr(arquivos,purrr::possibly(~{

    pb$tick()

    lista <-    jsonlite::fromJSON(.x) %>%
      purrr::map_if(rlang::is_empty,~{.x <- NA_character_})

    nomes <- names(lista)

    lista <-  purrr::map2(lista,nomes,~{

      if (is.list(.x)){

        n <- names(.x)

        names(.x)<- paste0(.y,"_",n)
      }
      .x
    })


    purrr::flatten_dfc(lista)

  },NULL)) %>%
    janitor::clean_names()


}
