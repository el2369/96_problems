getwd()

#script to analyze tecan growth data

#set working directory
setwd("/Users/Erika/Documents/NYU/R_Scripts")

#import data as a matrix
growth_data<-as.matrix(read.table("EL_06262017wtwod.csv",sep=",",header = FALSE))

#input time vector and remove units
time<-gsub("s","",growth_data[1:97,1:200])

#print plots to pdf
pdf(file="Growth_TEST06.pdf")

#rows and columns of graphs on pdf
par(mfrow=c(2,3))

for(x in c(2:19,26:43,50:67)){
  plot(time,growth_data[x,1:200],main=growth_data[x,202],xlab = "Time (seconds)",ylab = "Absorbance OD (595 nm)")
}

dev.off()?

#restructure data to be compatable with package 

#appending column with well number
grofit.data<-cbind(growth_data[-1,201],as.matrix(growth_data[-1,1:200]))

grofit.data2<-cbind(growth_data[-1,201], grofit.data)


grofit.data3<-cbind(growth_data[-1,201],grofit.data2)


#write a file
write.csv(grofit.data3,file = "grofit_data.csv")

grofit.data3<-read.csv(file = "grofit_data.csv",head=TRUE)

grofit.data4<-as.matrix(as.data.frame(grofit.data3[,-1]))
#want data in data.frame class(growth.data4)


grofit.data5<-(grofit.data4[-97:-109,])

grofit.time<-(t(as.numeric(matrix(rep(time, dim(grofit.data5)[1]), c(length(time),dim(grofit.data5)[1]))))

#?matrix
#?rep



logistic.Opt<-grofit.control(smooth.gc = 0.5, interactive =FALSE,log.y.gc = TRUE,model.type = c("logistic"))

gro.cur.log<-grofit(grofit.time, grofit.data5, FALSE, logistic.Opt)


