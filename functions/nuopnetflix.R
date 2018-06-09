# function to scrape Netflix titles from local html file
# Source: http://www.nuopnetflix.nl/aanbod-netflix
#
# My example: http://www.nuopnetflix.nl/aanbod-netflix
# Using: Firefox -> Extra -> Webontwikkelaar -> Inspector
# xpath syntax: https://www.w3schools.com/XML/xpath_syntax.asp
# We used the Firefox console to check whether the xpath returns the correct element (syntax: $x('//div/xpath')),
# Source: https://stackoverflow.com/questions/41857614/how-to-find-xpath-of-an-element-in-firefox-inspector#41875894

require(rvest)
require(dplyr)

nuopnetflix <- function(url) {

	movies_netflix <- url %>%
		read_html() %>%
		html_nodes(xpath='//*[@class="releases_grid"]//*[@class="title"]') %>%
		html_text()

	movies_netflix <- data.frame(unlist(movies_netflix),stringsAsFactors=FALSE)
	colnames(movies_netflix) <- "title"
	
	return(movies_netflix)
}