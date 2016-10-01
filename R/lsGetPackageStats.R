#' Function for getting stats of using package functions
#' todo: documentation
#' @export
#'
#'



lsGetPackageStats = function(packageName = "limeRick",
                             usageStats = TRUE){

    lsAPIurl = 'http://odgar.net/survey/index.php/admin/remotecontrol'
    user = "RStats"
    pass = "45hadfjHPOout5tg"
    surveyID = 456716
    sessionKey = lsSessionKey(lsAPIurl,
                              "get",
                              user = user,
                              pass = pass
                              )

    data = lsGetResponses(lsAPIurl,
                          sessionKey,
                          surveyID,
                          usageStats = usageStats)

    lsSessionKey(lsAPIurl, action = "release")

    data[, names(data) %in% c("id", "submitdate", "startlanguage",
                              "packageName", "packageVer",
                              "functionName", "functionStats")]

}
