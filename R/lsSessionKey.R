#' Function getting and releasing LimeSurvey API session key
#' todo: documentation
#' @export
#'
#'




lsSessionKey = function(action = "set",
                        lsAPIurl = getOption("lsAPIurl"),
                        user = getOption("lsUser"),
                        pass = getOption("lsPass"),
                        verbose = TRUE,
                        sessionType = "global"
                        ){

    if (verbose == TRUE)
        cat('Connecting to:', lsAPIurl, '\n')

    if (action == "release") {

        if (verbose == TRUE)
            cat('Releasing session key...\n')

        response = lsAPI(method = "release_session_key",
                         lsAPIurl = lsAPIurl)

        lsSessionCache$sessionKey = NULL

        return(response)

    } else if (action %in% c("get", "set", "obtain")) {

        params = list(admin = user, password = pass)

        if (verbose == TRUE)
            cat('Obtaining session key...\n')

        key = lsAPI(method = "get_session_key", params, lsAPIurl = lsAPIurl)

        if (sessionType == "global") {

            assign("sessionKey", key, envir = lsSessionCache)
            assign("sessionStart", Sys.time(), envir = lsSessionCache)

            return(get("sessionKey", envir = lsSessionCache))

        } else if (sessionType == "stats") {

            assign("statSessionKey", key, envir = lsSessionCache)
            assign("statSessionStart", Sys.time(), envir = lsSessionCache)

            return(get("statSessionKey", envir = lsSessionCache))

        } else {

            return(key)

        }


    }

}


