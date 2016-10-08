#' Function for getting answer options for the question
#' todo: documentation
#' @export
#'
#'



lsGetAnswerOptions = function(surveyID,
                              questionID,
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

    if (missing(surveyID))
        stop("Need to specify questionID.")

    properties = lsGetProperties('question', surveyID, questionID)

    answerOptionsList = properties$answeroptions

    if (!is.list(answerOptionsList))
        stop("No available answer options for this specific question.")

    nAnswers = NROW(answerOptionsList)
    answerOptionsDF = data.frame(answerCode = character(nAnswers),
                                 answerText = character(nAnswers),
                                 stringsAsFactors = FALSE)

    for (i in 1:nAnswers) {

        answerOptionsDF[i,]$answerCode = names(answerOptionsList[i])
        answerOptionsDF[i,]$answerText = answerOptionsList[[i]]$answer

    }

    # monitoring usage of the function
    lsAddPackageStats(functionName = "lsGetAnswerOptions",
                      functionStats = nAnswers,
                      usageStats = usageStats
                      )

    answerOptionsDF

}
