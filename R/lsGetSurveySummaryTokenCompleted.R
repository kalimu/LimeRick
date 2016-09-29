#' @export

#########################
#lsGetSurveySummaryTokenCompleted
#########################

lsGetSurveySummaryTokenCompleted = function(lsAPIurl,
                          sessionKey,
                          surveyID
                          )
                              
  {
                  lsGetSurveySummary(lsAPIurl,
                          sessionKey,
                          surveyID,
                          statName = 'token_completed'
                          )
  }
