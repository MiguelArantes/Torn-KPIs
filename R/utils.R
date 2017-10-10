#FIXME: I need to make a function in this to call when need. 

logging::basicConfig()

token <- "IN HERE"

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

link <- c("torn",
          "user",
          "market",
          "company",
          "faction",
          "property")

i <- 4

url <- sprintf("https://api.torn.com/%s", link[i])

r <- httr::GET(url, query = list(key = token))

if (httr::status_code(r) == 200) {
  logging::loginfo(http_status(r)$message)
} else {
  logging::logerror(http_status(r)$message)
}

rContent <- httr::content(r)

str(rContent)