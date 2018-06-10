#This function requests for a list with movie names and predictions.

require(httr)
require(jsonlite)

movielens <- function(url, path, headers, page = 1) {
  #Maak een lijstje met de films met beste voorspellingen
  #https://movielens.org/api/movies/explore?hasRated=no&sortBy=prediction
  r <- GET(url = url, path = path, add_headers(.headers = headers), query = list(hasRated = "no", sortBy = "prediction", page = page))
  r <- fromJSON(content(r, "text"))
  
  #titel van de film
  l_titles <- r$data$searchResults$movie$title
  l_avgRating <- r$data$searchResults$movie$avgRating
  
  #voorspelde rating
  l_prediction <- r$data$searchResults$movieUserData$prediction

  #object with useful object output parameters  
  pagerobj <- r$data$pager
  
  #samenvoegen
  return(list(title = l_titles, movielens = l_avgRating, prediction = l_prediction, pagerobj = pagerobj))
}
