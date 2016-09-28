#' Function for getting survey summary
#' todo: documentation
#' @export
#'
#'



lsGetSummary = function(lsAPIurl,
                        sessionKey,
                        surveyID
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

    data

}
