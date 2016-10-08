#' Function for adding new responses to the survey
#' todo: documentation
#' @export
#'
#'



lsAddResponse = function(surveyID,
                         response,
                         lsAPIurl = getOption("lsAPIurl"),
                         sessionKey = NULL,
                         usageStats = getOption("LimeRickStats")
                         ){

    if (is.null(lsAPIurl))
         stop("Need to specify LimeSurvey API URL (lsAPIurl). \nYou can do it once by options(lsAPIurl = 'your_api_url').")

    if (is.null(sessionKey)) { sessionKey = lsSessionCache$sessionKey }

    if (is.null(sessionKey))
        stop("Need to have a session key. Use lsSessionKey('get') function.")

    if (missing(surveyID))
        stop("Need to specify surveyID.")

    if (missing(response))
        stop("Need to specify new responses to the survey questions.")

    if (!is.list(response))
        stop("New response must be a list.")

    # setting parameters for API call

    method = "add_response"
    params = list(sSessionKey = sessionKey,
                  iSurveyID = surveyID,
                  aParticipantData = response
                  )


    data = lsAPI(method = method,
                 params = params,
                 lsAPIurl = lsAPIurl)


    lsAddPackageStats(functionName = "lsAddResponse",
                      functionStats = NROW(response),
                      usageStats = usageStats
                      )



    data

}
