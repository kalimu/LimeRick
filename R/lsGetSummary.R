#' Function for getting survey summary
#' todo: documentation
#' @export
#'
#'



lsGetSummary = function(lsAPIurl,
                        sessionKey,
                        surveyID,
                        action = "all"
                        ){

    if (missing(lsAPIurl))
        stop("Need to specify LimeSurvey API URL (lsAPIurl).")

    if (missing(sessionKey))
        stop("Need to specify session key (sessionKey). Use lsSessionKey function.")

    if (missing(surveyID))
        stop("Need to specify surveyID.")

    if (!action %in% c("all"))
        stop("Wrong action parameter. Available are: 'all'.")

    # setting parameters for API call

    if (action == "all") {

        method = "get_summary"
        params = list(sSessionKey = sessionKey,
                      iSurveyID = surveyID,
                      sStatName = action)

    }


    data = lsAPI(lsAPIurl, method = method, params)

    data

}
