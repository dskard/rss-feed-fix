require("xml2")
require("magrittr")

# read the rss feed
feed.url <- "http://www.espn.com/espnradio/podcast/feeds/itunes/podCast?id=9941853"
feed.xml <- read_xml(feed.url)

# find and remove episodes we are not interested in
locator <- "//item/title[starts-with(text(), 'Hour')]/parent::item"
xml_find_all(feed.xml, locator)  %>%
  xml_remove()

# save the updated rss file to disk
outfile <- "lebatard.rss"
write_xml(feed.xml, outfile)
