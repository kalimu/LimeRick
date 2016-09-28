#' Function for getting responses from a survey via LimeSurvey API
#' todo: documentation
#' @export
#'
#'

# export_responses
# /**
# * RPC Routine to export responses.
# * Returns the requested file as base64 encoded string
# *
# * @access public
# * @param string $sSessionKey Auth credentials
# * @param int $iSurveyID Id of the Survey
# * @param string $sDocumentType pdf,csv,xls,doc,json
# * @param string $sLanguageCode The language to be used
# * @param string $sCompletionStatus Optional 'complete','incomplete' or 'all' - defaults to 'all'
# * @param string $sHeadingType 'code','full' or 'abbreviated' Optional defaults to 'code'
# * @param string $sResponseType 'short' or 'long' Optional defaults to 'short'
# * @param integer $iFromResponseID Optional
# * @param integer $iToResponseID Optional
# * @param array $aFields Optional Selected fields
# * @return array|string On success: Requested file as base 64-encoded string. On failure array with error information
# * */

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

#########################
#lsGetResponsesIncomplete
#########################

lsGetResponsesIncomplete = function(lsAPIurl,
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
                          completionStatus = "incomplete",
                          documentType = "csv",
                          languageCode = "en",
                          headingType = "code",
                          responseType = "long",
                          fromResponseID = NULL,
                          toResponseID = NULL,
                          fields = NULL
                          )
                          
                          }


#########################
#lsGetResponses
#private
#########################

lsGetResponses = function(lsAPIurl,
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

    if (missing(completionStatus)) {completionStatus="all"}

    # todo: wokring with other document types (JSON especially; is a bit
    # problematic)

    # todo: test different language codes, completion statuses, heading and
    # response types

    # todo: implement from and to ResponseID


    # setting parameters for API call
    params = list(sSessionKey = sessionKey,
                  iSurveyID = surveyID,
                  sDocumentType = documentType,
                  sLanguageCode = languageCode,
                  sCompletionStatus = completionStatus,
                  sHeadingType = headingType,
                  sResponseType = responseType

                  # todo: there is a problem with API with setting this params
                  # to NULL: Error: Argument 'txt' must be a JSON string, URL or
                  # file.

                  # sFromResponseID = NULL,
                  # sToResponseID = NULL,
                  # sFields = NULL
                  )

    # API call with export_responses method
    data = lsAPI(lsAPIurl, method = "export_responses", params)

    # decoding data from base64 format
    data = rawToChar(base64enc::base64decode(data))

    # importing data from CSV format into data frame
    df = read.csv(textConnection(data),
             encoding = "UTF-8",
             stringsAsFactors = FALSE)

    # returing data frame
    df

}

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

#########################
#lsGetSurveySummaryAll
#########################

lsGetSurveySummaryAll = function(lsAPIurl,
                          sessionKey,
                          surveyID
                          )
                              
  {
                  lsGetSurveySummary(lsAPIurl,
                          sessionKey,
                          surveyID
                          )
  }

#########################
#lsGetSurveySummary
#private
#########################

lsGetSurveySummary = function(lsAPIurl,
                          sessionKey,
                          surveyID,
                          statName = 'all'
                             ){

    params = list(sSessionKey = sessionKey,
                  iSurveyID = surveyID,
                  sStatName = statName
                  )

    data = lsAPI(lsAPIurl, method = "get_summary", params)

    data = rawToChar(base64enc::base64decode(data))

    if (statName=="all") 
        {
        df = read.csv(textConnection(data),
             encoding = "UTF-8",
             stringsAsFactors = FALSE)
        df
        }
    else
        {
    data
        }
  
}

#########################
#lsGetSurveyProperties
#########################

lsGetSurveyProperties = function(lsAPIurl,
                          sessionKey,
                          surveyID,
                          surveySettings #mandatory option

#settings option not known disclosed by API
                                 
                             ){

    params = list(sSessionKey = sessionKey,
                  iSurveyID = surveyID,
                  aSurveySettings = surveySettings
                  )

    data = lsAPI(lsAPIurl, method = "get_survey_properties", params)

    data = rawToChar(base64enc::base64decode(data))

    df = read.csv(textConnection(data),
             encoding = "UTF-8",
             stringsAsFactors = FALSE)
  
    df
}

#########################
#lsGetQuestionProperties
#beta
#########################

lsGetQuestionProperties = function(sessionKey,
                          questionID,
                          #questionProperty,
                          languageCode = "en",
                          ){
                          
              params = list(sSessionKey = sessionKey,
                  iQuestionID = questionID,
                  aQuestionSettings = c("available_answers","subquestions","attributes","attributes_lang","answeroptions","defaultvalue"),
                  sLanguageCode = languageCode,
                  )
                                  
                                  data2 = lsAPI(lsAPIurl, method = "get_question_properties", params)
 
                                  #beta - 1D array only  
  
                                      df2 = read.csv(textConnection(data2),
                                        encoding = "UTF-8",
                                        stringsAsFactors = FALSE)
  
                                      df2
                          }
