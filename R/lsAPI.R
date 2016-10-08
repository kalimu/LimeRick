#' Function directly calling the LimeSurvey API
#' todo: documentation
#' @export


# todo: there may also be in the future a function for connecting with LS without API

lsAPI = function(method,
                 params = NULL,
                 lsAPIurl = getOption("lsAPIurl")
                 ){

    if (is.null(lsAPIurl))
        stop("Need to specify LimeSurvey API URL (lsAPIurl).")

    if (missing(method))
        stop("Need to specify method function for the LimeSurvey API.")

    if (is.null(params)) {

        params = list(sSessionKey = lsSessionCache$sessionKey )

    }

    # preparing the body of the API call in JSON format
    bodyJSON = list(method = method,
                    id = " ",
                    params = params
                    )

    bodyJSON = jsonlite::toJSON(bodyJSON, auto_unbox = TRUE)


    # the API call
    # apiResponse = httr::POST(lsAPIurl,
    #                          httr::content_type_json(),
    #                          body = bodyJSON
    #                          )
    # RETRY() function allows you to retry a request multiple times
    # until it succeeds, if you you are trying to talk to an unreliable service
    apiResponse = httr::RETRY("POST", lsAPIurl,
                              httr::content_type_json(),
                              body = bodyJSON
                              )


    # checking status code;
    # suprisingly API returns code 200 event if something is not ok (wrong password)
    if (httr::status_code(apiResponse) == 200) {

        # cat('Status code is 200.\n')
        content = httr::content(apiResponse, encoding = "UTF-8")

        if (!is.character(content) && is.null(content$result))
            stop('Server is responding but not in a proper way. Please check the API URL.')

        apiResult = jsonlite::fromJSON(content)$result

        # we need also check the response status
        if (class(apiResult) == 'list' && !is.null(apiResult$status)) {

            # throwing an error and stopping execution of the script
            stop(apiResult$status)

        } else {

            # print(httr::headers(apiResponse))
            apiResult

        }

    } else {

        cat('Status code is not 200! \n')
        stop(httr::http_status(apiResponse)$message)
        #cat('\n', httr::content(apiResult)$error)



    }

}
