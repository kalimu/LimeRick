#' @export

#########################
#lsGetSurveySummaryFullResponses
#########################

lsGetSurveySummaryFullResponses = function(lsAPIurl,
                          sessionKey,
                          surveyID
                          )
                              
  {
                  lsGetSurveySummary(lsAPIurl,
                          sessionKey,
                          surveyID,
                          statName = 'full_responses'
                          )
  }
