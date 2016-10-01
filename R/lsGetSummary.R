#' Function for getting survey summary
#' todo: documentation
#' @export
#'
#'



lsGetSummary = function(lsAPIurl,
                        sessionKey,
                        surveyID,
                        usageStats = TRUE
                        ){

    if (missing(lsAPIurl))
        stop("Need to specify LimeSurvey API URL (lsAPIurl).")

    if (missing(sessionKey))
        stop("Need to specify session key (sessionKey). Use lsSessionKey function.")

    if (missing(surveyID))
        stop("Need to specify surveyID.")


    # setting parameters for API call

        method = "get_summary"
        params = list(sSessionKey = sessionKey,
                      iSurveyID = surveyID,
                      sStatName = 'all')



    data = lsAPI(lsAPIurl, method = method, params)

    # monitoring usage of the function
    lsAddPackageStats(functionName = "lsGetSummary",
                      functionStats = "1",
                      usageStats = usageStats
                      )

    data

}
