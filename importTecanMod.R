# This is a function. You give it a file name of a ASCII TXT file
# of a run from a Tecan Sunrise, and that's formatted a certain way.
# 
# Do options to give it the "Well Data" then "Measurements",
# and tell it to record along rows. Give it time and temp, although
# we should write this so it doesn't matter for that.











importTecanMod <- function( filePath ) { 
  # A path is like a filename, but includes all the directories

  rawData <- readLines(filePath)
  rawData <- sapply(rawData,enc2utf8)
  rawDataList <- sapply(rawData,function(x){unlist(strsplit(x,"\t"))})

  rowsThatAreData <- unlist(
    lapply(rawDataList,function(x){grepl("[A-H]\\d+",x[1])}))
  rowsThatAreSeconds <- unlist(
    lapply(rawDataList,function(x){grepl("\\ds",x[2])}))
  rowsThatAreTemp <- unlist(
    lapply(rawDataList,function(x){grepl("<b0>C",x[2])}))

  print("Reading data,")
  print(paste(rawDataList[
    !rowsThatAreData&!rowsThatAreSeconds&!rowsThatAreTemp]))

  datar <- data.frame(rawDataList[rowsThatAreData])
  names(datar) <- 
    apply(datar[1,],2,function(x){return(x)[1]})
  datar <- datar[-1,]
  datar$Seconds <- gsub("s","",rawDataList[rowsThatAreSeconds][[1]])[-1]
  datar$Temperature <- gsub(" <b0>C","",rawDataList[rowsThatAreTemp][[1]])[-1]

  mdatar <- reshape2::melt(datar,id.vars=c("Temperature","Seconds"))
  mdatar$value <- as.numeric(as.character(mdatar$value))
  mdatar$Seconds <- as.numeric(as.character(mdatar$Seconds))
  mdatar$Temperature <- as.numeric(as.character(mdatar$Temperature))

  return(mdatar)
}

