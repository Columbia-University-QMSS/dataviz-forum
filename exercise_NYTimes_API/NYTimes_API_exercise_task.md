NYTimes API
================

The New York Times API
======================

NYTimes API
-----------

The [New York Times](nytimes.com) provides an API to access several data sources they have collected as well as their articles. For this example, we will use

The `rtimes()` package
----------------------

You can access the API directly. However, the [`rtimes` package](https://github.com/tbrambor/rtimes) provided by Scott Chamberlain makes this easier from R, so we will use the package to get what we want.

Install `rtimes()` package
--------------------------

First, install the `rtimes` package.

``` r
# install.packages("rtimes")
library(rtimes)
```

Get a free API key
------------------

To use the NYTimes API, you need to obtain a free API key by registering here: <http://developer.nytimes.com/apps/register>

They do offer a few different APIs (but it seems you may get the same key for each one). Get the ones for the "Geographic API" and the "Article Search API".

Store the keys in the R startup file
------------------------------------

While you can provide the API keys directly in the code, it is more efficient to store them in the `.Renviron` file which is loaded during `R`'s startup. It is also safer to keep it secret if you share code (as you may in a assignment/group work).

``` r
# Find your R Home directory
R.home(component = "home")
# The R_ENVIRON should be here: ‘R_HOME/etc/Renviron.site’
```

Open the the file `Renviron.site` and add the NYTimes API keys with the following lines

``` r
# NYTIMES Geo API Key
NYTIMES_GEO_KEY = THE_API_KEY_HERE
# NYTIMES Article Search API Key
NYTIMES_AS_KEY = THE_API_KEY_HERE
```

Play around with the API
------------------------

To ge to know the API, there is an online GUI which allows you to get to know the parameters: <http://developer.nytimes.com/article_search_v2.json>

<!--- http://jamesboehmer.github.io/nytd2013/#/6/1 -->
Getting a query
---------------

Let's run a simple query for articles containing the term "suicide bombing" published in 2016 in the NYTimes. By default, the fields `body`, `byline`, `date`, `title`, and `url` will be searched for the keyword you provide.

``` r
articlesearch <- as_search(q='suicide bombing', 
                 begin_date='20160101', 
                 end_date='20161231', 
                 fq = 'source:"The New York Times"')
```

Structure of the Information
----------------------------

The information we get back is structured as a list of lists. The top three lists are (1) a copyright info, (2) meta info about the search results, (3) the article info.

``` r
str(articlesearch, max.level=1)
```

    ## List of 3
    ##  $ copyright: chr "Copyright (c) 2015 The New York Times Company.  All Rights Reserved."
    ##  $ meta     :'data.frame':   1 obs. of  3 variables:
    ##  $ data     :List of 10

Get info on one document
------------------------

Get the information about the first element, i.e. the first article, from the data list.

``` r
article <- articlesearch$data[[1]]
article
```

    ## <NYTimes article>Suicide Bombing Near Historic Mosque in Turkey Wounds 13
    ##   Type: News
    ##   Published: 2016-04-28T00:00:00Z
    ##   Word count: 238
    ##   URL: http://www.nytimes.com/2016/04/28/world/europe/suicide-bombing-near-historic-mosque-in-turkey-wounds-13.html
    ##   Snippet: A female suicide bomber blew herself up near the Ulu Camii, or Grand Mosque, a popular tourist destination in a historic district of Bursa in northwestern Turkey....

Parse info on one document into data frame
------------------------------------------

Ideally, we would like to have all information per article in a single row in a dataframe, with the colums indicating the information. E.g. "Article ID", "Subjects", "Word Count", "Locations" etc.

To do that, we need to transform the list items into a data frame.

As an exercise, try to explore how that could be done. Feel free to use existing sources online.
