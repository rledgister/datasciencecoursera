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