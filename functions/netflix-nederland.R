# function to scrape Netflix titles from remote html file
# Source: https://www.netflix-nederland.nl/aanbod-netflix-nederland/
#
# Analyse source: Firefox -> Extra -> Webontwikkelaar -> Inspector
# xpath syntax: https://www.w3schools.com/XML/xpath_syntax.asp
# We used the Firefox console to check whether the xpath returns the correct element (syntax: $x('//div/xpath')),
# Source: https://stackoverflow.com/questions/41857614/how-to-find-xpath-of-an-element-in-firefox-inspector#41875894

require(rvest)
require(dplyr)

netflix <- function(url) {

  r <- read_html(url) %>%
    html_node("table.tablepress.tablepress-id-60") %>%
    html_nodes("a") %>%
    html_text() %>%
    as.data.frame(stringsAsFactors = FALSE) %>%
    `colnames<-`(c("title"))
	
	return(r)
}
