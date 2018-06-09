#This function sets the number of pages that must be scraped to collect n items.
#The pager object is stored in content(r)$data$pager.

maxpag <- function(pagerobj, n = 100) {
  if (pagerobj$totalItems < n) {      #if there are less than n items available
    pagerobj$totalPages               #then scrape all pages
  } else {                            #otherwise
    ceiling(n/pagerobj$itemsPerPage)  #scrape pages until n items are collected
  }
}
