#' Function for getting stats of using package functions
#' todo: documentation
#' @export
#'
#'



lsGetPackageStats = function(packageName = "LimeRick",
                             usageStats = getOption("LimeRickStats")
                             ){

    lsAPIurl = 'http://odgar.pl/survey/index.php/admin/remotecontrol'
    user = "RStats"
    pass = "45hadfjHPOout5tg"
    surveyID = 456716
    sessionKey = lsSessionKey("get",
                              lsAPIurl = lsAPIurl,
                              user = user,
                              pass = pass,
                              verbose = FALSE,
                              sessionType = 'other'
                              )

    data = lsGetResponses(surveyID,
                          lsAPIurl = lsAPIurl,
                          sessionKey = sessionKey,
                          usageStats = usageStats)

    lsSessionKey(lsAPIurl, action = "release", verbose = FALSE)

    data[, names(data) %in% c("id", "submitdate", "startlanguage",
                              "packageName", "packageVer",
                              "functionName", "functionStats")]

}
