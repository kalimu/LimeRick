#' @export

#########################
#lsGetSurveySummaryCompletedResponses
#########################

lsGetSurveySummaryCompletedResponses = function(lsAPIurl,
                          sessionKey,
                          surveyID
                          )
                              
  {
                  lsGetSurveySummary(lsAPIurl,
                          sessionKey,
                          surveyID,
                          statName = 'completed_responses'
                          )
  }
