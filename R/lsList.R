#' Function for listing surveys, groups or questions
#' todo: documentation
#' @export
#'
#'



lsList = function(lsAPIurl,
                  sessionKey,
                  action = "surveys",
                  surveyID = NULL
                  ){

    if (missing(lsAPIurl))
        stop("Need to specify LimeSurvey API URL (lsAPIurl).")
    if (missing(sessionKey))
        stop("Need to specify session key (sessionKey). Use lsSessionKey function.")

    if (!action %in% c("surveys", "groups", "questions"))
        stop("Wrong action parameter. Available are: 'surveys', 'groups', 'questions'.")

    # setting parameters for API call

    if (action == "surveys") {

        params = list(sSessionKey = sessionKey)
        method = "list_surveys"

    } else {

        if (is.null(surveyID))
            stop("Need to specify surveyID.")

        params = list(sSessionKey = sessionKey,
                      iSurveyID = surveyID)

    }

    if (action == "groups") { method = "list_groups" }

    if (action == "questions") { method = "list_questions" }

    data = lsAPI(lsAPIurl, method = method, params)

    data

}
