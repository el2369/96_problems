#script to analyze tecan growth data

#set working directory
setwd("/Users/Erika/Documents/NYU/R_Scripts")

#import data as a matrix
growth_data<-as.matrix(read.table("EL_050517-3.csv",sep=",",header = FALSE))

#input time vector and remove units
time<-gsub("s","",growth_data[1,1:200])

#print plots to pdf
pdf(file="Growth_TEST10.pdf")

#rows and columns of graphs on pdf
par(mfrow=c(2,3))

for(x in c(5:13,26:31,35:37,50:61)){
  plot(time,growth_data[x,1:200],main=growth_data[x,202],xlab = "Time (seconds)",ylab = "Absorbance OD (595 nm)")
}

dev.off()




