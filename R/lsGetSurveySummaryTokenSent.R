#' @export

#########################
#lsGetSurveySummaryTokenSent
#########################

lsGetSurveySummaryTokenSent = function(lsAPIurl,
                          sessionKey,
                          surveyID
                          )
                              
  {
                  lsGetSurveySummary(lsAPIurl,
                          sessionKey,
                          surveyID,
                          statName = 'token_sent'
                          )
  }
