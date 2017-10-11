#FIXME: I need to make a function in this to call when need.
selection <-
  c(
    "items",
    "medals",
    "honors",
    "organisedcrimes",
    "gyms",
    "companies",
    "properties",
    "education",
    "stats",
    "stocks",
    "factiontree"
  )


get.data <- function(toke, i) {
  logging::basicConfig()

  link <- c("torn",
    "user",
    "market",
    "company",
    "faction",
    "property")

  url <- sprintf("https://api.torn.com/%s", link[i])

  r <- httr::GET(url, query = list(key = token))

  if (httr::status_code(r) == 200) {
    logging::loginfo(http_status(r)$message)
  } else {
    logging::logerror(http_status(r)$message)
  }

  r_content <- httr::content(r)

  return(r_content)
}

save.content <- function(prefix, r_content) {
  prefix <- paste0(prefix, Sys.Date(), ".csv")
  utils::write.csv(x = r_content, file = prefix)
}
