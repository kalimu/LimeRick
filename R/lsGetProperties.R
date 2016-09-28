#' Function for getting question or survey properties
#' todo: documentation
#' @export
#'
#'



lsGetProperties = function(lsAPIurl,
                           sessionKey,
                           action = "survey",
                           surveyID = NULL,
                           questionID = NULL,
                           languageCode = "en"
                           ){

    if (missing(lsAPIurl))
        stop("Need to specify LimeSurvey API URL (lsAPIurl).")

    if (missing(sessionKey))
        stop("Need to specify session key (sessionKey). Use lsSessionKey function.")

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
                      iQuestionID = questionID,
                      aQuestionSettings = list("available_answers","subquestions","attributes","attributes_lang","answeroptions","defaultvalue", "qid", "parent_qid", "sid", "gid", "type", "question", "preg", "help", "other", "mandatory", "question_order", "language", "scale_id", "same_default", "relevance", "modulename"),
                      sLanguageCode = languageCode)

    }


    data = lsAPI(lsAPIurl, method = method, params)

    data

}
