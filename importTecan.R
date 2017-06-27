# This is a function. You give it a file name of a CSV
# of a certain 

importTecan <- function( filePath ) { 
  # A path is like a filename, but includes all the directories
  #import data as a matrix
  growth_data<-as.matrix(read.table(filePath,sep=",",header = FALSE))
  #input time vector and remove units
  #time<-gsub("s","",growth_data[1,1:200])
}

