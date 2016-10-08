
<!-- README.md is generated from README.Rmd. Please edit that file -->
LimeRick
========

[![Project Status: active](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/LimeRick)](https://cran.r-project.org/package=LimeRick) [![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/LimeRick?)](https://github.com/metacran/cranlogs.app)

<strong>Bridge between R and LimeSurvey</strong>
by Kamil Wais, Ph. D. ([homepage / contact](http://www.wais.kamil.rzeszow.pl))

The package homepage: <http://www.wais.kamil.rzeszow.pl/LimeRick/>

The LimeSurvey homepage: <http://limesurvey.org>

LimeRick: motivation
--------------------

-   need for a bridge that <span style="font-weight: bold">connects very closely</span> two important open-sorce projects (R and LimeSurvey)
-   need for an <span style="font-weight: bold">advanced tool</span> that allow for:
    -   <span style="font-weight: bold">quickly importing</span> responses into R from active on-line surveys
    -   <span style="font-weight: bold">automatically accessing</span> properties of survey and questions
    -   <span style="font-weight: bold">montoring</span> survey status and responses directly from R
    -   <span style="font-weight: bold">adding new responses</span> to a survey directly from R
    -   <span style="font-weight: bold">simplifying workflow</span> for reproducible analysis<br> (by providing in advance structured data schema)
    -   developing <span style="font-weight: bold">data products</span> based on <span style="font-weight: bold">real-time</span> declarative data collection<br> (ex. continous on-line tracking studies)
    -   collecting meta-data of respondents interactions with on-line surveys <br>on <span style="font-weight: bold">unique low-granular level</span>

LimeRick: tutorial
------------------

### Installing developer version from GitHub

``` r
# install.packages('devtools')
devtools::install_github("kalimu/LimeRick")
```

### Loading the installed package

``` r
library(LimeRick)
#> 
#> Welcome to LimeRick package version: 0.0.0.9000
#> 
#> To suppress this message use:
#> suppressPackageStartupMessages(library(LimeRick))
#> 
#> First you need to set login parameters and obtain a session key. 
#> See the lsSessionKey() function help page (?lsSessionKey).
```

### Configuring access to a survey

``` r
# set link to the LimeSurvey API on the demo remote server
options(lsAPIurl = 'http://odgar.net/survey/index.php/admin/remotecontrol')

# set LimeSurvey user login data for survey testing purposes
options(lsUser = "LimeRickDemo")
options(lsPass = "LimeRickDemo")
```

### Low-level API function calls vs. function wrappers

``` r
# low-level API call
lsAPI(method = "release_session_key")
#> [1] "OK"

# API call using a wrapper function
lsSessionKey("release")
#> Connecting to: http://odgar.net/survey/index.php/admin/remotecontrol 
#> Releasing session key...
#> [1] "OK"
```

### Setting a connection to a survey

``` r
# getting session key for the user and saving it inside a special environment
lsSessionKey("set")
#> Connecting to: http://odgar.net/survey/index.php/admin/remotecontrol 
#> Obtaining session key...
#> [1] "gdqjuhiejnsaatp5xsu8v232gcymbpq5"

# if you work with specific local set it now
Sys.setlocale("LC_ALL", "Polish")
#> [1] "LC_COLLATE=Polish_Poland.1250;LC_CTYPE=Polish_Poland.1250;LC_MONETARY=Polish_Poland.1250;LC_NUMERIC=C;LC_TIME=Polish_Poland.1250"
```

### Listing available surveys

``` r
# listing available surveys
(surveyList = lsList("surveys"))
#>      sid                 surveyls_title startdate expires active
#> 1 683736 Feedback survey for R Packages        NA      NA      Y

# extracting ID of demo survey
surveyID = surveyList$sid[1] 
```

### Adding responses via on-line survey questionaire

``` r
# try submit your own answers to the demo survey
browseURL(paste0("http://odgar.net/survey/index.php/survey/index/sid/", surveyID))
```

or use this link: <http://odgar.net/survey/index.php/survey/index/sid/683736>

### Listing survey questions

``` r
questionList = lsList("questions", surveyID)
```

### Accessing survey or question properites

We can access 22 question properties and 58 survey properties. For example:

``` r
# Is the survey active? (Y - Yes)
lsGetProperties('survey', surveyID)$active
#> [1] "Y"

# What is the main text of a given question?
lsGetProperties('question', surveyID, 16)$question
#> [1] "What sector do you represent?"

# Is the question mandatory? (Y - Yes)
lsGetProperties('question', surveyID, 16)$mandatory
#> [1] "N"
```

### Checking survey response

``` r
lsGetSummary(surveyID)
#> $completed_responses
#> [1] "498"
#> 
#> $incomplete_responses
#> [1] "3"
#> 
#> $full_responses
#> [1] "501"
```

### Importing responses into R

``` r
d = lsGetResponses(surveyID, completionStatus = 'complete')
tail(d)
#>      id          submitdate lastpage startlanguage           startdate
#> 493 526 2016-10-08 04:43:42       NA            en 2016-10-08 04:43:42
#> 494 527 2016-10-08 04:43:43       NA            en 2016-10-08 04:43:43
#> 495 528 2016-10-08 04:50:07       NA            en 2016-10-08 04:50:07
#> 496 529 2016-10-08 04:50:08       NA            en 2016-10-08 04:50:08
#> 497 531 2016-10-08 07:49:07       NA            en 2016-10-08 07:49:07
#> 498 532 2016-10-08 07:49:07       NA            en 2016-10-08 07:49:07
#>               datestamp ipaddr packageName                        feedback
#> 493 2016-10-08 04:43:42           LimeRick Adding feedback directly from R
#> 494 2016-10-08 04:43:43           LimeRick       Good job! (Kamil, Poland)
#> 495 2016-10-08 04:50:07           LimeRick Adding feedback directly from R
#> 496 2016-10-08 04:50:08           LimeRick       Good job! (Kamil, Poland)
#> 497 2016-10-08 07:49:07           LimeRick Adding feedback directly from R
#> 498 2016-10-08 07:49:07           LimeRick       Good job! (Kamil, Poland)
#>       sector country
#> 493 academia  Poland
#> 494 academia  Poland
#> 495 academia  Poland
#> 496 academia  Poland
#> 497 academia  Poland
#> 498 academia  Poland
```

### Adding responses via R

``` r
# showing possible options for a particular question
lsGetAnswerOptions(surveyID, questionID = 16)
#>   answerCode answerText
#> 1         A1    private
#> 2         A2   academia
#> 3         A3        NGO
#> 4         A4 government
#> 5         A5      other

# specifying a response with the use of question code: surveIDXgroupIDXquestionID
response = list('683736X2X27' = "LimeRick",
                '683736X2X26' = "Adding feedback directly from R",
                '683736X2X16' = "A2",# Academia
                '683736X2X21' = "174" # Poland
                )

# adding the above response 
lsAddResponse(surveyID, response)
#> [1] "533"

# or adding via wrapper function
lsAddFeedback(feedback = "Good job! (Kamil, Poland)", 
              sector = "academia", 
              country = "Poland")
#> Thank you for the feedback!
#> [1] "534"
```

See also:
---------

-   LimeSurvey Project Team / Carsten Schmitz (2015). / LimeSurvey: An Open Source survey tool /LimeSurvey Project Hamburg, Germany. URL <http://www.limesurvey.org>
