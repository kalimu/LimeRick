#' @export

#########################
#lsGetQuestionProperties
#beta
#########################

lsGetQuestionProperties = function(sessionKey,
                          questionID,
                          #questionProperty,
                          languageCode = "en"
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
