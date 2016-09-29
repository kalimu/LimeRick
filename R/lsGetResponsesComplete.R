#' @export

#########################
#lsGetResponsesComplete
#########################

lsGetResponsesComplete = function(lsAPIurl,
                          sessionKey,
                          surveyID,
                          completionStatus,# = "all",
                          documentType = "csv",
                          languageCode = "en",
                          headingType = "code",
                          responseType = "long",
                          fromResponseID = NULL,
                          toResponseID = NULL,
                          fields = NULL
                          ){
                          
                          lsGetResponses(lsAPIurl,
                          sessionKey,
                          surveyID,
                          completionStatus = "complete",
                          documentType = "csv",
                          languageCode = "en",
                          headingType = "code",
                          responseType = "long",
                          fromResponseID = NULL,
                          toResponseID = NULL,
                          fields = NULL
                          )
                          
                          }
