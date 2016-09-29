#' @export

#########################
#lsGetSurveyProperties
#########################

lsGetSurveyProperties = function(lsAPIurl,
                          sessionKey,
                          surveyID,
                          surveySettings #mandatory option

#settings option not known disclosed by API
                                 
                             ){

    params = list(sSessionKey = sessionKey,
                  iSurveyID = surveyID,
                  aSurveySettings = surveySettings
                  )

    data = lsAPI(lsAPIurl, method = "get_survey_properties", params)

    data = rawToChar(base64enc::base64decode(data))

    df = read.csv(textConnection(data),
             encoding = "UTF-8",
             stringsAsFactors = FALSE)
  
    df
}
