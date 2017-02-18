Mapping in R - selected exercises
================

World Map of Health Care Expenditures as share of GDP
=====================================================

World Development Indicators (WDI)
----------------------------------

For this exercise we will work with data from the World Development Indicators (WDI). Vincent Arel-Bundock provides a nice package for R that makes it easy to import the data.

``` r
# install.packages("WDI")
library(WDI)
library(dplyr)
```

Select the data
---------------

Let's get some data on health expenditures as a share of GDP. `SH.XPD.TOTL.ZS` seems like a good fit.

``` r
WDIsearch('health expenditure')
```

    ##       indicator          
    ##  [1,] "SH.XPD.OOPC.TO.ZS"
    ##  [2,] "SH.XPD.OOPC.ZS"   
    ##  [3,] "SH.XPD.PCAP"      
    ##  [4,] "SH.XPD.PCAP.GX"   
    ##  [5,] "SH.XPD.PCAP.PP.KD"
    ##  [6,] "SH.XPD.PRIV"      
    ##  [7,] "SH.XPD.PRIV.CD"   
    ##  [8,] "SH.XPD.PRIV.ZS"   
    ##  [9,] "SH.XPD.PUBL"      
    ## [10,] "SH.XPD.PUBL.GX.ZS"
    ## [11,] "SH.XPD.PUBL.ZS"   
    ## [12,] "SH.XPD.TOTL.CD"   
    ## [13,] "SH.XPD.TOTL.ZS"   
    ##       name                                                                   
    ##  [1,] "Out-of-pocket health expenditure (% of total expenditure on health)"  
    ##  [2,] "Out-of-pocket health expenditure (% of private expenditure on health)"
    ##  [3,] "Health expenditure per capita (current US$)"                          
    ##  [4,] "Government health expenditure per capita (current US$)"               
    ##  [5,] "Health expenditure per capita, PPP (constant 2005 international $)"   
    ##  [6,] "Health expenditure, private (% of total health expenditure)"          
    ##  [7,] "Health expenditure, private (current US$)"                            
    ##  [8,] "Health expenditure, private (% of GDP)"                               
    ##  [9,] "Health expenditure, public (% of total health expenditure)"           
    ## [10,] "Health expenditure, public (% of government expenditure)"             
    ## [11,] "Health expenditure, public (% of GDP)"                                
    ## [12,] "Health expenditure (current US$)"                                     
    ## [13,] "Health expenditure, total (% of GDP)"

``` r
df = WDI(indicator = "SH.XPD.TOTL.ZS" ,
         start = 2014, end = 2014, extra = F)
df = df %>% filter(!is.na(SH.XPD.TOTL.ZS))
```

Questions
---------

1.  Use the map package and the health expenditure data to make a world map of health expenditures as a share of GDP.

2.  Install the package `countrycode()` and use the countrycode function to add a region indicator to the dataset. Create a world map faceted by your region indicator.

Locations of Fortune 500 companies
==================================

Where are the Fortune 500 headquarters
--------------------------------------

For this exercise, we want to create a map of where the Fortune 500 companies - that is the five hundred largest U.S. corporations by total revenue - have their headquarters.

<!---
## Addresses

Let's get the addresses here: https://www.geolounge.com/fortune-500-list-by-state-for-2015/


```r
library(XML)
library(RCurl)
```

```
## Loading required package: bitops
```

```r
fortune500_url <- getURL("https://www.geolounge.com/fortune-500-list-by-state-for-2015/",.opts = list(ssl.verifypeer = FALSE) )  # We needs this because the site is https
fortune500 = readHTMLTable(fortune500_url, header = TRUE, which = 1)
colnames(fortune500) <- tolower(colnames(fortune500))
fortune500 <- subset(fortune500, select=c("company","streetadd","place","state","zip"))
write.csv(fortune500, "fortune500.csv")
```
--->
Load the associated file of addresses
-------------------------------------

Load the list of Fortune 500 companies (in 2015).

``` r
library(readr)
fortune500 <- read_csv("fortune500.csv")
```

    ## Warning: Missing column names filled in: 'X1' [1]

    ## Parsed with column specification:
    ## cols(
    ##   X1 = col_integer(),
    ##   company = col_character(),
    ##   streetadd = col_character(),
    ##   place = col_character(),
    ##   state = col_character(),
    ##   zip = col_integer()
    ## )

Task 1: Make a map by state
---------------------------

**Task**: Aggregate the number of headquarters by state. Make a map in which the states are shaded by their number of Fortune 500 companies

Use `dplyr()` for the aggregation and the `maps()` package for a map of the U.S. with state boundaries.

Task 2: Tax Rates by State
--------------------------

**Task**: We also got some info on top corporate income tax rates by state. Import sheet 2 of the file `State_Corporate_Income_Tax_Rates_2015.xlsx` and make a map shaded by top corporate income tax rates.

Task 3: Scatter plot of income tax rates and \# of headquarters
---------------------------------------------------------------

Is there evidence of companies being headquartered in low tax states?

**Task**: 1. Make a scatter plot with a loess function estimating the relationship between corporate income tax rates (x-axis) and \# of headquarters (y-axis). 2. What happens if we account for state population (i.e use HQs per capita)? Import the data on state populations from Wikipedia: <https://en.wikipedia.org/wiki/List_of_U.S._states_and_territories_by_population>. Use the function `readHTMLTable()` from the package `XML` to import the data and merge it on. Re-do the scatter plot from part 1.

Geocoding
---------

Now, let's get the Latitude and Longitude coordinates of all these addresses of the HQ addresses. Fortunately, ggmap() does this for us nicely.

``` r
library(ggmap)
```

    ## Loading required package: ggplot2

``` r
# This is Walmart's HQ address:
geocode("702 S.W. Eighth St. Bentonville Arkansas 72716", output = "latlon" , source = "google")
```

    ## Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=702%20S.W.%20Eighth%20St.%20Bentonville%20Arkansas%2072716&sensor=false

    ##         lon      lat
    ## 1 -94.21815 36.36558

Task 4: Geocode headquarter locations and add to the plot
---------------------------------------------------------

**Task**: 1. Geocode the locations of all headuarters in the sample. Add the locations of the headquarters as points to the map from part 2 (U.S. state map shaded by top corporate income tax rates). 2. Add a label with the company names. Use ggrepel() if the labels overlap too much. 3. Size the points by the ranking on the Fortune 500 list (we don't have revenue here, so the rank will have to do).
