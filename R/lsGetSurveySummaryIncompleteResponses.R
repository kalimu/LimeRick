#' @export

#########################
#lsGetSurveySummaryIncompleteResponses
#########################

lsGetSurveySummaryIncompleteResponses = function(lsAPIurl,
                          sessionKey,
                          surveyID
                          )
                              
  {
                  lsGetSurveySummary(lsAPIurl,
                          sessionKey,
                          surveyID,
                          statName = 'incomplete_responses'
                          )
  }
