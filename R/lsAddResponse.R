#' Function for adding new responses to the survey
#' todo: documentation
#' @export
#'
#'



lsAddResponse = function(lsAPIurl,
                          sessionKey,
                          surveyID,
                          response
                          ){

    if (missing(lsAPIurl))
        stop("Need to specify LimeSurvey API URL (lsAPIurl).")

    if (missing(sessionKey))
        stop("Need to specify session key (sessionKey). Use lsSessionKey function.")

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


    data = lsAPI(lsAPIurl, method = method, params)

    data

}
