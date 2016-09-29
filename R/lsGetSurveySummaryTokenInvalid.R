#' @export

#########################
#lsGetSurveySummaryTokenInvalid
#########################

lsGetSurveySummaryTokenInvalid = function(lsAPIurl,
                          sessionKey,
                          surveyID
                          )
                              
  {
                  lsGetSurveySummary(lsAPIurl,
                          sessionKey,
                          surveyID,
                          statName = 'token_invalid'
                          )
  }
