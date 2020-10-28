#' \code{bndr} package
#'
#' Baixa  e organiza informações sobre incidentes de demandas repetitivas
#'
#'
#' @docType package
#' @name bndr
NULL

## quiets concerns of R CMD check re: the .'s that appear in pipelines
if (getRversion() >= "2.15.1") {
  utils::globalVariables(c("origem","id","situacao"))
}
