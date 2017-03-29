
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
#> Welcome to LimeRick package version: 0.0.1.9000
#> 
#> Homepage: http://www.wais.kamil.rzeszow.pl/LimeRick
#> 
#> Changelog: news(package = 'LimeRick')
#> Package help: help(LimeRick)
#> 
#> If you find this package useful cite it please. Thank you!
#> See: citation('LimeRick')
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
options(lsAPIurl = 'http://odgar.pl/survey/index.php/admin/remotecontrol')

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
#> Connecting to: http://odgar.pl/survey/index.php/admin/remotecontrol 
#> Releasing session key...
#> [1] "OK"
```

### Setting a connection to a survey

``` r
# getting session key for the user and saving it inside a special environment
lsSessionKey("set")
#> Connecting to: http://odgar.pl/survey/index.php/admin/remotecontrol 
#> Obtaining session key...
#> [1] "yagmrycvd49tmim3w4u3n23thimtp952"

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
browseURL(paste0("http://odgar.pl/survey/index.php/survey/index/sid/", surveyID))
```

or use this link: <http://odgar.pl/survey/index.php/survey/index/sid/683736>

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
#> [1] "619"
#> 
#> $incomplete_responses
#> [1] "46"
#> 
#> $full_responses
#> [1] "665"
```

### Importing responses into R

``` r
d = lsGetResponses(surveyID, completionStatus = 'complete')
tail(d)
#>      id          submitdate lastpage startlanguage           startdate
#> 614 661 2016-12-10 08:15:37       NA            en 2016-12-10 08:15:37
#> 615 662 2016-12-10 08:15:39       NA            en 2016-12-10 08:15:39
#> 616 673 2017-01-30 10:05:55        1            en 2017-01-30 10:05:24
#> 617 675 2017-01-30 10:16:08       NA            en 2017-01-30 10:16:08
#> 618 676 2017-01-30 10:17:38       NA            en 2017-01-30 10:17:38
#> 619 680 2017-02-04 12:27:40        1            en 2017-02-04 12:27:39
#>               datestamp   ipaddr packageName
#> 614 2016-12-10 08:15:37             LimeRick
#> 615 2016-12-10 08:15:39             LimeRick
#> 616 2017-01-30 10:05:55 10.0.2.2    LimeRick
#> 617 2017-01-30 10:16:08             LimeRick
#> 618 2017-01-30 10:17:38             LimeRick
#> 619 2017-02-04 12:27:40 10.0.2.2            
#>                                                                                                                                                                                                                                                                                                                                                                                                                 feedback
#> 614                                                                                                                                                                                                                                                                                                                                                                                      Adding feedback directly from R
#> 615                                                                                                                                                                                                                                                                                                                                                                                            Good job! (Kamil, Poland)
#> 616                                                                                                                                                                                                                                                                                                                                                                                                Sounds very promising
#> 617                                                                                                                                                                                                                                                                                                                                                                                      Adding feedback directly from R
#> 618                                                                                                                                                                                                                                                                                                                                                                                         Good job! (Jason, Liverpool)
#> 619 Stress can have an unbelievable impact on health. It can come from a variety of sources and have a diversity of manifestations. The tips that are outlined below will aid in the identification of the factors that cause stress and in the steps that we can take to reduce its impacts or eliminate them entirely. \n \n<a href=https://www.acheterviagrafr24.com/viagra-prix-en-france/>viagra prix en france</a>
#>       sector        country
#> 614 academia         Poland
#> 615 academia         Poland
#> 616 academia United Kingdom
#> 617 academia United Kingdom
#> 618 academia United Kingdom
#> 619            South Africa
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
#> [1] "697"

# or adding via wrapper function
lsAddFeedback(feedback = "Good job! (Kamil, Poland)", 
              sector = "academia", 
              country = "Poland")
#> Thank you for the feedback!
#> [1] "698"
```

See also:
---------

-   LimeSurvey Project Team / Carsten Schmitz (2015). / LimeSurvey: An Open Source survey tool /LimeSurvey Project Hamburg, Germany. URL <http://www.limesurvey.org>
