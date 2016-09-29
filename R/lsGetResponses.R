#' Function for getting responses from a survey via LimeSurvey API
#' todo: documentation
#' @export

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
