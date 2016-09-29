#' @export

#########################
#lsGetResponsesAll
#########################

lsGetResponsesAll = function(lsAPIurl,
                          sessionKey,
                          surveyID,
                          completionStatus,
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
                          completionStatus = "all",
                          documentType = "csv",
                          languageCode = "en",
                          headingType = "code",
                          responseType = "long",
                          fromResponseID = NULL,
                          toResponseID = NULL,
                          fields = NULL
                          )
                          
                          }
