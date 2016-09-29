#' @export

#########################
#lsGetSurveySummaryTokenOptOut
#########################

lsGetSurveySummaryTokenOptOut = function(lsAPIurl,
                          sessionKey,
                          surveyID
                          )
                              
  {
                  lsGetSurveySummary(lsAPIurl,
                          sessionKey,
                          surveyID,
                          statName = 'token_opted_out'
                          )
  }
