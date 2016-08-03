#' Function direclty calling the LimeSurvey API
#' todo: documentation
#' @export


# todo: there may also be in the future a function for connecting with LS without API

lsAPI = function(lsAPIurl,
                 method,
                 params
                 ){


    bodyJSON = list(method = method,
                    id = " ",
                    params = params
                    )

    bodyJSON = jsonlite::toJSON(bodyJSON, auto_unbox = TRUE)

    apiResponse = httr::POST(lsAPIurl,
                             httr::content_type_json(),
                             body = bodyJSON
                             )

    apiResult = jsonlite::fromJSON(httr::content(apiResponse,
                                   encoding = "UTF-8"))$result

    apiResult

}
