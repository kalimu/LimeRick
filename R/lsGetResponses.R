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

    if {missing(completionStatus) {completionStatus="all"}}

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
#lsGetSurveySummary
#########################

lsGetSurveySummary = function(lsAPIurl,
                          sessionKey,
                          surveyID,
                          statName = 'all'

#'token_count', 'token_invalid', 'token_sent', 'token_opted_out', 'token_completed', 'completed_responses', 
#'incomplete_responses', 'full_responses' or 'all'
                             ){

    params = list(sSessionKey = sessionKey,
                  iSurveyID = surveyID,
                  sStatName = statName
                  )

    data = lsAPI(lsAPIurl, method = "get_summary", params)

    data = rawToChar(base64enc::base64decode(data))

    data
}

#########################
#lsGetQuestionProperties
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
                                  data2
                          }
