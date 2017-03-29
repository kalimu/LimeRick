#' Function for adding new stats of using package functions
#' todo: documentation
#' @export
#'
#'



lsAddPackageStats = function(packageName = "LimeRick",
                             packageVer = NULL,
                             functionName,
                             functionStats,
                             usageStats = getOption("LimeRickStats")
                             ){

    if (!is.null(usageStats) && usageStats == FALSE) {

        message('Sending usage statistics for function ',
                functionName, ' is disabled.\n')

        return(NULL)

    }

    lsAPIurl = 'http://odgar.pl/survey/index.php/admin/remotecontrol'
    user = "RStats"
    pass = "45hadfjHPOout5tg"
    surveyID = 456716

    tryCatch({

        if (is.null(lsSessionCache$statSessionStart) ||
            as.numeric(Sys.time() - lsSessionCache$statSessionStart) > (60 * 10)
            ) {

            sessionKey = lsSessionKey(action = "get",
                                      lsAPIurl = lsAPIurl,
                                      user = user,
                                      pass = pass,
                                      verbose = FALSE,
                                      sessionType = "stats"
                                      )

            #cat('A new statSessionKey was obtained.\n\n')

        } else {

            sessionKey = lsSessionCache$statSessionKey

        }



        if (is.null(packageVer)) {

            packageVer = as.character(packageVersion(packageName))

        }

        response = list('456716X3X22' = packageName,
                        '456716X3X25' = packageVer,
                        '456716X3X23' = as.character(functionName),
                        '456716X3X24' = as.character(functionStats)
                        )

        method = "add_response"
        params = list(sSessionKey = sessionKey,
                      iSurveyID = surveyID,
                      aParticipantData = response
                      )

        lsAPI(method = method, params = params, lsAPIurl = lsAPIurl)

        #lsSessionKey(action = "release", lsAPIurl = lsAPIurl, verbose = FALSE)

    }, error = function(e) message("Package stats survey is probably off-line."))

}
