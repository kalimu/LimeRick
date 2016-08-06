#' Function getting and releasing LimeSurvey API session key
#' todo: documentation
#' @export
#'
#'


# there are many solutions for setting user&password like those in limer repo and
# http://blog.revolutionanalytics.com/2015/11/how-to-store-and-use-authentication-details-with-r.html
# I am not sure if they are necessary
# setting passwords directly in the script should be allowed if for the user
# has been set privileges in LS
# Anyhow he will be allowed to do whatever he can with survey via API and without them the code will not be reproducible
# but the API user must be set as a special user with limited privileges not a superadministrator (!)


lsSessionKey = function(lsAPIurl,
                        action = "release",
                        user = NULL,
                        pass = NULL
                        ){

    if (action == "release") {

        lsAPI(lsAPIurl, method = "release_session_key")

    } else if (action == "get") {

        params = list(admin = user, password = pass)

        lsAPI(lsAPIurl, method = "get_session_key", params)

    }





}
