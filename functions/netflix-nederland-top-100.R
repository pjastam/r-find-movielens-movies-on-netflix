# function to scrape Netflix top 100 titles from remote html file
# Source: https://www.netflix-nederland.nl/beste-films-netflix-top-100/
#
# Analyse source: Firefox -> Extra -> Webontwikkelaar -> Inspector
# xpath syntax: https://www.w3schools.com/XML/xpath_syntax.asp
# We used the Firefox console to check whether the xpath returns the correct element (syntax: $x('//div/xpath')),
# Source: https://stackoverflow.com/questions/41857614/how-to-find-xpath-of-an-element-in-firefox-inspector#41875894

require(rvest)
require(dplyr)

netflix <- function(url) {
  
  r <- read_html(url) %>%
    html_nodes("tbody") %>%
    html_nodes("td:nth-of-type(2)") %>%
    html_text() %>%
    as.data.frame(stringsAsFactors = FALSE) %>%
    slice(-1:-1) %>%
    `colnames<-`(c("title"))
 
  return(r)
}
