


.onAttach <- function(libname, pkgname) {

    packageStartupMessage(paste0('\nWelcome to LimeRick package version: ',
                                 utils::packageVersion("LimeRick")))

    packageStartupMessage("\nHomepage: http://www.wais.kamil.rzeszow.pl/LimeRick")

    packageStartupMessage("\nChangelog: news(package = 'LimeRick')")
    packageStartupMessage("Package help: help(LimeRick)")

    packageStartupMessage("\nIf you find this package useful cite it please. Thank you! ")
    packageStartupMessage("See: citation('LimeRick')")

    packageStartupMessage("\nTo suppress this message use:\nsuppressPackageStartupMessages(library(LimeRick))")

    packageStartupMessage('\nFirst you need to set login parameters and obtain a session key. \nSee the lsSessionKey() function help page (?lsSessionKey).\n')

}

#' Bridge between LimeSurvey and R
#'
#' The \code{LimeRick} package ...todo...
#'
#' If you need help with your research or commercial projects,
#' feel free to contat me via my homepage contact form:
#' \url{http://www.wais.kamil.rzeszow.pl}.

#'
#' @docType package
#'
#' @name LimeRick
#'
#'

# @importFrom magrittr "%>%"
# @import utils

#' @seealso
#' \itemize{
#   \item \url{http://www.wais.kamil.rzeszow.pl/LimeRick} [R package homepage]
#'   \item \url{https://github.com/kalimu/LimeRick} [source code of the latest development version of the R package]
#'   \item \url{http://limesurvey.org} [LimeSurvey homepage]
#' }
#'

# Setting a new environment to hold the session parameters.
    # Based on https://github.com/cloudyr/limer/blob/master/R/get_session_key.R

    lsSessionCache <- new.env(parent = emptyenv())
    lsSessionCache$check <- "OK"

NULL


# detach("package:LimeRick", unload=TRUE)
# devtools::show_news()
