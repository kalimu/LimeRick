#' Function directly calling the LimeSurvey API
#' todo: documentation
#' @export


# todo: there may also be in the future a function for connecting with LS without API

lsAPI = function(lsAPIurl,
                 method,
                 params = NULL
                 ){

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


        apiResult = jsonlite::fromJSON(httr::content(apiResponse,
                                       encoding = "UTF-8"))$result

        # print(apiResult)
        # print(class(apiResult))

        # we need also check the response status
        if (class(apiResult) == 'list' && !is.null(apiResult$status)) {

            # throwing an error and stopping execution of the script
            stop(apiResult$status)

        } else {

            # print(httr::headers(apiResponse))


            apiResult

        }

    } else {

        cat('\n', httr::http_status(apiResult)$message)
        cat('\n', httr::content(apiResult)$error)

        return

    }

}
