#################################################################################
# INCLUDE FUNCTIONS
#################################################################################

source("functions/movielens.R")
source("functions/maxpag.R")
source("functions/netflix-nederland.R")

#################################################################################
# GET MOVIELENS TITLES
#################################################################################

url  <- "https://movielens.org"
path <- "/api/movies/explore"
#Find your cookie in your standard browser, let's say this is Chrome:
#Settings -> Show advanced settings -> (Under privacy section choose:) Content settings -> Cookies -> All cookies and site data -> movielens.org -> fill out the parameters in headers assigment below
headers <- c("Cookie" = "_ga=GA1.2.1715665127.1528646540; _gid=GA1.2.2048730544.1528646540; __uvts=7bc1GJF2Etmsq429; ml4_session=2af503ad797ccb80b2d11d1a3fd0de7f0a487df2_d5e694e2-de2f-4208-bfe3-247beffbfa1a
")

#Scrape the first Movielens page with movie titles
r <- movielens(url, path, headers)
movies_movielens <- as.data.frame(r[c("title","movielens","prediction")], stringsAsFactors = FALSE)

#npages <- maxpag(r$pagerobj
npages <- 1
#Rbind the other Movielens pages with movie titles
for (i in 1:npages) {
  if (i > 1) {
    r <- movielens(url, path, headers, page = i)
    movies_movielens <- rbind(movies_movielens, as.data.frame(r[c("title","movielens","prediction")], stringsAsFactors = FALSE))
  }
}

#Sort the Movielens output by prediction
movies_movielens <- movies_movielens[order(movies_movielens$prediction, decreasing = TRUE),]

#################################################################################
# GET NETFLIX TITLES
#################################################################################

#Get the currently available Netflix top 100 titles
url <- "https://www.netflix-nederland.nl/aanbod-netflix-nederland/"
movies_netflix <- netflix(url)

#################################################################################
# SELECT MOVIELENS TITLES THAT ARE ALSO IN THE LIST OF NETFLIX TITLES
#################################################################################

require(dplyr)

movies_shortlist <- movies_movielens %>%
  inner_join(movies_netflix, by = "title")
