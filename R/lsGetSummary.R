#' Function for getting survey summary
#' todo: documentation
#' @export
#'
#'



lsGetSummary = function(surveyID,
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


    # setting parameters for API call

        method = "get_summary"
        params = list(sSessionKey = sessionKey,
                      iSurveyID = surveyID,
                      sStatName = 'all')



    data = lsAPI(method = method,
                 params = params,
                 lsAPIurl = lsAPIurl)

    # monitoring usage of the function
    lsAddPackageStats(functionName = "lsGetSummary",
                      functionStats = "1",
                      usageStats = usageStats
                      )

    data

}
