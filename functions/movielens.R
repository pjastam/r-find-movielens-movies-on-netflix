#This function requests for a list with movie names and predictions.

require(httr)

movielens <- function(url, path, headers, page = 1) {
  #Maak een lijstje met de films met beste voorspellingen
  #https://movielens.org/api/movies/explore?hasRated=no&sortBy=prediction
  r <- GET(url = url, path = path, add_headers(.headers = headers), query = list(hasRated = "no", sortBy = "prediction", page = page))
  
  #https://stackoverflow.com/questions/23758858/how-can-i-extract-elements-from-lists-of-lists-in-r
  p <- content(r)$data$searchResults
  
  pagerobj <- content(r)$data$pager
  
  #titel van de film
  l_movies <- lapply(p, '[[', c('movie'))
  l_titles <- lapply(l_movies, '[[', c('title'))
  l_avgRating <- lapply(l_movies, '[[', c('avgRating'))
  
  #voorspelde rating
  l_movieUserData <- lapply(p, '[[', c('movieUserData'))
  l_prediction <- lapply(l_movieUserData, '[[', c('prediction'))
  
  #samenvoegen
  #cbind(title = l_titles, movielens = l_avgRating, prediction = l_prediction)
  return(list(title = l_titles, pagerobj = pagerobj))
}
