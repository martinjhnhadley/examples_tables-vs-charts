
# Introducing our dataset

The Met Office makes available historical weather data for 25+ sites
from 1870 onwards at this website:
<http://www.metoffice.gov.uk/public/weather/climate-historic/#?tab=climateHistoric>

Data looks as follows:

    ## # A tibble: 2 x 8
    ##    yyyy    mm  tmax  tmin    af  rain sun   location 
    ##   <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <lgl> <chr>    
    ## 1  1873     7  16.7   9.9     0  110. NA    stornoway
    ## 2  1873     8  15.5   8.9     0  141  NA    stornoway

There’s data for at least 50 years for a total of 25 different locations
through the United Kingdom.

It’s somewhat interesting to pose the following question of the data:

> What’s the average temperature difference between the maximal and
> minimal temperature recorded in each month, for each location?

Let’s compare three different approaches to presenting this data:

  - Tables
  - Static `ggplot` chart
  - Interactive chart and map of points

# Tables Only

Data was collected from 25 different locations in the United Kingdom,
labelled according to region (England, Northern Ireland, Scotland,
Wales), from 1873 to today using the Met Offices climatic history
explorer. Mean temperature ranges per month were calculated for each
region

Mean maximum daily temperature ranges were observed to hit a maximumal
value in May, afterwards in all locations except England the temperature
range dropped significantly. In England, however, the temperature range
remained almost static for 3 months following the peakin May, see the
table below for
details

| region          | Jan | Feb | Mar | Apr | May | Jun | Jul | Aug | Sep | Oct | Nov | Dec |
| :-------------- | --: | --: | --: | --: | --: | --: | --: | --: | --: | --: | --: | --: |
| England         | 5.5 | 5.9 | 7.2 | 8.3 | 8.8 | 9.0 | 8.9 | 8.8 | 8.2 | 7.0 | 6.0 | 5.5 |
| Northern Island | 5.3 | 5.8 | 6.9 | 8.0 | 8.5 | 8.4 | 7.8 | 7.7 | 7.2 | 6.4 | 5.8 | 5.2 |
| Scotland        | 5.0 | 5.4 | 6.0 | 6.9 | 7.3 | 7.0 | 6.7 | 6.6 | 6.3 | 5.8 | 5.4 | 5.1 |
| Wales           | 4.9 | 5.2 | 5.9 | 6.7 | 7.0 | 6.9 | 6.7 | 6.5 | 6.3 | 5.6 | 5.1 | 4.8 |

# Static `ggplot` chart

Data was collected from 25 different locations in the United Kingdom,
labelled according to region (England, Northern Ireland, Scotland,
Wales), from 1873 to today using the Met Offices climatic history
explorer. Mean temperature ranges per month were calculated for each
region.

Mean maximum daily temperature ranges were observed to hit a maximumal
value in May, afterwards in all locations except England the temperature
range dropped significantly. In England, however, the temperature range
remained almost static for 3 months following the peakin May, see the
chart below for details.

![](README_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

# Interactive chart and map of points

Data was collected from 25 different locations in the United Kingdom,
labelled according to region (England, Northern Ireland, Scotland,
Wales), from 1873 to today using the Met Offices climatic history
explorer.

![](README_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

Mean maximum daily temperature ranges were observed to hit a maximumal
value in May, afterwards in all locations except England the temperature
range dropped significantly. In England, however, the temperature range
remained almost static for 3 months following the peakin May, hover your
cursor over the chart below for details:

![](README_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->
