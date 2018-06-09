#################################################################################
# INCLUDE FUNCTIONS
#################################################################################

source("functions/movielens.R")
source("functions/maxpag.R")
source("functions/nuopnetflix.R")

#################################################################################
# GET MOVIELENS TITLES
#################################################################################

url  <- "https://movielens.org"
path <- "/api/movies/explore"
#Find your cookie in your standard browser, let's say this is Chrome:
#Settings -> (Under privacy section choose:) Show advanced settings -> Content settings -> Cookies -> All cookies and site data -> movielens.org -> fill out the parameters in headers assigment below
headers <- c("Cookie" = "_ga=; __uvts=7bHcgVX0GlVSlChS; ml4_session=a6bb369259b6b160c593e675888019818131d3a8_a9cfccbb-2dea-4b59-9704-f87b9fd2e524")

#Scrape each Movielens page with movie titles
r <- movielens(url, path, headers)

#Rbind the Movielens pages
movies_movielens <- r$title
for (i in 1:maxpag(r$pagerobj)) {
  if (i > 1) {
    movies_movielens <- rbind(movies_movielens, movielens(url, path, headers, page = i))
  }
}

#Sanitize the Movielens output
movies_movielens <- data.frame(unlist(movies_movielens),stringsAsFactors=FALSE)
colnames(movies_movielens) <- "title"

#ISSUE: the movies in this list are not unique, we solve this by the unique command for this moment
movies_movielens <- unique(movies_movielens)

#################################################################################
# GET NETFLIX TITLES
#################################################################################

#Get the currently available Netflix titles
#They are located in the local html file in the data subdirectory
url <- "data/nuopnetflix.htm"
movies_netflix <- nuopnetflix(url)

#################################################################################
# SELECT MOVIELENS TITLES THAT ARE ALSO IN THE LIST OF NETFLIX TITLES
#################################################################################

require(dplyr)

movies_shortlist <- movies_movielens %>%
  inner_join(movies_netflix, by = "title")
