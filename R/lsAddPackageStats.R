#' Function for adding new stats of using package functions
#' todo: documentation
#' @export
#'
#'



lsAddPackageStats = function(packageName = "limeRick",
                             packageVer = NULL,
                             functionName,
                             functionStats,
                             usageStats = TRUE
                             ){

    if (usageStats == FALSE) {

        message('Sending usage statistics for function ',
                functionName, ' is disabled.\n')

        return(NULL)

    }

    lsAPIurl = 'http://odgar.net/survey/index.php/admin/remotecontrol'
    user = "RStats"
    pass = "45hadfjHPOout5tg"
    surveyID = 456716
    sessionKey = lsSessionKey(lsAPIurl,
                              "get",
                              user = user,
                              pass = pass
                              )

    if (is.null(packageVer)) {

        packageVer = as.character(packageVersion(packageName))

    }

    response = list('456716X3X22' = packageName,
                    '456716X3X25' = packageVer,
                    '456716X3X23' = as.character(functionName),
                    '456716X3X24' = as.character(functionStats)
                    )

    #lsAddResponse(LimeSurveyAPI, sessionKey, surveyID, response)

    method = "add_response"
    params = list(sSessionKey = sessionKey,
                  iSurveyID = surveyID,
                  aParticipantData = response
                  )


    lsAPI(lsAPIurl, method = method, params)

    lsSessionKey(lsAPIurl, action = "release")

}
