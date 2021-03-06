library(stringr)

pollutantmean <- function(directory,pollutant, id=1:332) {
  dat = data.frame() #Create empty dataframe
  for(currentid in id){
    #Push data from each monitor into dat to create a complete monitor file
    filename <- paste(directory,str_pad(currentid,3,pad="0"),".csv",sep="")
    print(currentid)
    dat <- rbind(dat, read.csv(filename))
  }
  poldat <- dat[[pollutant]]
  poldat <- poldat[!is.na(poldat)]
  #Clean data and return mean
  mean(poldat)
}

complete <- function(directory,id=1:332) {
  nobs <- numeric()
  for(currentid in id){
    filename <- paste(directory,str_pad(currentid,3,pad="0"),".csv",sep="")
    print(currentid)
    moni <- read.csv(filename)
    nobs <- c(nobs,nrow(moni[complete.cases(moni),]))
  }
  data.frame(id=id,nobs=nobs)
}

cleandata <- function(directory,id=1:332){
  dat <-data.frame() #Create empty dataframe
  for(currentid in id){
    #Push data from each monitor into dat to create a complete dataframe
    filename <- paste(directory,str_pad(currentid,3,pad="0"),".csv",sep="")
    print(currentid)
    currdat <- read.csv(filename)
    dat <- rbind(dat, currdat[complete.cases(currdat),])
  }
  dat
}

corr <- function(directory, threshold = 0) {
  dat <- cleandata(directory)
  output <- numeric()
  for(i in 1:332) {
    currdat <- dat[dat$ID == i,]
    if(nrow(currdat)>threshold){
      #cprint(cor(currdat$sulfate,currdat$nitrate))
      output <- c(output, cor(currdat$sulfate,currdat$nitrate))
    }
  }
  output
}