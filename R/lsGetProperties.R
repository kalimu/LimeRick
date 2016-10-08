#' Function for getting question or survey properties
#' todo: documentation
#' @export
#'
#'



lsGetProperties = function(action = "survey",
                           surveyID = NULL,
                           questionID = NULL,
                           languageCode = "en",
                           lsAPIurl = getOption("lsAPIurl"),
                           sessionKey = NULL,
                           usageStats = getOption("LimeRickStats")
                           ){


    if (is.null(lsAPIurl))
         stop("Need to specify LimeSurvey API URL (lsAPIurl). \nYou can do it once by options(lsAPIurl = 'your_api_url').")

    if (is.null(sessionKey)) { sessionKey = lsSessionCache$sessionKey }

    if (is.null(sessionKey))
        stop("Need to have a session key. Use lsSessionKey('get') function.")

    if (!action %in% c("survey", "question"))
        stop("Wrong action parameter. Available are: 'survey', 'question'.")

    # setting parameters for API call
    if (action == "survey") {

        if (is.null(surveyID))
            stop("Need to specify surveyID.")

        method = "get_survey_properties"
        params = list(sSessionKey = sessionKey,
                      iSurveyID = surveyID,
                      aSurveySettings = list('sid', 'owner_id', 'admin', 'active', 'expires', 'startdate', 'adminemail', 'anonymized', 'faxto', 'format', 'savetimings', 'template', 'language', 'additional_lanuages','datestamp', 'usecookie', 'allowregister', 'allowsave', 'autonumber_start', 'autoredirect', 'allowprev', 'printanswers','ipaddr', 'refurl', 'datecreated', 'publicstatistics', 'publicgraphs', 'listpublic', 'htmlemail', 'sendconfirmation', 'tokenanswerpersistence', 'assessments', 'usecaptcha', 'usetokens', 'bounce_email', 'attributedescriptions', 'emailresponseto', 'emailnotificationto', 'tokenlength', 'showxquestions', 'showgroupinfo', 'shownoanswer', 'showqnumcode', 'bouncetime', 'bounceprocessing', 'bounceaccounttype', 'bounceaccounthost', 'bounceaccountpass', 'bounceaccountencrption', 'bounceaccountuser', 'showwelcome', 'showprogress', 'questionindex', 'navigationdelay', 'nokeyboard', 'alloweditaftercompletion', 'googleanalyticsstyle', 'googleanalyticsapikey'))

    }

    if (action == "question") {

        if (is.null(questionID))
            stop("Need to specify questionID.")

        method = "get_question_properties"
        params = list(sSessionKey = sessionKey,
                      iQuestionID = as.character(questionID),
                      aQuestionSettings = list("available_answers","subquestions","attributes","attributes_lang","answeroptions","defaultvalue", "qid", "parent_qid", "sid", "gid", "type", "question", "preg", "help", "other", "mandatory", "question_order", "language", "scale_id", "same_default", "relevance", "modulename"),
                      sLanguageCode = languageCode)

    }


    data = lsAPI(method = method,
                 params = params,
                 lsAPIurl = lsAPIurl)

    # monitoring usage of the function
    lsAddPackageStats(functionName = "lsGetProperties",
                      functionStats = action,
                      usageStats = usageStats
                      )

    data

}
