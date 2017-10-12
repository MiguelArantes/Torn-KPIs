

check.link <- function(link) {
  check_link <- c("torn",
    "user",
    "market",
    "company",
    "faction",
    "property")

  return(link %in% check_link)
}

check.selection <- function(selection) {
  check_selection <-
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

  return(selection %in% check_selection)
}


get.data <- function(token, link, selection) {
  logging::basicConfig()

  url <- sprintf("https://api.torn.com/%s", link)

  if (check.link(link)) {
    logging::loginfo("Connecting to API")
    if (missing(selection)) {
      r <- httr::GET(url, query = list(key = token))
    } else {
      if (check.selection(selection)) {
        r <-
          httr::GET(url, query = list(key = token, selections = selection))

      } else {
        logging::loginfo("No proper selection please select one valid")
      }
    }
  } else {
    logging::loginfo("No proper link please select one valid")
  }

  if (httr::status_code(r) == 200) {
    logging::loginfo(http_status(r)$message)
  } else {
    logging::logerror(http_status(r)$message)
  }

  r_content <- httr::content(r)

  return(r_content)
}

save.file <- function(prefix, dataset) {
  prefix <- paste0(prefix, Sys.Date(), ".csv")
  utils::write.csv(x = dataset, file = prefix)
}
