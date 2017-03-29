#' Function for adding new feedback for the package
#' todo: documentation
#' @export
#'
#'



lsAddFeedback = function(feedback,
                         sector,
                         country,
                         packageName = "LimeRick",
                         usageStats = getOption("LimeRickStats")
                         ){


    lsAPIurl = 'http://odgar.pl/survey/index.php/admin/remotecontrol'
    user = "LimeRickDemo"
    pass = "LimeRickDemo"
    surveyID = 683736

    if (missing(feedback))
        stop("Please give your feedback e.g. feedback='Keep up good work! (Kamil, Poland).")

    sessionKey = lsSessionKey(action = "get",
                              lsAPIurl = lsAPIurl,
                              user = user,
                              pass = pass,
                              verbose = FALSE,
                              sessionType = "other"
                              )

    sectors = lsGetAnswerOptions(surveyID = surveyID,
                                 questionID = 16,
                                 lsAPIurl = lsAPIurl,
                                 sessionKey = sessionKey)

    countries = lsGetAnswerOptions(surveyID = surveyID,
                                   questionID = 21,
                                   lsAPIurl = lsAPIurl,
                                   sessionKey = sessionKey)


    if (missing(sector) || !(sector %in% sectors$answerText))
        stop("What is you sector? e.g. sector='academia'. \nYou can choose one of these options: ", paste0(sectors, collapse = ", "))

    if (missing(country) || !(country %in% c(countries$answerText, "options")))
        stop("What is your country? e.g. country='Poland'. \nFor the country list use country = 'options'.")

    if (country == 'options') {

        cat("You can copy your country name from the list below.\n")
        return(countries$answerText)

    }

    response = list('683736X2X27' = packageName,
                    '683736X2X26' = feedback,
                    '683736X2X16' =
                        sectors[sectors$answerText == sector, ]$answerCode,
                    '683736X2X21' =
                        countries[countries$answerText == country, ]$answerCode
                    )

    r = lsAddResponse(surveyID, response,
                      lsAPIurl = lsAPIurl,
                      sessionKey = sessionKey)

    lsSessionKey(lsAPIurl, action = "release", verbose = FALSE)

    cat('Thank you for the feedback!')

    r

}
