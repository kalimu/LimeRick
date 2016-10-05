#' @export

#########################
#lsGetSurveySummary
#private
#########################

lsGetSurveySummary = function(lsAPIurl,
                          sessionKey,
                          surveyID,
                          statName # = 'all'
                             ){

    params = list(sSessionKey = sessionKey,
                  iSurveyID = surveyID,
                  sStatName = statName
                  )

    data = lsAPI(lsAPIurl, method = "get_summary", params)

    data = rawToChar(base64enc::base64decode(data))

    if (statName=="all") 
        {
        df = read.csv(textConnection(data),
             encoding = "UTF-8",
             stringsAsFactors = FALSE)
        df
        }
    else
        {
    data
        }
  
}
