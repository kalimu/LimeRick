#' @export

#########################
#lsGetSurveySummaryTokenCount
#########################

lsGetSurveySummaryTokenCount = function(lsAPIurl,
                          sessionKey,
                          surveyID
                          )
                              
  {
                  lsGetSurveySummary(lsAPIurl,
                          sessionKey,
                          surveyID,
                          statName = 'token_count'
                          )
  }
